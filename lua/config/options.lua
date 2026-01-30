-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
---------- INDEX ----------
-- MOUSE
-- NUMBER
-- TAB
-- MATCHIT
-- UNDO/REDO
-- BACKUP
-- SEARCHING
-- CONCEAL
-- FOLDING
-- UPDATETIME
-- COLORCOLUMN
-- COMPLETION
-- DIRECTORY MODE
-- PROVIDER
-- TERMGUICOLORS
-- COLOR
-- NEOVIM FUNCTION
-- COLOR LIST
-- NEOVIDE
---------------------------

-- MOUSE
vim.o.mouse = "a"
vim.o.mousemoveevent = true

-- TEXT
vim.o.textwidth = 80

-- NUMBER
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false

-- TAB
-- always insert spaces
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- MATCHIT
vim.g.loaded_matchit = 1

-- UNDO / REDO
-- vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true -- undo history persists although exiting the buffer.

-- BACKUP
vim.o.backup = false
vim.o.swapfile = false

-- SEARCHING
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- CONCEAL
vim.opt.conceallevel = 2
vim.opt.concealcursor = ''

-- FOLDING
vim.g.markdown_folding = 1
vim.g.org_folding = 1
vim.g.org_indent_mode = 0
vim.o.foldmethod = 'indent'
vim.o.foldenable = false

-- UPDATETIME
vim.o.updatetime = 50

-- COLORCOLUMN
-- vim.o.colorcolumn = "80" -- show vertical line in column 80

-- COMPLETION
-- vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.o.wildignorecase = true -- for file completion
vim.opt.wildignore:append {
  '*~',
  '*.log',
  '*.tmp',
  '/tmp/*',
  '/temp/*',
  '**/node_modules/**',
  '**/.git/**',
  '*.swp',
  '*.bak',
  'tags'
}
vim.opt.complete:remove('t') -- disable tag in i_CTRL-N/P

-- DIRECTORY MODE
vim.g.netrw_bufsettings = "noma nomod nonu nobl nowrap ro rnu"

-- PROVIDER
if vim.fn.has('win32') or vim.loop.os_uname().sysname == "Windows_NT" then
  vim.g.python3_host_prog = vim.fn.substitute(vim.fn.exepath("python"), ".exe$", '', 'g')
  vim.g.node_host_prog = "C:/Users/ACER/AppData/Roaming/npm/node_modules/neovim/bin/cli.js"
  -- vim.g.loaded_node_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_ruby_provider = 0
end

-- TERMGUICOLORS
if vim.env.TERM == "alacritty" then
    vim.opt.termguicolors = true
end

-- COLOR
if vim.g.colors_name == "desert"
then
  vim.opt.background = "light"
else
  vim.opt.background = "dark"
end

-- NEOVIM FUNCTION
HorColort("default")
----- light color -----
-- Blue (but set bg to dark, wkwk)
-- delek 
-- morning(not too light, good for night shift) 
-- peachpuff 
-- shine(dont use)
-- zellner 

-- COLOR LIST
----- dark color -----
-- Andromeda
-- DarkBlue
-- desert
-- elflord
-- evening
-- habamax
-- industry
-- koehler
-- macvim (not too good for gitgutter)
-- murphy
-- pablo
-- ron
-- slate (looks modern but light)
-- sorbet (beautiful purple)
-- torte
-- molokai
-- zaibatsu (more beautiful purple)

----- ambi color -----
-- lunaperche
-- PaperColor
-- quiet (no syntax)
-- retrobox
-- solarized
-- wildcharm

-- NEOVIDE
if vim.g.neovide then
  vim.cmd.cd('~') -- set directory to HOME
  vim.g.neovide_transparency = 0.9
  vim.g.transparency = 0.0
  -- vim.o.lines = 20
  -- vim.o.columns = 60
  vim.o.guifont = "CaskaydiaMono NFM:h10"

  -- floating blur amount
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- popupmenu transparency
  vim.o.pumblend = 30

  -- hiding the mouse when typing
  vim.g.neovide_hide_mouse_when_typing = true

  -- remember previous window size
  -- vim.g.neovide_remember_window_size = true
end
