local M = {}
function M.setup()
  vim.cmd [[
     highlight NeotestPassed guifg=#A6E22E
     highlight NeotestFailed guifg=#F92672
     highlight NeotestRunning guifg=#FD971F
   ]]
end
return M
