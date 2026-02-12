-- index
-- tagbar
-- neo-tree: file manager -- commented
-- nvim-tree: file manager
-- lsp-file-operations
-- dotenv
-- treesitter
-- nvim-notify
-- mason: external tools manager
-- fidget
-- todo-comments
-- data-viewer: CSV, XLS
-- markdown-preview
-- telescope: Ctrl-P
-- dbee: database integration
-- trouble: diagnostics list
-- Alpha: dashboard
-- neominimap
-- laravel.nvim -- commented
-- blade-nav.nvim
-- vim-blade -- commented
-- conform: formatter engine
-- orgmode
-- pomodoro
-- buffer deletion
return {
  {'preservim/tagbar'},
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   branch = "v3.x",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-web-devicons", -- optional, but recommended
  --   },
  --   cmd = { "Neotree" },
  --   keys = {
  --     { "<Leader>t", "<Cmd>Neotree toggle<CR>" }, -- change or remove this line if relevant.
  --     { "<Leader>g", "<Cmd>Neotree focus git_status toggle<CR>" }, -- change or remove this line if relevant.
  --     { "<Leader>y", "<Cmd>Neotree filesystem reveal toggle<CR>" }, -- change or remove this line if relevant.
  --   },
  --   lazy = false, -- neo-tree will lazily load itself
  --   ---@module 'neo-tree'
  --   ---@type neotree.Config
  --   opts = {
  --     event_handlers = {
  --       {
  --         event = "neo_tree_buffer_enter",
  --         handler = function()
  --           vim.opt_local.relativenumber = true
  --         end,
  --       }
  --     },
  --   }
  -- },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'b0o/nvim-tree-preview.lua',
      dependencies = {
        'nvim-lua/plenary.nvim',
        '3rd/image.nvim', -- Optional, for previewing images
      },
    },
    config = function()
      local api = require('nvim-tree.api')
      vim.keymap.set('n', '<Leader>t', api.tree.toggle, { desc = 'nvim-tree: Toggle' })
      vim.keymap.set('n', '<Leader>y', ':NvimTreeFindFileToggle<CR>', { desc = 'nvim-tree: Find and focus file' })
      require("nvim-tree").setup({
        view = {
          number = true,
          relativenumber = true,
        },
        on_attach = function(bufnr)
          -- default mappings
          -- Important: When you supply an `on_attach` function, nvim-tree won't
          -- automatically set up the default keymaps. To set up the default keymaps,
          -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
          api.config.mappings.default_on_attach(bufnr)

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          local preview = require('nvim-tree-preview')

          -- custom mappings
          vim.keymap.set('n', '?',  api.tree.toggle_help, opts('Help'))
          vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
          vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
          vim.keymap.set('n', '<C-f>', function() return preview.scroll(4) end, opts 'Scroll Down')
          vim.keymap.set('n', '<C-b>', function() return preview.scroll(-4) end, opts 'Scroll Up')
          vim.keymap.set('n', '<Tab>', function()
            local ok, node = pcall(api.tree.get_node_under_cursor)
            if ok and node then
              if node.type == 'directory' then
                api.node.open.edit()
              else
                preview.node(node, { toggle_focus = true })
              end
            end
          end, opts 'Preview')
        end,
      })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "ellisonleao/dotenv.nvim",
    opts = {
      enable_on_load = true,
      verbose = false
    },
    cmd = { "Dotenv" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "css",
          "lua",
          "xml",
          "markdown",
        },
      },
      ensure_installed = {
        "bash",
        "markdown",
        "html",
        "css",
        "javascript",
        "tsx",
        "php",
        "query",
        "lua",
        "vim",
      },
      auto_install = false,
      incremental_selection = {
        enable = false
      },
      -- matchup = {
      --   enable = true
      -- }
    },
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      background_colour = "#000000", -- transparent
    }
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  -- Extensible UI for Neovim notifications and LSP progress messages.
  { "j-hui/fidget.nvim",   lazy = true },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      local todo = require('todo-comments')
      require('todo-comments').setup()
      vim.keymap.set("n", "]t", function()
        todo.jump_next()
      end, { desc = "Next todo comment" })
      
      vim.keymap.set("n", "[t", function()
        todo.jump_prev()
      end, { desc = "Previous todo comment" })
    end
  },
  {
    'vidocqh/data-viewer.nvim',
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua", -- Optional, sqlite support
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        find_command = "fzf"
      }
    },
    config = function()
      local fzf = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', fzf.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fr', fzf.oldfiles, { desc = 'Telescope recent files' })
    end
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        drawer = {
          window_options = {
            number = true,
            relativenumber = true,
          },
        },
        call_log = {
          window_options = {
            number = true,
            relativenumber = true,
          },
        },
        sources = {
          -- example DBEE_CONNECTIONS
          --  [
          --     {
          --       "url": "maqiis:123@tcp(localhost:3306)/akademik_maqiis",
          --       "name": "Maqiis",
          --       "type": "mysql"
          --     }
          -- ]
          -- use array, export it in shell session, like config.fish, .zshrc, .bashrc
          require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
          require("dbee.sources").FileSource:new(
            vim.fn.stdpath("cache") .. "/dbee/persistence.json"
          ),
        },
      })
    end,
    keys = {
      {
        "<leader>d",
        "<cmd>Dbee<CR>",
        desc = "Open database",
      }
    }
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>Tx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>TX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>Ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>Tl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>TL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>TQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
      vim.keymap.set('n', '<leader>h', '<cmd>Alpha', { desc = 'Open the home page' })
    end,
  },
  ---@module "neominimap.config.meta"
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      -- Global Minimap Controls
      { "<leader>mm",  "<cmd>Neominimap Toggle<cr>",      desc = "Toggle global minimap" },
      { "<leader>mo",  "<cmd>Neominimap Enable<cr>",      desc = "Enable global minimap" },
      { "<leader>mc",  "<cmd>Neominimap Disable<cr>",     desc = "Disable global minimap" },
      { "<leader>mr",  "<cmd>Neominimap Refresh<cr>",     desc = "Refresh global minimap" },

      -- Window-Specific Minimap Controls
      { "<leader>mwt", "<cmd>Neominimap WinToggle<cr>",   desc = "Toggle minimap for current window" },
      { "<leader>mwr", "<cmd>Neominimap WinRefresh<cr>",  desc = "Refresh minimap for current window" },
      { "<leader>mwo", "<cmd>Neominimap WinEnable<cr>",   desc = "Enable minimap for current window" },
      { "<leader>mwc", "<cmd>Neominimap WinDisable<cr>",  desc = "Disable minimap for current window" },

      -- Tab-Specific Minimap Controls
      { "<leader>mtt", "<cmd>Neominimap TabToggle<cr>",   desc = "Toggle minimap for current tab" },
      { "<leader>mtr", "<cmd>Neominimap TabRefresh<cr>",  desc = "Refresh minimap for current tab" },
      { "<leader>mto", "<cmd>Neominimap TabEnable<cr>",   desc = "Enable minimap for current tab" },
      { "<leader>mtc", "<cmd>Neominimap TabDisable<cr>",  desc = "Disable minimap for current tab" },

      -- Buffer-Specific Minimap Controls
      { "<leader>mbt", "<cmd>Neominimap BufToggle<cr>",   desc = "Toggle minimap for current buffer" },
      { "<leader>mbr", "<cmd>Neominimap BufRefresh<cr>",  desc = "Refresh minimap for current buffer" },
      { "<leader>mbo", "<cmd>Neominimap BufEnable<cr>",   desc = "Enable minimap for current buffer" },
      { "<leader>mbc", "<cmd>Neominimap BufDisable<cr>",  desc = "Disable minimap for current buffer" },

      ---Focus Controls
      { "<leader>mf",  "<cmd>Neominimap Focus<cr>",       desc = "Focus on minimap" },
      { "<leader>mu",  "<cmd>Neominimap Unfocus<cr>",     desc = "Unfocus minimap" },
      { "<leader>ms",  "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      -- @type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,
      }
    end,
  },
  -- {
  --   "adalessa/laravel.nvim",
  --   dependencies = {
  --     "tpope/vim-dotenv",
  --     "nvim-telescope/telescope.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     -- "nvim-neotest/nvim-nio",
  --     "kevinhwang91/promise-async",
  --   },
  --   cmd = { "Laravel" },
  --   keys = {
  --     -- { "<leader>la", ":Laravel artisan<cr>" },
  --     -- { "<leader>lr", ":Laravel routes<cr>" },
  --     -- { "<leader>lm", ":Laravel related<cr>" },
  --     { "<leader>ll", function() Laravel.pickers.laravel() end,              desc = "Laravel: Open Laravel Picker" },
  --     { "<c-g>",      function() Laravel.commands.run("view:finder") end,    desc = "Laravel: Open View Finder" },
  --     { "<leader>la", function() Laravel.pickers.artisan() end,              desc = "Laravel: Open Artisan Picker" },
  --     { "<leader>lt", function() Laravel.commands.run("actions") end,        desc = "Laravel: Open Actions Picker" },
  --     { "<leader>lr", function() Laravel.pickers.routes() end,               desc = "Laravel: Open Routes Picker" },
  --     { "<leader>lh", function() Laravel.run("artisan docs") end,            desc = "Laravel: Open Documentation" },
  --     { "<leader>lm", function() Laravel.pickers.make() end,                 desc = "Laravel: Open Make Picker" },
  --     { "<leader>lc", function() Laravel.pickers.commands() end,             desc = "Laravel: Open Commands Picker" },
  --     { "<leader>lo", function() Laravel.pickers.resources() end,            desc = "Laravel: Open Resources Picker" },
  --     { "<leader>lp", function() Laravel.commands.run("command_center") end, desc = "Laravel: Open Command Center" },
  --     {
  --       "gf",
  --       function()
  --         local ok, res = pcall(function()
  --           if Laravel.app("gf").cursorOnResource() then
  --             return "<cmd>lua Laravel.commands.run('gf')<cr>"
  --           end
  --         end)
  --         if not ok or not res then
  --           return "gf"
  --         end
  --         return res
  --       end,
  --       expr = true,
  --       noremap = true,
  --     },
  --   },
  --   event = { "VeryLazy" },
  --   opts = {
  --     lsp_server = "intelephense", -- "phpactor | intelephense"
  --     features = {
  --       pickers = {
  --         provider = "telescope", -- "snacks | telescope | fzf-lua | ui-select"
  --       },
  --     },
  --   },
  --   -- config = true,
  --   -- config = function()
  --     -- vim.api.nvim_create_user_command('Laravel', function()
  --     --   require('laravel').pickers().menu()
  --     -- end, {})
  --     -- require('laravel')
  --   -- end,
  -- },
  {
    'ricardoramirezr/blade-nav.nvim',
    dependencies = { -- totally optional
        'hrsh7th/nvim-cmp',
    },
    ft = { 'blade', 'php' }, -- optional, improves startup time
    opts = {
      -- This applies for nvim-cmp and coq, for blink refer to the configuration of this plugin
      close_tag_on_complete = true, -- default: true
    },
  },
  -- { "jwalton512/vim-blade" },
  {
    'stevearc/conform.nvim', -- Lightweight yet powerful formatter plugin for Neovim
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = function ()
      ---@param bufnr integer
      ---@param ... string
      ---@return string
      local function first(bufnr, ...)
        local conform = require("conform")
          for i = 1, select("#", ...) do
            local formatter = select(i, ...)
            if conform.get_formatter_info(formatter, bufnr).available then
              return formatter
            end
          end
        return select(1, ...)
      end
      local opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd" },
          typescript = { "prettier" },
          php = function(bufnr)
            return { first(bufnr, "pint", "php-cs-fixer") }
          end,
          blade = function(bufnr)
            return { first(bufnr, "blade-formatter", "rustywind") }
          end,
        },
        formatters = {
          injected = { options = { ignore_errors = true } },
        }
      }
      return opts
    end,
    config = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    end
  },
  -- {
  --   'nvim-orgmode/orgmode',
  --   event = 'VeryLazy',
  --   ft = { 'org' },
  --   opts = {
  --     org_agenda_files = '~/Documents/mynotes/orgfiles/**/*',
  --     org_default_notes_file = '~/Documents/mynotes/orgfiles/refile.org',
  --     org_adapt_indentation = false,
  --     mappings = {
  --       agenda = {
  --         org_agenda_show_help = 'g?',
  --         org_agenda_later = '>',
  --         org_agenda_earlier = '<',
  --         org_agenda_goto_today = {'.', 'T'}
  --       }
  --     }
  --   }
  -- },
  {
    "nvim-neorg/neorg",
    lazy = false,  -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
  },
  {
    "epwalsh/pomo.nvim",
    version = "*", -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    opts = {
      sessions = {
        pomodoro = {
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work",        duration = "25m" },
          { name = "Long Break",  duration = "15m" },
        }
      }
    },
  },
  {
    "ojroques/nvim-bufdel",
    cmd = "BufDel",
    keys = {
      {
        "<leader>C",
        "<CMD>BufDel<CR>"
      }
    }
  }
  -- { "michaelb/sniprun" },
  -- { "dhruvasagar/vim-table-mode" }
}
