require('telescope').setup {
    defaults = {
        theme = "get_cursor",
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--column',
            '--ignore-case',
            '--line-number',
            '--no-heading',
            '--with-filename',
        }
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    }
}
require("telescope").load_extension("ui-select")


