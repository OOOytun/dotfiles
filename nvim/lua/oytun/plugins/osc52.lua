return {
  "ojroques/nvim-osc52",
  config = function()
    local osc52 = require("osc52")

    local function copy(lines, _)
      osc52.copy(table.concat(lines, "\n"))
    end

    local function paste()
      return { vim.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste, ["*"] = paste },
    }

    vim.keymap.set("n", "gy", osc52.copy_operator, { expr = true, desc = "OSC52 copy" })
    vim.keymap.set("n", "gY", "gy_", { remap = true, desc = "OSC52 copy line" })
    vim.keymap.set("v", "gy", function()
      osc52.copy_visual()
    end, { desc = "OSC52 copy visual selection" })
  end,
}
