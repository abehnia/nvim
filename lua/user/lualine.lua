local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
   return
end

local hide_in_width = function()
   return vim.fn.winwidth(0) > 80
end

local diagnostics = {
   "diagnostics",
   sources = { "nvim_diagnostic" },
   sections = { "error", "warn" },
   symbols = { error = " ", warn = " " },
   colored = false,
   update_in_insert = false,
   always_visible = true,
}

local diff = {
   "diff",
   colored = false,
   cond = hide_in_width
}

local branch = {
   "branch",
   icons_enabled = true,
   icon = "",
}

local location = {
   "location",
   padding = 0,
}

lualine.setup {
   options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
      always_divide_middle = true,
   },
   sections = {
      lualine_a = {'mode'},
      lualine_b = {branch, diagnostics},
      lualine_c = {'filename'},
      lualine_x = {diff},
      lualine_y = {'encoding', 'filetype', 'progress'},
      lualine_z = {location}
   },
   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
   },
   tabline = {},
   extensions = {}
}
