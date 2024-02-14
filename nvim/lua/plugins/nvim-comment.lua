return {
  "terrortylor/nvim-comment",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    local nvim_comment = require("nvim_comment")

    nvim_comment.setup({
      hook = function()
        require("ts_context_commentstring.internal").update_commentstring()
      end,
    })
  end,
}
