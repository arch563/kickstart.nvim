--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    This config uses the built-in `vim.pack` plugin manager (introduced in
    Neovim 0.12). See `:help vim.pack`, `:help vim.pack-examples` or the
    excellent guide from the creator of vim.pack and mini.nvim:
    https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack

    To inspect plugin state and pending updates, run
      :lua vim.pack.update(nil, { offline = true })

    To update plugins, run
      :lua vim.pack.update()

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Enable faster startup by caching compiled Lua modules.
vim.loader.enable()

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings
-- ============================================================

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.o.background = 'dark'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'` and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options` and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.conceallevel = 2

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>')

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ============================================================
-- SECTION 3: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================

-- Plugins are managed by the built-in `vim.pack` plugin manager. To install a
-- plugin, pass its git URL to `vim.pack.add()`. Setups run right after, since
-- `:packadd` makes the plugin's files available on the runtimepath.
--
-- The helpers below come from `lua/custom/util.lua` (which also handles
-- one-time build steps and disables the interactive install prompt).

local util = require 'custom.util'
local gh = util.gh

-- [[ guess-indent.nvim ]] Automatically detect and set the indentation.
util.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- [[ gitsigns.nvim ]] Adds git related signs to the gutter, as well as utilities for managing changes.
-- See `:help gitsigns` to understand what each configuration key does.
util.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' }, ---@diagnostic disable-line: missing-fields
    change = { text = '~' }, ---@diagnostic disable-line: missing-fields
    delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
    topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
    changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
  },
}

-- [[ which-key.nvim ]] Useful plugin to show you pending keybinds.
-- Delay between pressing a key and opening which-key (milliseconds)
util.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}

-- [[ Colorscheme ]]
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
util.add { gh 'folke/tokyonight.nvim' }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}
-- The actual colorscheme (`everforest`) is set at the bottom of this file,
-- after the `everforest` plugin has been installed by the custom plugin scope.

-- [[ todo-comments.nvim ]] Highlight todo, notes, etc in comments
util.add { gh 'folke/todo-comments.nvim', gh 'nvim-lua/plenary.nvim' }
require('todo-comments').setup { signs = true }

-- [[ mini.nvim ]] A collection of various small independent plugins/modules
util.add { gh 'nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Statusline is provided by lualine.nvim configured in
-- `lua/custom/plugins/lualine.lua` (which also integrates sidekick.nvim).

-- ============================================================
-- SECTION 4: SEARCH & NAVIGATION
-- fff.nvim, telescope, fzf-lua
-- ============================================================

-- [[ fff.nvim ]] Fast file/content search
util.add { gh 'dmtrKovalenko/fff.nvim' }
util.build('fff.nvim', function()
  -- Downloads/builds the bundled `fff` binary if it's not present yet.
  pcall(require('fff.download').download_or_build_binary)
end)
require('fff').setup {
  prompt = '> ',
}

-- [[ Telescope ]] A fuzzy finder for files, LSP symbols and many other things.
--
-- NOTE: You can install multiple plugins at once.
local telescope_plugins = {
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
}
if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end
util.add(telescope_plugins)
util.build('telescope-fzf-native.nvim', function(dir)
  if vim.fn.executable 'make' ~= 1 then return end
  util.shell(dir, 'make')
end)

-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    -- Find references for the word under your cursor.
    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    -- Jump to the implementation of the word under your cursor.
    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    -- Jump to the definition of the word under your cursor.
    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    -- Fuzzy find all the symbols in your current document.
    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    -- Fuzzy find all the symbols in your current workspace.
    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    -- Jump to the type of the word under your cursor.
    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

-- [[ fzf-lua ]] Pickers for editor-local queries.
--  Loaded after Telescope so these share the `<leader>s` prefix and win on conflicts.
util.add { gh 'ibhagwan/fzf-lua', gh 'nvim-tree/nvim-web-devicons' }

local fff = require 'fff'
local fzf = require 'fzf-lua'

local function get_visual_selection()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lines = vim.api.nvim_buf_get_text(0, start_pos[2] - 1, start_pos[3] - 1, end_pos[2] - 1, end_pos[3], {})
  return table.concat(lines, '\n')
end

local function grep_current_selection_or_word()
  local mode = vim.fn.mode()
  local query = (mode == 'v' or mode == 'V' or mode == '\22') and get_visual_selection() or vim.fn.expand '<cword>'
  fff.live_grep { query = query }
end

fzf.setup {
  winopts = { preview = {} },
  files = { fd_opts = '--type f --hidden --follow --exclude .git' },
}

vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', fff.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf-lua' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', grep_current_selection_or_word, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', fff.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', fzf.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', function() fzf.live_grep_glob { grep_opts = '--open-files' } end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function() fff.find_files_in_dir(vim.fn.stdpath 'config') end, { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>sK', function() fff.find_files_in_dir(vim.fn.expand '~/skills/skills') end, { desc = '[S]earch s[K]ills files' })

-- ============================================================
-- SECTION 5: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================

-- [[ Main LSP Configuration ]]
-- Brief aside: **What is LSP?**
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

-- Mason must be loaded before its dependents.
util.add {
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'j-hui/fidget.nvim',
}

-- Automatically install LSPs and related tools to stdpath for Neovim
require('mason').setup {}

-- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
require('mason-lspconfig').setup {
  automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
}

-- Useful status updates for LSP.
require('fidget').setup {}

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('grd', vim.lsp.buf.definition, '[G]oto [d]efinition')

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
        end,
      })
    end
    if client.name == 'markdown_oxide' then
      vim.api.nvim_create_user_command('Daily', function(args)
        local input = args.args

        vim.lsp.buf.execute_command { command = 'jump', arguments = { input } }
      end, { desc = 'Open daily note', nargs = '*' })
    end
    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  See `:help lsp-config` for information about keys and how to configure
