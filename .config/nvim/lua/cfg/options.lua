local options = {
  backup = false, -- creates a backup file
  clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  cmdheight = 2, -- more space in the neovim command line for displaying messages
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  -- conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = 'a', -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds) Displays which-key popup sooner
  undofile = true, -- enable persistent undo
  updatetime = 250, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  breakindent = true, -- enable breakindent
  list = true, -- Sets how neovim will display certain whitespace characters in the editor. (See `:help 'list'`)
  listchars = { tab = '» ', trail = '·', nbsp = '␣' }, -- Sets how neovim will display certain whitespace characters in the editor. (See `:help 'list'`)
  relativenumber = true, -- set relative numbered lines
  inccommand = 'split', -- Preview substitutions live, as you type!
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  guifont = 'monospace:h17', -- the font used in graphical neovim applications
  -- TODO: try using treesitter or lsp to better folding. Can be found here:
  -- https://alpha2phi.medium.com/neovim-for-beginners-code-folding-7574925412ea
  -- reason: org files are kinda strange when using the default colors
  foldmethod = 'indent',
  foldlevel = 99, -- fixes fold bugs in plugins like telescope
  conceallevel = 2, -- the text concealing option. See :h conceallevel for more info
  -- https://youtu.be/KoL-2WTlr04?si=EspKwLXnsDfG17fI
  spelllang = 'en_us',
  spell = true,
}

vim.opt.shortmess:append 'c'

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
