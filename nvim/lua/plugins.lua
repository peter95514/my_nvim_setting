local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    --TokyoNight
    {
        "folke/tokyonight.nvim",
        lazy = false,           -- 確保主題立即載入
        priority = 1000,        -- 優先載入順序
        config = function()
            vim.cmd("colorscheme tokyonight-night")  -- 你也可以用 storm/moon/day
        end,
    },--]]

    --hop
    {
    "phaazon/hop.nvim",
    branch = "v2", -- 最新版 Hop
    config = function()
        -- 初始化 hophop
        require("hop").setup()

        -- 設定快捷鍵
        local hop = require("hop")
        vim.keymap.set("n", "<C-w>", function()
            hop.hint_words()
        end, { remap = true, desc = "Hop to word" })

        vim.keymap.set("n", "<C-c>", function()
            hop.hint_char1()
        end, { remap = true, desc = "Hop to 1 char" })

        vim.keymap.set("n", "<leader><leader>2", function()
            hop.hint_char2()
        end, { remap = true, desc = "Hop to 2-char sequence" })

        vim.keymap.set("n", "<C-l>", function()
            hop.hint_lines()
        end, { remap = true, desc = "Hop to line" })
    	end
	},

    --PlantumlPreview
    {
    'weirongxu/plantuml-previewer.vim',
    dependencies = { 'tyru/open-browser.vim' },
    ft = { 'plantuml' }
    },
    
    --notify
    {
        "rcarriga/nvim-notify",
        lazy = true,
        event = "VeryLazy",
        config = function()
            local notify = require("notify")

            notify.setup({
                stages = "fade_in_slide_out",
                timeout = 3000,
                fps = 60,
                render = "default",
                background_colour = "Normal",
                max_width = math.floor(vim.o.columns * 0.5),
                max_height = math.floor(vim.o.lines * 0.25),
                level = "TRACE",
            })

            vim.notify = notify
        end,
    },

    --[[--neoscroll
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",  -- 或 "VeryLazy", 或 "BufReadPost" 根據你的需求
        config = function()
        require('neoscroll').setup({
            -- 這些是預設值，你可以根據需要調整
            mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
            hide_cursor = true,
            stop_eof = true,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            easing_function = nil, -- 可選: "quadratic", "circular", "sine", etc.
            pre_hook = nil,
            post_hook = nil,
        })

        -- 如果你想自定義特定按鍵的滾動行為，可以這樣：
        local t = {}
        local neoscroll = require('neoscroll.function')
        t['j'] = { 'scroll', { '-vim.wo.scroll', 'true', '1' } }
        t['k'] = { 'scroll', { 'vim.wo.scroll', 'true', '1' } }
        require('neoscroll.config').set_mappings(t)
        end,
    },--]]

    --[[copilot
    {
        "github/copilot.vim",
        lazy = false, -- 確保啟動時加載

    },--]]

    --sneak
    {
        "justinmk/vim-sneak",
        event = "VeryLazy",
        init = function()
            vim.g["sneak#label"] = 1         -- 高亮提示位置
            vim.g["sneak#use_ic_scs"] = 1    -- f/t 也可用 sneak 模式（可選）
            vim.g["sneak#map_s"] = 0 -- 不要讓 sneak 綁定 s 鍵
            vim.g["sneak#map_S"] = 0 -- 同上，針對 S
        end,
    },--]]

    --folke_noice
    {
        "folke/noice.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" },
        dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
        config = function()
            require("noice").setup({
                lsp = {
                    hover = {
                        enabled = true,
                        opts = {
                            border = "rounded",                          -- 或 "single" / "double" / "solid"
                            max_width = math.floor(vim.o.columns * 0.6), -- 60% 的螢幕寬度
                            max_height = math.floor(vim.o.lines * 0.3),  -- 30% 的螢幕高度
                        },
                    },
                    signature = {
                        enabled = true,
                        opts = {
                            border = "rounded",
                            max_width = math.floor(vim.o.columns * 0.8), -- 50% 的螢幕寬度
                            max_height = math.floor(vim.o.lines * 0.2),  -- 20% 的螢幕高度
                        },
                    },
                    progress = {
                        enabled = true,
                    },
                    message = {
                        enabled = true,
                    },
                },
                routes = {
                    {
                        filter = {
                            event = "notify",
                            find = "No information available",
                        },
                        opts = { skip = true }, -- 避免某些無意義訊息彈出
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = true,
                },
                messages = {
                    enabled = true,
                    view = "notify",
                    view_error = "popup",
                    view_warn = "mini",
                    view_history = "split",
                    view_search = "virtualtext",
                },
                health = {
                    checker = true,
                },
            })
        end,
    },

    --markdown
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    --autopair
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
        require("nvim-autopairs").setup({})
    
        -- 與 nvim-cmp 相容（如果你有使用 nvim-cmp 的話）
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    --vim-illuminate
    {
        "RRethy/vim-illuminate",
        config = function()
        require('illuminate').configure({
            under_cursor = true,
        })
        end,
    },

    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = { "nvimtools/hydra.nvim" },
        opts = {},
        cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
        keys = {
            {
                mode = { "v", "n" },
                "<A-p>",
                "<cmd>MCstart<CR>",
                desc = "Create a selection for selected text or word under the cursor",
            },
        },
    },

    --dashboard-nvim
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local db = require("dashboard")
            db.setup({
                theme = "doom", -- or "hyper"
                config = {
                    header = vim.split([[
|¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨|
|                                                                               |
|                                    ________              \./                  |
|                     _             |o-  \|      \./   —:::—                    |
|                   _|M|-._ _      .|________|     —;;:—   /.\                  |
|                 _|·|A|◦| | |     |o-  \|         :   /                        |
|                |*| |T|-| | |_    |________|.    (*´¨)\_/))`.                  |
|                | | |H| | |*| |    |•-  \|       \)  ./.\)                     |
|           _____|_|_|_|_|_|_|_|____|________|________\__/___________           |
|           """""""""""""""""""""""""""""""""""""""""""""""""""""""""           |
|      _____                  _____________________         _______________     |
|     .     .                |.———————————————————.|        ———————————————     |
|     |     |  _____         ||                   ||        |_|_|_|_|_|_|_|     |
|     |     | .     .        ||                   ||        |_|_|_|_|_|x|_|     |
|     ._____. |     |        ||                   ||        |_|_|_|x|_|_|_|     |
|             |     |        ||                   ||        |_|_|_|_|_|_|_|     |
|             ._____.        |.———————————————————.|        |_|_|_|_______|     |
|                            `—————————————————————'                            |
|                    _________________/   \_________________                    |
|                 . `                /_____\                ` .                 |
|               .`               ________________    ________  `.               |
|            .`                 /________________\   \________.   `.            |
\___________`_______________________________________________________`___________/
]], "\n"),

                    center = {
                        {
                            icon = "  ",
                            desc = "Recently opened files",
                            action = "Telescope oldfiles",
                            shortcut = "SPC o",
                        },
                        {
                            icon = "  ",
                            desc = "Find file",
                            action = "Telescope find_files",
                            shortcut = "SPC f",
                        },
                        {
                            icon = "  ",
                            desc = "Live grep search",
                            action = "Telescope live_grep",
                            shortcut = "SPC /",
                        },
                    },

                    footer = {
                        "",
                        "🧠 Keep learning, keep coding.",
                    },
                }
            })
        end
    },

    --nvim-web-devicons
    {
        'kyazdani42/nvim-web-devicons',  -- 安裝 nvim-web-devicons 插件
    },

    --fzf
    --{
    --    "junegunn/fzf",
    --    build = "./install --bin"
    --},
    --{
    --    "junegunn/fzf.vim",
    --    config = function()
        -- 在當前文件中查找字串的快捷鍵
    --    vim.keymap.set("n", "<leader>/", ":Ag <C-R><C-W><CR>", { noremap = true, silent = true })  -- 查找當前光標所在字串
    --    end,
    --},

    --telescope.nvim
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.9,
                        height = 0.85,
                    },
                },
            })

            vim.keymap.set("n", "<A-/>", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<A-f>", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
        end
    },

    -- tagbar
    {
        { "preservim/tagbar" }
    },

    --float_lspsaga
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- 語法樹
            "nvim-tree/nvim-web-devicons"      -- 圖示
        },
        config = function()
        require("lspsaga").setup({
      --      definition = {
      --          width = 20,       -- 寬度（字元數）
      --         height = 15,      -- 高度（行數）
      --      }
            lightbulb = {
                    enable = false,
                    sign = false,
                    virtual_text = false,
                },
        })
        end
    },

    --nvimtree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 檔案圖示（可選）
        },
        config = function()
            -- 設定 nvim-tree
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                    relativenumber = true,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = false,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,  -- 選擇檔案後自動關閉
                    },
                },
            })

        end,
    },

    --lualine
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        config = function()
        require('lualine').setup {
            options = { theme = 'tokyonight' }
        }
        end
    },

    --bufferline
    {
        "akinsho/bufferline.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- 必須的圖示插件
        },
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "none",        -- 顯示緩衝區編號，設定為 "none" 隱藏
                    close_command = "bdelete %d", -- 關閉緩衝區的命令
                    right_mouse_command = "bdelete %d", -- 右鍵點擊關閉緩衝區
                    left_mouse_command = "buffer %d",  -- 左鍵點擊選擇緩衝區
                    middle_mouse_command = nil, -- 無
                    indicator = {
                        style = "icon", -- 使用圖示顯示選中緩衝區
                        icon = "▎", -- 可自定義圖示
                    },
                    buffer_close_icon = "", -- 關閉緩衝區的圖示
                    modified_icon = "●", -- 顯示檔案已修改的圖示
                    close_icon = "", -- 關閉圖示
                    left_trunc_marker = "", -- 左側溢出標記
                    right_trunc_marker = "", -- 右側溢出標記
                    show_buffer_icons = true, -- 顯示檔案圖示
                    show_buffer_close_icons = true, -- 顯示關閉圖示
                    show_tab_indicators = true, -- 顯示 tab 指示器
                    persist_buffer_sort = true, -- 記住緩衝區排序
                    separator_style = "thin", -- 分隔線風格
                },
            })
        end,
    },

    --nvim_cmp
    {
        "hrsh7th/nvim-cmp",
        config = function()
        local cmp = require'cmp'
        vim.o.updatetime = 300  -- 設定燈泡更新的時間，這樣可以避免顯示:
        cmp.setup({
            snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
            },
        mapping = {
          ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
                --["<CR>"] = cmp.mapping.confirm({ select = true })
                --[[["<Tab>"] = function(fallback)
                fallback()
            end,
            ["<S-Tab>"] = function(fallback)
                fallback()
            end,--]]
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'vsnip' },
        },
      })
    end
  },

  --LSP
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require'lspconfig'
      vim.g.lightbulb_enabled = 0
      --Python lsp
      lspconfig.pyright.setup{}

      -- C/C++ LSP
      lspconfig.clangd.setup{
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        settings = {
          clangd = {
            completion = {
              enable = false,
              snippets = true
		        }
            }
        }
    }
    end
  },

  --Snippet
  { "hrsh7th/cmp-nvim-lsp" },         -- LSP 补全源
  { "hrsh7th/cmp-buffer" },           -- 缓冲区补全源
  { "hrsh7th/cmp-path" },             -- 文件路径补全源
  { "hrsh7th/cmp-vsnip" },            -- Snippet 补全源
  { "rafamadriz/friendly-snippets" }, -- 常用的 snippet

})
