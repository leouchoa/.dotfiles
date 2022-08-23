local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
  return
end

local main_path = "~/gtd/"

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.integrations.treesitter"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.qol.toc"] = {},
    ["core.export"] = {},
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
        sources = {
          { name = "neorg" },
        },
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          gtd = main_path,
        }
      }
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
      },
    },
  }
}
