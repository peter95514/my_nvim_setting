-- 使用更现代的方式设置快捷键
local set_keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 普通模式下的快捷键
set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })  -- 保存文件
set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })  -- 退出
vim.keymap.set("n", "<A-l>", "<Esc>E", { desc = "移動到下一個字的結尾" })
vim.keymap.set("n", "<A-h>", "<Esc>ge", { desc = "移動到上一個字的結尾" })
vim.g.mapleader = " "

-- 插入模式下的快捷键
set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })  -- 退出插入模式
vim.keymap.set("i", "<A-l>", "<Esc>ea", { desc = "移動到下一個字的結尾" })
vim.keymap.set("i", "<A-h>", "<Esc>gea", { desc = "移動到上一個字的結尾" })

-- nvimtree
set_keymap("n", ";", ":NvimTreeToggle<CR>", { noremap = true, silent = true })


-- bufferline
set_keymap("n", "<A-d>", ":BufferLineCycleNext<CR>", opts)  -- 切換到下一個緩衝區
set_keymap("n", "<A-a>", ":BufferLineCyclePrev<CR>", opts) -- 切換到上一個緩衝區

--set_keymap("n", "<A-s>", ":BufferLinePickClose<CR>", opts) -- 選擇並關閉緩衝區
set_keymap("n", "<A-s>", ":bdelete<CR>", opts) -- 選擇並關閉緩衝區

--tagbar
set_keymap("n", "[", ":TagbarToggle<CR>", opts)

--float
vim.keymap.set("n", "<A-c>", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-x>", function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.api.nvim_win_close(win, true)
        end
    end
end, { noremap = true, silent = true })--closewindow

--fzf
--vim.keymap.set("n", "<A-f>", ":Ag ", { noremap = true, silent = false})

--copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_tab_fallback = false
vim.api.nvim_set_keymap('i', '<A-j>', 'copilot#Accept()', { noremap = true, silent = true, expr = true })
--vim.keymap.set('i', '<Tab>', '    ', { noremap = true, silent = true })

--sneak
vim.keymap.set('', '<A-j>', '<Plug>Sneak_;', {})
vim.keymap.set('', '<A-k>', '<Plug>Sneak_,', {})--]]
vim.keymap.set("n", "m", "<Plug>Sneak_s", {})
vim.keymap.set("n", "M", "<Plug>Sneak_S", {})

--Plamtumlpreview
vim.keymap.set("n", "<A-u>", "<cmd>PlantumlPreview<CR>", { desc = "PlantUML Preview" })
vim.keymap.set("n", "<A-U>", "<cmd>PlantumlStopPreview<CR>", { desc = "Stop PlantUML Preview" })

--markdown
vim.keymap.set("n", "<A-n>", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true, desc = "Toggle Markdown Preview" })
