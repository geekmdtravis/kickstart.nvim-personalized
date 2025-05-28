require 'custom.keymaps'
require 'custom.settings'
require 'custom.autocommands'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
  require 'custom.plugins.bufferline',
  require 'custom.plugins.copilot-lua',
  require 'custom.plugins.fterm',
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.langutils.blink-cmp',
  require 'custom.plugins.langutils.conform',
  require 'custom.plugins.langutils.todo-comments',
  require 'custom.plugins.lsp.lazydev',
  require 'custom.plugins.lsp.nvim-lspconfig',
  require 'custom.plugins.motionutils.mini',
  require 'custom.plugins.neo-tree',
  require 'custom.plugins.persistence',
  require 'custom.plugins.render-markdown',
  require 'custom.plugins.telescope',
  require 'custom.plugins.treesitter',
  require 'custom.plugins.trouble',
  require 'custom.plugins.which-key',
  require 'custom.themes.tokyonight',
}, {
  ui = require 'custom.ui',
})
