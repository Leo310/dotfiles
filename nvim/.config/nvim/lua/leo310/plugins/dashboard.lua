return {
    'glepnir/dashboard-nvim',
    init = function()
        -- Close NerdTree buffer before auto-saving the current session
        vim.api.nvim_create_autocmd('User', {
            pattern = 'DBSessionSavePre',
            callback = function()
                vim.cmd('NvimTreeClose')
            end,
        })
    end,
    config = function()
        local db = require('dashboard')
        vim.keymap.set("n", "<leader>dd", ":Dashboard<CR>", { desc = 'Open Dashboard' })

        db.session_auto_save_on_exit = true
        db.session_directory = vim.fn.stdpath('cache') .. "/session"
        db.session_verbose = true

        db.footer_pad = 4
        db.custom_footer = { '🪩 To the moon!!! 🚀' }
        db.preview_file_height = 20
        db.preview_file_width = 40
        math.randomseed(os.time())
        local randomNumber = math.random(4)
        local speed = '1.0'
        if randomNumber == 1 then
            speed = '0.4'
        elseif randomNumber == 2 then
            speed = '0.6'
        end
        db.preview_file_path = "~/.config/nvim/db/head" .. randomNumber .. ".gif"
        db.preview_command = 'chafa -c full --fg-only --speed ' .. speed .. ' --symbols braille'

        db.custom_center = {
            { icon = '  ', desc = 'Find file              ', action = 'Telescope find_files' },
            { icon = '  ', desc = 'Recently latest session', action = 'SessionLoad' },
            { icon = '  ', desc = 'My Projects            ', action = '!tmux neww ~/.tmux/sessionizer.sh' },
            { icon = '  ', desc = 'New file               ', action = 'DashboardNewFile' },
            -- { icon = '  ', desc = 'Recently Used Files    ', action = 'Telescope oldfiles' }
        }
    end
}
