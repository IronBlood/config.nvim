local clear_snippets = require("luasnip.session.snippet_collection").clear_snippets
local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- =====================================
--   JavaScript and TypeScript related
-- =====================================

-- JavaScript Test Jest
local jtj = s("jtj", {
  t('describe("'),
  i(1, "test-problem"),
  t('", () => {'),
  t({ "", "\tconst testcases = [", "\t];", "" }),
  t({ "\tfor (let i = 0; i < testcases.length; i++) {", "" }),
  t({ "\t\tit(`test-${i}`, () => {", "" }),
  t({ "\t\t\tconst tc = testcases[i];", "" }),
  t("\t\t\t"),
  i(2, "// TODO: write your assertions here"),
  t({ "", "\t\t});", "\t}", "});" }),
  i(0),
})

clear_snippets("javascript")
ls.add_snippets("javascript", {
  jtj,
})

clear_snippets("typescript")
ls.add_snippets("typescript", {
  jtj,
})

-- ===============
--   Lua related
-- ===============

-- Lua Test Busted
local ltb = s("ltb", {
  t('describe("'),
  i(1, "test-problem"),
  t('", function()'),
  t({ "", "\tlocal testcases = {", "\t}", "" }),
  t({ "\tfor i, tc in ipairs(testcases) do", "" }),
  t({ '\t\tit("test-"..i, function()', "\t\t\t" }),
  i(2, "-- TODO: write your assertions here"),
  t({ "", "\t\tend)", "\tend", "end)" }),
  i(0),
})

clear_snippets("lua")
ls.add_snippets("lua", {
  ltb,
})

require("luasnip.loaders.from_vscode").lazy_load({
  exclude = {
    "javascript",
  },
})
