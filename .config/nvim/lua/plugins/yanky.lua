return {
  "gbprod/yanky.nvim",
  opts = {
    system_clipboard = {
      sync_with_ring = false,
    },
  },
  keys = {
    {
      "Y",
      [["+<Plug>(YankyYank)]],
      mode = { "n", "x" },
      desc = "Yank to system clipboard",
    },
  },
}
