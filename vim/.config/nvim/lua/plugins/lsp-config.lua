local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
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

    local function word_break(input_str, width)
        words = {}
        for w in input_str:gmatch("[^ ]+") do
            table.insert(words, w)
        end

        local out_str = ""
        local line = ""
        for k, v in ipairs (words) do
            if (string.len(line .. " " .. v)) <= width
                -- and v ~= "(fix" and v ~= "(fixes"
                then
                    if (k ~= 1) then
                        line = line .. " " .. v
                    else
                        line = v
                    end
                else
                    out_str = out_str .. line .. "\n"
                    line = v
                end
            end
            out_str = out_str .. line
            return out_str
        end


    vim.lsp.buf.semantic_tokens_full()
    vim.cmd [[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.buf.semantic_tokens_full()]]

    local float_width = 90
    local function fun_format(diagnostic)

        local severity_symbol = ""
        if (diagnostic.severity == 1) then
            severity_symbol = "[Error]"
        elseif (diagnostic.severity == 2) then
            severity_symbol = "[Warn]"
        end

        local text = word_break(severity_symbol .. " " .. diagnostic.message .. " [" .. diagnostic.code .. "]", float_width)
        return text
    end

    vim.diagnostic.config({
        severity_sort = true,
        signs = false,
        underline = true,
        update_in_insert = false,
        virtual_text = false,

        float = {
            border = 'rounded',
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            focusable = false,
            format = fun_format,
            header = { '', 'Normal' },
            relative = 'win',
            --scope = 'line',
            style = 'minimal',
            ----  width = float_width + 5
        },
    })
    vim.o.updatetime = 500

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

