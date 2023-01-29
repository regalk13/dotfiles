vim.opt.background = "dark"
vim.cmd("colorscheme catppuccin")
--vim.cmd("colorscheme tokyonight")
-- vim.g.tokyonight_transparent_sidebar = true
-- vim.g.tokyonight_transparent = true

-- require("tokyonight").setup({
--    transparent = true,
-- }) 

require("catppuccin").setup({
     transparent_background = true,
})
