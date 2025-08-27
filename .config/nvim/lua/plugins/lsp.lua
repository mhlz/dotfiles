return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        eslint = {
          enabled = true,
        },
        vtsls = {
          enabled = true,
          settings = {
            typescript = {
              tsserver = {
                experimental = {
                  enableProjectDiagnostics = false,
                },
              },
            },
          },
        },
      },
    },
  },
}
