-- INDEX
-- bufferline (tab bar)
-- lualine (status bar)
-- themes:
-- rose-pine
-- dracula
-- nightfox
-- tokyonight
-- oxocarbon
-- midnight
-- monokai-pro
-- vim-enfocado
return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        mode = "tabs" -- set to "tabs" to only show tabpages instead
      }
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = {
          function()
            local ok, pomo = pcall(require, "pomo")
            if not ok then
              return ""
            end

            local timer = pomo.get_first_to_finish()
            if timer == nil then
              return ""
            end

            return "󰄉 " .. tostring(timer)
          end,
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location',
          -- function() -- i'm using time and calc in tmux
          --   return vim.fn.strftime("%H:%M")
          -- end
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename', 'diagnostics' },
        lualine_x = {},
        lualine_y = { 'location' },
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { 'fugitive' }
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { 'Mofiqul/dracula.nvim' },
  { 'EdenEast/nightfox.nvim' },
  { 'folke/tokyonight.nvim' },
  { 'nyoom-engineering/oxocarbon.nvim' },
  { 'dasupradyumna/midnight.nvim' },
  {'loctvl842/monokai-pro.nvim'},
  {'wuelnerdotexe/vim-enfocado'},
}
