require("which-key").setup({
  window = {
    border = "single"
  },
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
})

