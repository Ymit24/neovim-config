vim.g.copilot_no_tab_map = true
-- vim.keymap.set("i", "<C-a>", ':copilot#Accept("<CR>')

--vim.cmd([[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]])
vim.cmd([[imap <silent><script><expr> <C-O> copilot#Accept("\<CR>")]])
