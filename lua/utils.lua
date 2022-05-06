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


return utils
