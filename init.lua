-- Install packer
-- TODO: get a filebrowser or configure Netrw
--      config formatter
--      config the pluggins that need to work on save
--      config git fugitive
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'b3nj5m1n/kommentary' -- Upgraded vim-commentary
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'sainnhe/everforest' -- Theme
  use "hoob3rt/lualine.nvim" -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'tpope/vim-surround'
  use 'windwp/nvim-autopairs'
  use 'mhartington/formatter.nvim'
end)

-- general shortcuts
local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Enable break indent
vim.o.breakindent = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

opt.backspace = { "indent", "eol", "start" }
-- opt.clipboard = "unnamedplus" 
opt.completeopt = "menuone,noselect" -- for better autocomplete experience
opt.cursorline = true
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.expandtab = true -- Use spaces instead of tabs
opt.foldenable = false
opt.foldmethod = "indent"
opt.formatoptions = "l"
opt.hidden = true -- Enable background buffers
opt.hlsearch = true -- Highlight found searches
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- Get a preview of replacements
opt.incsearch = true -- Shows the match while typing
opt.joinspaces = false -- No double spaces with join
opt.linebreak = true -- Stop words being broken on wrap
opt.list = false -- Show some invisible characters
opt.number = true -- Show line numbers
opt.rnu = true -- Show line numbers
opt.numberwidth = 5 -- Make the gutter wider by default
opt.scrolloff = 4 -- Lines of context
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Don't display mode
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartcase = true -- Do not ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.wrap = false
opt.cc = "80"
opt.mouse = "a"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
g.everforest = 2
cmd([[colorscheme everforest]])

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '

-- General keymaps
map("i","jk", "<c-c>")
map("i","kj", "<c-c>")

-- Open vertical split
map("n","<leader>v", "<cmd>:vs<CR>")
-- Buffer Movement
map("n","<tab>", "<cmd>bp<cr>")
map("n","<s-tab>", "<cmd>bn<cr>")

-- Split movement
map("n","<c-h>", "<c-w>h")
map("n","<c-j>", "<c-w>j")
map("n","<c-k>", "<c-w>k")
map("n","<c-l>", "<c-w>l")

-- Shortcut to open this
map("n","<leader>vrc", "<cmd>e C:/Users/jnevessi/Documents/dotfiles/init.lua<CR>")

-- yank till end of line
map("n", "Y", "y$")

-- Make visual yanks keep cursor position
map("v", "y", "ygv<Esc>")

-- R to search and replace All
map("n", "R", ":%s/")
map("v", "R", ":s/")

-- keep search results centered
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- After search press esc to stop highlight
map("n", "<Esc>", ":noh<cr><esc>", {silent = true})

--Map blankline
g.indent_blankline_char = '┊'
g.indent_blankline_filetype_exclude = { 'help', 'packer' }
g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
g.indent_blankline_char_highlight = 'LineNr'
g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        --[[ ["<c-j>"] = actions.
        ["<c-k>"] = actions. ]]
      },
    },
  },
}

path_display = function(opts, path)
  local tail = require("telescope.utils").path_tail(path)
  return string.format("%s (%s)", tail, path)
 end

-- Add leader shortcuts
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers(path_display = path_display)<CR>]])
map('n', '<leader>p', [[<cmd>lua require('telescope.builtin').find_files({path_display = path_display})<CR>]])
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').live_grep(path_display = path_display)<CR>]])
map('n', '<leader>e', [[<cmd>lua require('telescope.builtin').file_browser(path_display = path_display)<CR>]])
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(path_display = path_display)<CR>]], { noremap = true, silent = true })
map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string(path_display = path_display)<CR>]], { noremap = true, silent = true })

map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
-- map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
-- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

--[[ -- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end ]]

require("lspconfig").tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- luasnip setup
local luasnip = require 'luasnip'

-- Compe setup start
require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
    luasnip = true,
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-n>")
  elseif check_back_space() then
    return t("<Tab>")
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t("<C-p>")
  else
    return t("<S-Tab>")
  end
end

vim.api.nvim_set_keymap("i", "<c-j>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<c-j>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<c-k>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<c-k>", "v:lua.s_tab_complete()", { expr = true })

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })

-- Auto Pairs with compe support
require("nvim-autopairs").setup({})
require("nvim-autopairs.completion.compe").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true, -- auto select first item
})
-- End Compe related setup

local prettierConfig = function()
  return {
    function()
      return {
        exe = "npx prettier",
        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--config .prettierrc"},
        stdin = true
      }
    end
  }
end

-- Formatter config
require('formatter').setup({
  filetype = {
    javascript = prettierConfig(),
    typescript = prettierConfig(),
    html = prettierConfig(),
    scss = prettierConfig(),
  }
})

-- location icon: 
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "onedark",
    component_separators = { " ", " " },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode", "paste" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", color_added = "#a7c080", color_modified = "#ffdf1b", color_removed = "#ff6666" },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_lsp" } },
      function()
        return "%="
      end,
      "filename",
      { getWords },
    },
    lualine_x = { "filetype" },
    lualine_y = {
      {
        "progress",
      },
    },
    lualine_z = {
      {
        "location",
        icon = "",
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})

-- Highlight on yank disabled in visual mode
cmd("au TextYankPost * lua vim.highlight.on_yank {on_visual = true}")

-- Run Formatter and save
map("n","<leader>w", "<cmd>w!<CR><cmd>FormatWrite<CR>")

-- test for data replacement
map("n","<leader>w", "<cmd>w!<CR><cmd>FormatWrite<CR>")

map('n', '<leader>tt', 'S* Last Modified: <c-r>=modifiedDate<cr><esc>guiw')
map("n","<leader>hh", "mm<cmd>g/ * Last Modified/norm 1 tt<cr>'m")

-- thing to try and get ordinal numbers on date
function day_ordinal(dayn)
    last_digit = dayn % 10
    if last_digit == 1 and dayn ~= 11
        then return 'st'
    elseif last_digit == 2 and dayn ~= 12
        then return 'nd'
    elseif last_digit == 3 and dayn ~= 13
        then return 'rd'
    else 
        return 'th'
    end
end

function timef(datestr,date)
    datestr = string.gsub(datestr,"%%o",day_ordinal(date.day))
    return os.date(datestr,os.time(datedate))
end 

date = os.date("*t",os.time())
cTime = timef("%A, %d%o %B %Y %r",date)
vim.g.modifiedDate = timef("%A, %d%o %B %Y %r",date)

-- Format on save
--[[ vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.css,*.scss,*.html FormatWrite
augroup END
], true)
 --]]

print('init.lua loaded')
