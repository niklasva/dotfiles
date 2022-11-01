require'nvim-treesitter.configs'.setup {
    sync_install = false,
    ignore_install = { "" },
    highlight = { enable = true, additional_vim_regex_highlighting = true }
}

vim.cmd[[nnoremap <silent> <leader>ts :TSToggle highlight<cr>]]

