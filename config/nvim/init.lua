if vim.loader then
    vim.loader.enable()
end

_G.dd = function(...)
    require('utils.debug').dump(...)
end
vim.print = _G.dd

require('core.globals')
require('core.lazy')
require('core.options')
require('core.autocmd')
