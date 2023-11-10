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

function utils.home()
  local result = os.getenv('HOME')
  return result
end

function utils.pwd()
  return vim.fn.getcwd()
end

function utils.get_venv()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv == nil then
    venv = ''
  end
  return venv
end

function utils.find_python()
 local  path = utils.get_venv() .. '/bin/python'
  if utils.executable(path) then
    return path
  end

  path = utils.pwd() .. '/' .. path
  if utils.executable(path) then
    return path
  end

  path = '/usr/bin/python'
  if utils.executable(path) then
    return path
  end

  return ''
end

function utils.is_file_exists(name)
 local f=io.open(name,"r")
  if f~=nil then io.close(f)
    return true
  end

  return false
end

--- @param ... string
--- @return string
function utils.join_paths(...)
  return (table.concat({ ... }, '/'):gsub('//+', '/'))
end

return utils
