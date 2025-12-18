-- lua/plugins/colorscheme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local status_ok, tokyonight = pcall(require, "tokyonight")
      if not status_ok then
        return
      end

      tokyonight.setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })

      local colorscheme_ok = pcall(vim.cmd, [[colorscheme tokyonight]])
      if not colorscheme_ok then
        vim.notify("Failed to load colorscheme tokyonight", vim.log.levels.WARN)
        return
      end
    end,
  },
}
