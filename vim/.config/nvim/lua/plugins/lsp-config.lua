local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local function sem_token_attach(_)
    vim.lsp.buf.semantic_tokens_full()
    vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.buf.semantic_tokens_full()]]
end

-- Begin on_attach --
local on_attach = function(client, bufnr)
    sem_token_attach(client)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end



    local function fun_format(diagnostic)
        if diagnostic.severity == vim.diagnostic.severity.WARN then
            return string.format("E: %s", diagnostic.message)
        end
        return diagnostic.message
    end

    vim.lsp.buf.semantic_tokens_full()
    vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.buf.semantic_tokens_full()]]
    vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
        float = {
            --prefix = ' ',
            border = 'single',
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            focusable = false,
            format = fun_format,

            header = { '', 'Normal' },
            relative = 'win',
            scope = 'line',
            source = 'always',
            style = 'minimal',
            width = 60,
        },
    })
    vim.o.updatetime = 150

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = { }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end
-- end on_attach --

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--query-driver=/Applications/ARM/**/*",
    },
}
vim.cmd [[:command! Fix lua vim.lsp.buf.code_action()]]
vim.cmd [[nnoremap <silent> <leader><cr> :lua vim.lsp.buf.code_action()<cr>]]


require'lspconfig'.pyright.setup{
}

require("nvim-semantic-tokens").setup {
    preset = "default",
    highlighters = { require 'nvim-semantic-tokens.table-highlighter'}
}

local table_highlighter = require "nvim-semantic-tokens.table-highlighter"
table_highlighter.token_map = {
    ["function"]     = "Function",
    angle            = "Operator",
    arithmetic       = "Operator",
    attribute        = "Define",
    attributeBracket = "Operator",
    bitwise          = "Operator", boolean          = "Boolean",
    brace            = "Operator",
    bracket          = "Operator",
    builtinAttribute = "Define",
    builtinType      = "Type",
    character        = "Character",
    colon            = "Operator",
    comma            = "Operator",
    comment          = "Comment",
    comparison       = "Operator",
    constParameter   = "Parameter",
    derive           = "Define",
    dot              = "Operator",
    enum             = "Type",
    enumMember       = "Constant",
    escapeSequence   = "Special",
    formatSpecifier  = "Operator",
    interface        = "TraitType",
    keyword          = "Keyword",
    label            = "Label",
    lifetime         = "Noise",
    logical          = "Operator",
    macro            = "PreProc",
    macroBang        = "PreProc",
    method           = "Function",
    namespace        = "Type",
    number           = "Number",
    operator         = "Operator",
    parameter        = "Parameter",
    parenthesis      = "Operator",
    property         = "Property",
    punctuation      = "Operator",
    selfKeyword      = "Special",
    semi             = "Operator",
    string           = "String",
    struct           = "Type",
    trait            = "TraitType",
    typeAlias        = "Type",
    typeParameter    = "TraitType",
    union            = "Type",
}

table_highlighter.reset()

