local random = math.random

local utils = {}

function utils.executable (file)
  return vim.fn.executable(file) == 1
end

function utils.add (value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({ value, str }, sep) or value
end

-- based on https://stackoverflow.com/a/15434737
function utils.isModuleAvailable(name)
  if package.loaded[name] then
    return true
  end

  for _, searcher in ipairs(package.searchers or package.loaders) do
    local loader = searcher(name)
    if type(loader) == 'function' then
      package.preload[name] = loader
      return true
    end
  end
  return false
end

-- based on https://gist.github.com/jrus/3197011
function utils.uuidv4()
  local template ='xxxxxxxx-xxxx-xxxx-yxxx-xxxxxxxxxxxx'
  local result = string.gsub(
    template, '[xy]', function (c)
      local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
      return string.format('%x', v)
    end
  )

    return result
end

return utils