---@type table<string, vim.lsp.Config>
local servers = {
  clangd = {
    cmd = { 'clangd', '--query-driver=/home/archie/.platformio/packages/toolchain-*/bin/*' },
  },
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`ts_ls`) will work just fine
  -- ts_ls = {},
  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
  },
  ty = {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'ty.toml', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
    diagnosticMode = 'workspace',
  },
  harper_ls = { cmd = { 'harper-ls', '--stdio' }, filetypes = { 'markdown', 'text' } },
  markdown_oxide = {
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    root_markers = { '.git', '.obsidian', '.moxide.toml' },
    capabilities = vim.tbl_deep_extend('force', capabilities, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
  },
  stylua = {}, -- Used to format Lua code
  azure_pipelines_ls = {
    cmd = { 'azure-pipelines-language-server', '--stdio' },
    filetypes = { 'yaml' },
    root_markers = { 'azure-pipelines.yml' },
    settings = {},
  }, -- Used to format Lua code

  -- Special Lua Config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
}

-- Ensure the servers and tools above are installed
--
-- To check the current status of installed tools and/or manually install
-- other tools, you can run
--    :Mason
--
-- You can press `g?` for help in this menu.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  -- You can add other tools here that you want Mason to install
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- ============================================================
-- SECTION 6: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================

-- [[ Formatting ]]
util.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- You can specify filetypes to autoformat on save here:
    local enabled_filetypes = {
      -- lua = true,
      -- python = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
  },
  -- You can also specify external formatters in here.
  formatters_by_ft = {
    -- rust = { 'rustfmt' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })

-- ============================================================
-- SECTION 7: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================

-- [[ Snippet Engine ]]

-- NOTE: Version ranges map to git tags via `vim.version.range`.

-- LuaSnip
util.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
util.build('LuaSnip', function(dir)
  -- Build step is needed for regex support in snippets.
  -- This step is not supported in many windows environments.
  if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
  util.shell(dir, 'make install_jsregexp')
end)
require('luasnip').setup {}

-- `friendly-snippets` contains a variety of premade snippets.
--    See the README about individual language/framework/plugin snippets:
--    https://github.com/rafamadriz/friendly-snippets
-- util.add { gh 'rafamadriz/friendly-snippets' }
-- require('luasnip.loaders.from_vscode').lazy_load()

