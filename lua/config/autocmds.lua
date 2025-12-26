-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line_num = vim.fn.line("'\"")
    if line_num > 1 and line_num <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "TelescopeResults" },
  callback = function()
    vim.opt_local.foldenable = false
  end
})

-- these codes below are from https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1676#discussioncomment-12068158
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'neo-tree-preview', 'neo-tree'},
  callback = function(args)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      buffer = args.buf,
      once = true,
      callback = function() 
        vim.wo[0].foldmethod = 'manual' 
        vim.opt_local.foldenable = false
      end,
    })
  end,
})

-- Toggle LSP diagnostics
vim.api.nvim_create_user_command('ToggleDiagnostics', function()
    local current_state = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not current_state)
    print("Diagnostics " .. (current_state and "disabled" or "enabled"))
end, {})

-- Disable folding in Telescope's result window.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ledger" },
  callback = function()
    vim.o.shiftwidth = 2
  end
})
