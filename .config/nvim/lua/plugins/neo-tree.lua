---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = false,
      filesystem = {
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          visible = true,
        },
      },
      -- window = {
      --   mappings = {
      --     ["<cr>"] = ""
      --   }
      -- }
    },
  },
}