-- [[ blink.compat ]] Enables non-blink source plugins (e.g. copilot) to work with blink.cmp.
-- It must be set up before blink.cmp, which is why it lives here.
util.add { { src = gh 'saghen/blink.compat', version = vim.version.range '2.*' } }
pcall(require('blink.compat').setup)

-- [[ Autocomplete Engine ]]
util.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    -- 'default' (recommended) for mappings similar to built-in completions
    --   <c-y> to accept ([y]es) the completion.
    --    This will auto-import if your LSP supports it.
    --    This will expand snippets if the LSP sent a snippet.
    -- 'super-tab' for tab to accept
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'super-tab',

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',
  },

  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = true, auto_show_delay_ms = 300 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}

-- ============================================================
-- SECTION 8: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================

-- [[ Configure Treesitter ]]
--  Used to highlight, edit, and navigate code
--
--  See `:help nvim-treesitter-intro`

-- NOTE: Pin the parser on Neovim < 0.12 (mirrors the lazy.nvim-era config),
-- and track `main` on newer releases.
util.add {
  {
    src = gh 'nvim-treesitter/nvim-treesitter',
    version = vim.fn.has 'nvim-0.12' == 0 and '7caec274fd19c12b55902a5b795100d21531391f' or 'main',
  },
}

-- Ensure basic parsers are installed
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  -- Check if a parser exists and load it
  if not vim.treesitter.language.add(language) then return end
  -- Enable syntax highlighting and other treesitter features
  vim.treesitter.start(buf, language)

  -- Enable treesitter based folds
  -- For more info on folds see `:help folds`
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- Check if treesitter indentation is available for this language, and if so enable it
  -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
  local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

  -- Enable treesitter based indentation
  if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
end

local available_parsers = require('nvim-treesitter').get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed_parsers, language) then
      -- Enable the parser if it is already installed
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
      require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
    else
      -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
      treesitter_try_attach(buf, language)
    end
  end,
})

-- ============================================================
-- SECTION 9: OPTIONAL KICKSTART PLUGINS
-- kickstart.plugins.* examples
-- ============================================================

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the Kickstart repository.
--  Comment out any of the lines below to disable them (you will need to restart nvim).
--
require 'kickstart.plugins.debug'
require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.lint'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'
require 'kickstart.plugins.gitsigns' -- adds gitsigns recommended keymaps

-- ============================================================
-- SECTION 10: CUSTOM PLUGINS
-- Every file in `lua/custom/plugins/*.lua` is loaded, which installs and
-- configures the plugins via `vim.pack` (see `lua/custom/util.lua`).
-- ============================================================
require 'custom.plugins'

-- ============================================================
-- SECTION 11: CUSTOM COMMANDS & MISC
-- ============================================================

local ready_patterns = {
  ['print'] = 'print%s*%(',
  ['for i in'] = 'for%s+i%s+in',
  ['LOGGER'] = 'LOGGER%.',
  ['logger'] = 'logger%.',
  ['#'] = '#%.',
  ['GetLogger'] = 'getLogger%.',
  -- Add more patterns here as needed
}

local function shell_quote(str) return "'" .. str:gsub("'", "'\\\"'\\\"'") .. "'" end

local function run_cmd(cmd)
  local handle = io.popen(cmd)
  if not handle then return nil end
  local output = handle:read '*a' or ''
  handle:close()
  return output
end

