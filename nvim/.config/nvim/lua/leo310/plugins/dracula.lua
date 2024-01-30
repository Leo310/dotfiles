return {
    "dracula/vim",
    name = "dracula",
    lazy = false,
    priority = 999,
    config = function()
        -- colorscheme set to 0 to have transparent in transparent terminal
        vim.api.nvim_create_autocmd({ "ColorScheme" }, {
            pattern = "*",
            callback = function()
                vim.cmd([[
        hi link DashboardDesc DraculaYellow
        hi link DashboardIcon DraculaCyan
        hi link DashboardFooter DraculaPurple
          ]])
            end,
        })
        -- hi link FloatBorder CmpPmenuBorder
        -- hi! link Pmenu CmpPmenu
        --
        --
        -- hi link DapUIVariable Normal
        -- hi link DapUIScope DraculaPurple
        -- hi link DapUIType DraculaPurple
        -- hi link DapUIDecoration DraculaCyan
        -- hi link DapUIThread DraculaGreen
        -- hi link DapUIStoppedThread DraculaCyan
        -- hi link DapUIFrameName Normal
        -- hi link DapUISource DraculaPurple
        -- hi link DapUILineNumber DraculaCyan
        -- hi link DapUIFloatBorder DraculaCyan
        -- hi link DapUIWatchesHeader DraculaCyan
        -- hi link DapUIWatchesEmpty DraculaOrange
        -- hi link DapUIWatchesValue DraculaGreen
        -- hi link DapUIWatchesError DraculaError
        -- hi link DapUIWatchesFrame DraculaPurple
        -- hi link DapUIBreakpointsPath DraculaCyan
        -- hi link DapUIBreakpointsInfo DraculaGreen
        -- hi link DapUIBreakpointsCurrentLine DraculaGreenBold
        -- hi link DapUIBreakpointsLine DapUILineNumber
        --
        -- hi link LspReferenceRead DraculaSelection
        -- hi link LspReferenceWrite DraculaSelection
        -- hi link LspReferenceText DraculaSelection
        vim.g.dracula_colorterm = 0
    end,
}
