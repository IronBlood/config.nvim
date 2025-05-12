-- Introduces three commands:
-- 1) `:CloakDisable`
-- 2) `:CloakEnable`
-- 3) `:CloakToggle`
return {
  {
    "laytan/cloak.nvim",
    opts = {
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
          replace = nil,
        },
      },
    },
  },
}
