local M = {}

local function has_zellij_session(session_name)
  local result = vim.system({ 'zellij', 'list-sessions' }, { text = true }):wait()
  if result.code ~= 0 then return false, result.stderr or result.stdout or '' end

  local output = result.stdout or ''
  for line in output:gmatch '[^\r\n]+' do
    if line:match('^' .. vim.pesc(session_name) .. '%s') or line:match('^' .. vim.pesc(session_name) .. '$') then return true, output end
  end

  return false, output
end

local function read_ssh_hosts()
  local hosts = {}
  local config = vim.fn.expand '~/.ssh/config'

  if vim.fn.filereadable(config) == 1 then
    for line in io.lines(config) do
      local rest = line:match '^%s*Host%s+(.+)$'
      if rest then
        for host in rest:gmatch '%S+' do
          if host ~= '*' and host ~= '?' then table.insert(hosts, host) end
        end
      end
    end
  end

  return hosts
end

local function open_zellij_with_ssh(session_name, ssh_target)
  -- On Windows, use cmd/pwsh only if necessary; here we launch zellij directly.
  -- Adjust this command depending on how your zellij integrates with terminals on Windows.
  vim.system({ 'zellij', 'attach', session_name }, { detach = true })

  -- If you specifically need SSH inside a new pane, that part depends on how zellij is started
  -- in your terminal. This is a safe fallback that at least attaches the session.
  vim.schedule(function() vim.notify('Attached to zellij session: ' .. session_name .. ' (target: ' .. ssh_target .. ')', vim.log.levels.INFO) end)
end

function M.start()
  local session_name = 'nvim-ssh'
  local exists = has_zellij_session(session_name)

  if exists then
    open_zellij_with_ssh(session_name)
    return
  end

  local hosts = read_ssh_hosts()
  if #hosts == 0 then
    vim.notify('No SSH hosts found in ~/.ssh/config', vim.log.levels.WARN)
    return
  end

  vim.ui.select(hosts, {
    prompt = 'Select SSH host',
  }, function(choice)
    if not choice then return end

    -- Create the session and attach. SSH launch behavior may need to be adapted
    -- to your exact Windows Terminal / Zellij setup.
    vim.system({ 'zellij', 'run', '--name', session_name, '--', 'ssh', choice }, { detach = true })
    vim.notify('Started zellij session ' .. session_name .. ' for ' .. choice, vim.log.levels.INFO)
  end)
end

return M
