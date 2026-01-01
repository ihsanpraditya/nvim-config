-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
---------- INDEX ----------
-- DIRECTORY
-- FILES
-- BUFFER
-- SPLIT
-- TAB WINDOW
-- <ESC>
-- MISC
-- NEOVIDE
---------------------------

-- DIRECTORY
-- vim.keymap.set("n", "<leader>d", ':Explore<CR>')
vim.keymap.set("n", "<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set("n", "<leader>E", ':tabe <C-R>=expand("%:p:h") . "/" <CR>')
vim.keymap.set("n", "<leader>V", ':vsp <C-R>=expand("%:p:h") . "/" <CR>')


-- FILES
-- vim.keymap.set("n", "<leader>s", ':source<CR>') -- sourcing
vim.keymap.set("n", "<leader>w", ':write<CR>') -- saving
vim.keymap.set("n", "<leader>q", ':quit<CR>')  -- quitting
vim.keymap.set("n", "<leader>Q", ":q!<CR>")    -- force quit
-- vim.keymap.set("n", "<leader>1", ':only<CR>') -- close other windows

-- BUFFER
vim.keymap.set("n", "<leader>c", ':bdelete<CR>')     -- close current buffer
-- vim.keymap.set("n", "<leader>C", ':bdelete!<CR>')    -- force close current buffe
vim.keymap.set("n", "<leader>z", ':bprevious<CR>') -- go to previous buffer
vim.keymap.set("n", "<leader>x", ':bnext<CR>')     -- go to next buffer

-- SPLIT
vim.keymap.set("n", "<leader>vz", ':sbprevious<CR>') -- split then go to previous buffer
vim.keymap.set("n", "<leader>vx", ':sbnext<CR>')     -- split then go to next buffer
vim.keymap.set("n", "<leader>vv", ':vsplit<CR>')     -- split vertically
vim.keymap.set("n", "<leader>vh", ':split<CR>')      -- split horizontally

-- Scroll other window
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<M-j>', '<C-w>w<C-e><C-w>w', opts)
vim.keymap.set('n', '<M-k>', '<C-w>w<C-y><C-w>w', opts)
vim.keymap.set('n', '<M-d>', '<C-w>w<C-d><C-w>w', opts)
vim.keymap.set('n', '<M-u>', '<C-w>w<C-u><C-w>w', opts)
vim.keymap.set('n', '<M-f>', '<C-w>w<C-f><C-w>w', opts)
vim.keymap.set('n', '<M-b>', '<C-w>w<C-b><C-w>w', opts)

-- TAB WINDOW
vim.keymap.set("n", "<leader>s", ':tabnext<CR>')     -- go to next tab
vim.keymap.set("n", "<leader>a", ':tabprevious<CR>') -- go to previous tab
-- vim.keymap.set("n", "<S-t>", ':tabnew<CR>') -- create new tab

-- <ESC>
vim.keymap.set("i", "jk", "<Esc>")       -- map <jk> to <Esc>
vim.keymap.set("t", "jk", "<C-\\><C-n>") -- map <jk> to <Esc>

-- MISC
-- prevent mouse visual click selection
vim.keymap.set('n', '<LeftDrag>', '<LeftMouse>', { noremap = true })

-- clear search highlight
vim.keymap.set("n", "<ESC>", ':nohlsearch<CR>')

-- set pwd to the current buffer cd
vim.keymap.set("n", "<leader>.", ":lcd %:p:h<CR>")
                -- insert up blank line
vim.keymap.set("n", "<leader>O", 'O<ESC>')
-- insert down blank line
vim.keymap.set("n", "<leader>o", 'o<ESC>')

-- Improve command-line history navigation
vim.keymap.set('c', '<C-p>', '<Up>', {  noremap = true, desc = 'Prev matching command' })
vim.keymap.set('c', '<C-n>', '<Down>', {  noremap = true, desc = 'Next matching command' })

-- clever tab indent
-- see: insert.txt +686
-- commented because it triggered event after whitespace if the line is not empty
-- function CleverTab()
--     local line = vim.api.nvim_get_current_line()
--     local col = vim.api.nvim_win_get_cursor(0)[2]  -- col is 0-based
--     local text_before_cursor = line:sub(1, col)
--     if text_before_cursor:match('^ *$') then
--         return "\t"
--     else
--         return vim.api.nvim_replace_termcodes("<C-n>", true, true, true)
--     end
-- end
--
-- vim.keymap.set('i', '<Tab>', function() return CleverTab() end, {expr = true})

-- NEOVIDE
if vim.g.neovide then
  vim.keymap.set('n', '<C-S-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<C-S-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<C-S-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<C-S-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<C-S-v>', '<C-r>+')      -- Paste command mode
  vim.keymap.set('i', '<C-S-v>', '<ESC>l"+Pli') -- Paste insert mode

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap('', '<C-S-v>', '+p<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('!', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('t', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
end

-- NOTE check this out
-- Twiddle Case Function
-- function TwiddleCase(str)
--   local result
--   if str:upper() == str then
--     result = str:lower()
--   elseif str:lower() == str then
--     result = str:gsub("(%w+)", function(word) return word:sub(1, 1):upper() .. word:sub(2) end)
--   else
--     result = str:upper()
--   end
--   return result
-- end

-- NOTE check this out
-- Mapping for visual mode
-- vim.keymap.set("v", '~', function()
--   return TwiddleCase(vim.fn.getreg('"'))
-- end)
