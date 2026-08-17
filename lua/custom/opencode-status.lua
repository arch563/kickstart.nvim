-- Tracks the busy/idle state of an attached opencode server by subscribing to
-- its SSE event stream (`GET /event`). Mirrors how sidekick surfaces Copilot's
-- `didChangeStatus` busy state, but for opencode.
--
-- The opencode port is discovered through `sidekick.cli.session`, so this
-- works out of the box for sessions managed by sidekick.nvim.

local OC = {}

local SPINNER = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }
local DONE_ICON = '󰄴 '

OC.busy = false
OC.connected = false
OC.frame = 0
OC._job = nil
OC._timer = nil

local function lualine_refresh()
  vim.schedule(function()
    pcall(function() require('lualine').refresh() end)
    vim.cmd.redrawstatus()
  end)
end

local function notify(msg, level, title)
  vim.schedule(function()
    pcall(function() vim.notify(msg, level, { title = title }) end)
  end)
end

local function change(busy)
  local prev = OC.busy
  OC.busy = busy
  if prev == busy then
    return
  end
  if not prev and busy then
    lualine_refresh()
  elseif prev and not busy then
    notify('opencode: task finished', vim.log.levels.INFO, 'opencode')
    vim.schedule(function()
      vim.api.nvim_exec_autocmds('User', { pattern = 'OpenCodeIdle' })
    end)
    lualine_refresh()
  end
end

local function handle_event(payload)
  local ok, ev = pcall(vim.json.decode, payload)
  if not ok or type(ev) ~= 'table' or type(ev.type) ~= 'string' then
    return
  end
  local props = type(ev.properties) == 'table' and ev.properties or {}
  local t = ev.type

  if t == 'session.status' then
    local s = props.status
    local busy
    if type(s) == 'table' then
      busy = s.type == 'busy'
    elseif type(s) == 'string' then
      busy = s == 'busy'
    elseif type(s) == 'boolean' then
      busy = s
    end
    if busy ~= nil then
      change(busy)
    end
  elseif t == 'session.idle' then
    change(false)
  elseif t == 'session.error' then
    OC.busy = false
    notify('opencode: ' .. tostring(props.error or 'error'), vim.log.levels.ERROR, 'opencode')
    lualine_refresh()
  end
end

local function on_stdout(_, data)
  if not data then
    return
  end
  for _, line in ipairs(data) do
    if line:sub(1, 6) == 'data: ' then
      handle_event(vim.trim(line:sub(7)))
    end
  end
end

local function base_url()
  local ok, sessions = pcall(function() return require('sidekick.cli.session').sessions() end)
  if not ok or type(sessions) ~= 'table' then
    return nil
  end
  for _, s in ipairs(sessions) do
    local name = type(s.tool) == 'table' and s.tool.name or s.tool
    if name == 'opencode' and type(s.base_url) == 'string' then
      return s.base_url
    end
  end
  return nil
end

local function connect()
  local url = base_url()
  if not url then
    OC.connected = false
    local timer = vim.uv.new_timer()
    timer:start(3000, 0, function()
      timer:stop()
      timer:close()
      connect()
    end)
    return
  end

  OC._job = vim.fn.jobstart({ 'curl', '-sN', '-H', 'Accept: text/event-stream', url .. '/event' }, {
    on_stdout = on_stdout,
    on_exit = function()
      OC.connected = false
      vim.schedule(connect)
    end,
    stdout_buffered = false,
  })
  OC.connected = OC._job > 0
end

--- Start the watcher (idempotent).
function OC.start()
  if OC._timer then
    return
  end
  connect()
  OC._timer = vim.uv.new_timer()
  OC._timer:start(700, 700, function()
    OC.frame = OC.frame + 1
    if OC.busy then
      vim.cmd.redrawstatus()
    end
  end)
end

--- Stop the watcher and close the SSE connection.
function OC.stop()
  if OC._timer then
    OC._timer:stop()
    OC._timer:close()
    OC._timer = nil
  end
  if OC._job then
    vim.fn.jobstop(OC._job)
    OC._job = nil
  end
  OC.connected = false
  OC.busy = false
end

---@return boolean whether an opencode session is present/idle-or-busy
function OC.has_session()
  return OC.connected or OC.busy
end

--- lualine component: spinner while busy, checkmark when idle, else nothing.
function OC.component()
  if OC.busy then
    local f = OC.frame % #SPINNER + 1
    return SPINNER[f]
  end
  if OC.connected then
    return DONE_ICON
  end
  return ''
end

return OC