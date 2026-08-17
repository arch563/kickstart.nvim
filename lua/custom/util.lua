-- Small helpers for managing plugins with the built-in `vim.pack` plugin manager.

---@param repo string e.g. 'user/repo'
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

--- Absolute path to a managed plugin's directory on disk.
---@param name string Plugin directory name (defaults to repo name).
---@return string
local function dir(name) return vim.fs.joinpath(vim.fn.stdpath 'data', 'site', 'pack', 'core', 'opt', name) end

---Adds plugins via `vim.pack` without prompting during startup.
---Accepts a single spec/string or a list of them.
---@param specs string|vim.pack.Spec|(string|vim.pack.Spec)[]
---@param opts table? Extra `vim.pack.add()` options.
local function add(specs, opts)
  local list = type(specs) == 'table' and vim.islist(specs) and specs or { specs }
  vim.pack.add(list, vim.tbl_extend('force', { confirm = false }, opts or {}))
end

---Runs a one-time build step for a plugin. The build only runs once per
---plugin directory (tracked via a sentinel file), so startup stays fast.
---@param name string Plugin directory name.
---@param fn fun(dirname: string) Build function. Receives the plugin's dir.
local function build(name, fn)
  local d = dir(name)
  local marker = vim.fs.joinpath(d, '.kickstart-built')
  if vim.uv.fs_stat(marker) then return end
  local ok, err = pcall(fn, d)
  if ok then
    local f = assert(io.open(marker, 'w'))
    f:close()
  else
    vim.notify(('vim.pack: build step for `%s` failed: %s'):format(name, err), vim.log.levels.WARN)
  end
end

---Runs a shell command inside a plugin's dir, raising an error on failure.
---@param d string Plugin directory.
---@param command string|string[] Command to run (string is split on whitespace).
---@return string stdout
local function shell(d, command)
  local cmd = type(command) == 'table' and command or vim.split(command, '%s+')
  local job = vim.system(cmd, { cwd = d, text = true }):wait()
  if job.code ~= 0 then
    local started = type(command) == 'table' and vim.fn.join(command, ' ') or command
    error(('%s failed (exit %s): %s'):format(started, job.code, (job.stderr or job.stdout or ''):sub(1, 200)))
  end
  return job.stdout or ''
end

return { gh = gh, dir = dir, add = add, build = build, shell = shell }