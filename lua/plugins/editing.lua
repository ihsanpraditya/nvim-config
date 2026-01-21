-- INDEX
-- fugitive
-- rhubarb
-- diffview
-- tabular
-- illuminate
-- sleuth
-- multi cursor
-- gitsigns
--
return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "sindrets/diffview.nvim" },
  { "godlygeek/tabular" },
  { "RRethy/vim-illuminate" },
  { "tpope/vim-sleuth" }, -- Heuristically set buffer options
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({"n", "x"}, "<c-k>", function() mc.lineAddCursor(-1) end)
      set({"n", "x"}, "<c-j>", function() mc.lineAddCursor(1) end)
      set({"n", "x"}, "<c-s-k>", function() mc.lineSkipCursor(-1) end)
      set({"n", "x"}, "<c-s-j>", function() mc.lineSkipCursor(1) end)

      -- Add or skip adding a new cursor by matching word/selection
      set({"n", "x"}, "gl", function() mc.matchAddCursor(1) end)
      set({"n", "x"}, "gL", function() mc.matchAddCursor(-1) end)
      set({"n", "x"}, "g>", function() mc.matchSkipCursor(1) end)
      set({"n", "x"}, "g<", function() mc.matchSkipCursor(-1) end)
      set({"n", "x"}, "gaa", function() mc.searchAllAddCursors() end)
      set({"n", "v"}, "gaa", function() mc.matchAllAddCursors() end)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)
      set("n", "<c-leftdrag>", mc.handleMouseDrag)
      set("n", "<c-leftrelease>", mc.handleMouseRelease)

      -- Disable and enable multi-cursor mode.
      set({"n", "x"}, "<c-q>", mc.toggleCursor)

      -- Mappings defined in a keymap layer only apply when there are
      -- multiple cursors. This lets you have overlapping mappings.
      mc.addKeymapLayer(function(layerSet)

        -- Select a different cursor as the main one.
        layerSet({"n", "x"}, "<c-h>", mc.prevCursor)
        layerSet({"n", "x"}, "<c-l>", mc.nextCursor)

        -- Delete the main cursor.
        layerSet({"n", "x"}, "<c-x>", mc.deleteCursor)

        -- Enable and clear cursors using escape.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn"})
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  },
  { 
    "lewis6991/gitsigns.nvim",
    event = 'BufReadPre',
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Keybindings
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']h', gs.next_hunk)
          map('n', '[h', gs.prev_hunk)
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', gs.stage_hunk)
          map('v', '<leader>hr', gs.reset_hunk)
        end,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  -- {
  --   "andymass/vim-matchup",
  --   init = function()
  --      vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --   end
  -- },
  {
    "jiaoshijie/undotree",
    config = true,
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<CR>" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {}
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "<leader>/",
        block = "<leader>?",
      },
      opleader = {
        line = "<leader>/",
        block = "<leader>?",
      },
    },
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    lazy = false,
  },
  {
    'andymass/vim-matchup',
    opts = {
      treesitter = {
        stopline = 500,
      }
    }
  },
}
