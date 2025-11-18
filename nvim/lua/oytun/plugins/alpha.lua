return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
  "                                                                        ",
  "        ╔════════════════════════════════════════════════════════╗     ",
  "        ║  🌌  O Y T U N L A B  //  N E O V I M   N O D E  ⚡    ║     ",
  "        ║  🏠  homelab · self-hosted · 24/7 · no mercy           ║     ",
  "        ║  🛰  tailscale mesh · docker swarm · tmux rituals      ║     ",
  "        ║  🌊  OceanLabs · 🚕 OceanTaxi · 🎓 Slavic School       ║     ",
  "        ║  💾  logs, pods & packets under neon rain              ║     ",
  "        ╚════════════════════════════════════════════════════════╝     ",
  "                 ⌐■_■  booting cyber-workspace... ▓▓▓▓▓▓▓░░░░         ",
  "                                                                        ",
}

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("SPC wr", "󰁯  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
      dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