vim.api.nvim_create_user_command('ReadyForPR', function()
  local merge_base = run_cmd 'git merge-base main HEAD'
  if not merge_base or merge_base == '' then
    vim.notify('Could not determine merge-base with main', vim.log.levels.ERROR)
    return
  end
  merge_base = merge_base:gsub('%s+$', '')

  local changed_output = run_cmd(string.format('git diff --name-only --diff-filter=ACMR %s -- "*.py"', shell_quote(merge_base)))
  if changed_output == nil then
    vim.notify('Failed to list changed files', vim.log.levels.ERROR)
    return
  end

  local untracked_output = run_cmd 'git ls-files --others --exclude-standard -- "*.py"'
  if untracked_output == nil then
    vim.notify('Failed to list untracked files', vim.log.levels.ERROR)
    return
  end

  local files = {}
  local untracked = {}
  for filename in changed_output:gmatch '[^\r\n]+' do
    files[filename] = true
  end
  for filename in untracked_output:gmatch '[^\r\n]+' do
    files[filename] = true
    untracked[filename] = true
  end

  local has_files = false
  for _ in pairs(files) do
    has_files = true
    break
  end

  if not has_files then
    vim.notify('No changed Python files vs main (including untracked)', vim.log.levels.INFO)
    return
  end

  local qf_list = {}

  for filename in pairs(files) do
    local changed_set = {}

    if untracked[filename] then
      local file = io.open(filename, 'r')
      if file then
        local lnum = 0
        for _ in file:lines() do
          lnum = lnum + 1
          changed_set[lnum] = true
        end
        file:close()
      end
    else
      local diff_cmd = string.format('git diff -U0 %s -- %s', shell_quote(merge_base), shell_quote(filename))
      local diff_output = run_cmd(diff_cmd)
      if diff_output then
        for hunk in diff_output:gmatch '@@.-@@' do
          local start, count = hunk:match '%+(%d+),?(%d*)'
          start = tonumber(start)
          count = tonumber(count) or 1
          if start and count > 0 then
            for i = 0, count - 1 do
              changed_set[start + i] = true
            end
          end
        end
      end
    end

    local file = io.open(filename, 'r')
    if file then
      local lnum = 0
      for line in file:lines() do
        lnum = lnum + 1
        if changed_set[lnum] then
          for name, pattern in pairs(ready_patterns) do
            local s = line:find(pattern)
            if s then
              table.insert(qf_list, {
                filename = filename,
                lnum = lnum,
                col = s,
                text = string.format('[%s] %s', name, line),
              })
            end
          end
        end
      end
      file:close()
    end
  end

  if #qf_list == 0 then
    vim.notify('No PR-blocking patterns found in changed lines of .py files', vim.log.levels.INFO)
    return
  end

  vim.fn.setqflist(qf_list, 'r')
  vim.cmd.copen()
end, { desc = 'Quickfix: PR-blocking patterns in changed lines of .py files' })

vim.api.nvim_create_user_command('ChangePythonPath', function()
  local cwd = vim.fn.getcwd()
  local existing = vim.env.PYTHONPATH

  vim.env.PYTHONPATH = cwd

  vim.notify('PYTHONPATH set to: ' .. vim.env.PYTHONPATH, vim.log.levels.INFO)
end, { desc = 'Set PYTHONPATH to current working directory' })

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  pattern = '*',
  callback = function()
    -- Check if 'Dockerfile' exists in the current working directory
    local stat = vim.uv.fs_stat(vim.fn.getcwd() .. '/Dockerfile')

    if stat and stat.type == 'file' then
      -- Get current folder name to use as a dynamic image tag
      local current_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      vim.opt.makeprg = ' sudo DOCKER_BUILDKIT=1  docker build --progress=plain --secret id=uv_index_siriuspython_password,env=AZURE_ARTIFACTS_PAT --build-arg UV_INDEX_SIRIUSPYTHON_USERNAME=VssSessionToken -f docker/Dockerfile  -t ' .. current_dir .. ':latest'
    else
      -- Fallback to the default system 'make' utility
      vim.opt.makeprg = 'make'
    end
  end,
})

vim.opt.grepprg =
  'rg --vimgrep --glob=!**/.venv/** --glob=!.venv/** --glob=!.mypy_cache/** --glob=!**/.mypy_cache/** --glob=!**/worktrees/** --glob=!venv/** --glob=!worktrees/** --glob=!**/.pytest_cache/** --glob=!tmp/** --glob=!.omo/** --glob=!.codegraph/ -uu'

vim.keymap.set('n', '<leader>zp', function() require('nvim_ssh').start() end, { desc = 'Zellij SSH picker' })

-- The last plugin installed by the custom scope is the `everforest` colorscheme,
-- so we only apply it here at the very end of the config.
vim.cmd.colorscheme 'everforest'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et