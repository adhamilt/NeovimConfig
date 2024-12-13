-- Harpoon
local harpoon = require("harpoon")
local wk = require("which-key")
harpoon.setup({})

wk.add({
  {
    "<leader>ha",
    function()
      harpoon:list():add()
    end,
    desc = "Add File to Harpoon",
  },
  {
    "<leader>hl",
    function()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end
      toggle_telescope(harpoon:list())
    end,
    desc = "Search Harpoon Menu (Telescope)",
  },
  {
    "<leader>hh",
    function()
      harpoon.ui.toggle_quick_menu(harpoon:list())
    end,
    desc = "Toggle Harpoon Quick Menu",
  },
  -- Toggle previous & next buffers stored within Harpoon list
  {
    "<leader>hb",
    function()
      harpoon:list():prev()
    end,
    desc = "Harpoon Previous Buffer",
  },
  {
    "<leader>hn",
    function()
      harpoon:list():next()
    end,
    desc = "Harpoon Next Buffer",
  },
  {
    "<leader>hcc",
    function()
      harpoon:list():clear()
    end,
    desc = "Clear Harpoon All",
  },
})

-- Add List Item Specific keys
for i = 1, 5 do
  wk.add({
    {
      string.format("<leader>h%s", i),
      function()
        harpoon:list():select(i)
      end,
      desc = string.format("Harpoon %s", i),
    },
    {
      string.format("<leader>hs%s", i),
      function()
        harpoon:list():replace_at(i)
      end,
      desc = string.format("Harpoon Set %s", i),
    },
    {
      string.format("<leader>hc%s", i),
      function()
        harpoon:list():replace_at(i)
      end,
      desc = string.format("Harpoon Clear %s", i),
    },
  })
end
