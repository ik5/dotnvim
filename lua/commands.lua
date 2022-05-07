

-- sudo saves the file
-- (useful for handling the permission-denied error)
vim.cmd [[ command! -nargs=0 Wr exec 'write !sudo tee % > /dev/null' ]]

-- Open new terminal
vim.cmd [[ command! -nargs=* HTerm split term:///bin/zsh ]]
vim.cmd [[ command! -nargs=* VTerm vsplit term:///bin/zsh ]]

vim.cmd [[ command! -range=% FormatJSON <line1>,<line2>!python3 -c
      \"import json, sys, collections; print(json.dumps(json.load(sys.stdin,object_pairs_hook=collections.OrderedDict), indent=2, ensure_ascii=False))" ]]

vim.cmd [[ command! -nargs=* -range=% GenerateUUID lua print(require('utils').uuidv4()) ]]

vim.cmd[[ command! RebaseSquash silent execute '2,$s/^pick/s/|silent! w!|2' ]]

vim.cmd [[ command! CloseOthers tabonly|only ]]
vim.cmd [[ command! FixDoubleQuotes %s/“\|”/"/g ]]

vim.cmd [[ command! ToUnixFF :set ff=unix ]]
