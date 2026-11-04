local Kind = require('blink.cmp.types').CompletionItemKind

local DIC_PATH = '/usr/share/hunspell/fr_FR.dic'

local words = nil

local function load_words()
  if words then
    return words
  end
  local f = io.open(DIC_PATH, 'r')
  if not f then
    words = {}
    return words
  end
  local list = {}
  local count = 0
  for line in f:lines() do
    if count > 0 then
      local word = line:match('^[^%/]+')
      if word and word ~= '' and not word:match('%s') then
        list[#list + 1] = word
      end
    end
    count = count + 1
  end
  f:close()

  local by_first = {}
  for _, w in ipairs(list) do
    local first = w:sub(1, 1):lower()
    by_first[first] = by_first[first] or {}
    by_first[first][#by_first[first] + 1] = w
  end

  words = {
    list = list,
    by_first = by_first,
  }
  return words
end

local Source = {}

function Source.new()
  local self = setmetatable({}, { __index = Source })
  self.words = load_words()
  return self
end

local PROSE_FTS = {
  markdown = true,
  text = true,
  tex = true,
  latex = true,
}

function Source:enabled()
  return PROSE_FTS[vim.bo.filetype] == true
end

function Source:get_completions(context, resolve)
  local prefix = context.line:sub(1, context.cursor[2])
  local keyword = prefix:match("([%a%-%'àâäéèêëîïôöùûüçœæ]+)$")
  if not keyword or #keyword < 2 then
    resolve()
    return
  end

  local lower = keyword:lower()
  local first = lower:sub(1, 1)
  local candidates = self.words.by_first[first] or {}

  local items = {}
  for _, w in ipairs(candidates) do
    if w:lower():sub(1, #lower) == lower then
      items[#items + 1] = {
        label = w,
        kind = Kind.Text,
        labelDetails = { description = 'français' },
      }
      if #items >= 100 then
        break
      end
    end
  end

  local range = {
    ['start'] = {
      line = context.cursor[1] - 1,
      character = context.cursor[2] - #keyword,
    },
    ['end'] = {
      line = context.cursor[1] - 1,
      character = context.cursor[2],
    },
  }
  for _, item in ipairs(items) do
    item.textEdit = {
      range = range,
      newText = item.label,
    }
  end

  resolve({ items = items, is_incomplete_forward = false, is_incomplete_backward = false })
end

return Source
