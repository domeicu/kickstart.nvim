-- dom's config!!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 50
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 15
vim.o.confirm = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Keymaps
vim.keymap.set('n', '<leader>h', ':Alpha<CR>', { desc = 'Home screen' });
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>v', '<C-w>v')
vim.keymap.set('n', '<leader>x', '<C-w>s')
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Install lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  { -- Colorscheme
    name = 'domeicu',
    dir = vim.fn.stdpath('config'),
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'domeicu'
      vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
  },

  { -- Startup screen
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        "                |                ",
        "            \\       /            ",
        "              .---.              ",
        "         '-.  |   |  .-'         ",
        "           ___|   |___           ",
        "      -=  [           ]  =-      ",
        "          `---.   .---'          ",
        "       __||__ |   | __||__       ",
        "       '-..-' |   | '-..-'       ",
        "         ||   |   |   ||         ",
        "         ||_.-|   |-,_||         ",
        "       .-\"`   `\"`'`   `\"-.       ",
        "     .'                   '.     ",
      }

      dashboard.section.header.opts = { position = "center", hl = "AlphaHeader" }
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#F1FFD9" })

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find",   ":Telescope find_files<CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit",   ":qa<CR>"),
      }

      dashboard.section.buttons.opts = { spacing = 0 }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "Normal"
        button.opts.hl_shortcut = "Normal"
      end

      local cwd = {
        type = "text",
        val = "  " .. vim.fn.getcwd(),
        opts = { position = "center", hl = "AlphaCwd" },
      }
      vim.api.nvim_set_hl(0, "AlphaCwd", { fg = "#6B6B68" })

      dashboard.section.footer.val = {
        "",
        "Let us hold unswervingly to the hope we profess,",
        "for he who promised is faithful.",
        "",
      }
      dashboard.section.footer.opts = { position = "center", hl = "AlphaFooter" }
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#F1FFD9" })

      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 1 },
        cwd,
        { type = "padding", val = 1 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.config)

      local alpha_cursor_group = vim.api.nvim_create_augroup("AlphaCursor", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = alpha_cursor_group,
        pattern = "alpha",
        callback = function()
          vim.api.nvim_set_hl(0, "AlphaHiddenCursor", { blend = 100, nocombine = true })
          local old_guicursor = vim.o.guicursor
          local hide_cursor = function() vim.o.guicursor = "a:AlphaHiddenCursor" end
          local restore_cursor = function() vim.o.guicursor = old_guicursor end
          hide_cursor()
          vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, { buffer = 0, callback = restore_cursor })
          vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, { buffer = 0, callback = hide_cursor })
        end,
      })
    end,
  },

  { -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = function() return vim.fn.executable 'make' == 1 end },
      { 'nvim-tree/nvim-web-devicons', enabled = true },
    },
    config = function()
      require('telescope').setup {}
      pcall(require('telescope').load_extension, 'fzf')
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sf', builtin.find_files,  { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep,   { desc = 'Search Grep' })
      vim.keymap.set('n', '<leader>sr', builtin.oldfiles,    { desc = 'Search Recent' })
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search Neovim files' })
      vim.keymap.set('n', '<leader>sb', builtin.buffers,     { desc = 'Search Buffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags,   { desc = 'Search Help' })
    end,
  },

  { -- File explorer
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    keys = {
      { '\\', ':Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
    },
    opts = {},
  },

  { -- Treesitter
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local parsers = { 'bash', 'c', 'lua', 'markdown', 'markdown_inline', 'vim', 'vimdoc' }
      require('nvim-treesitter').install(parsers)
      local function try_attach(buf, language)
        if not vim.treesitter.language.add(language) then return end
        vim.treesitter.start(buf, language)
      end
      local available = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local language = vim.treesitter.language.get_lang(args.match)
          if not language then return end
          local installed = require('nvim-treesitter').get_installed 'parsers'
          if vim.tbl_contains(installed, language) then
            try_attach(args.buf, language)
          elseif vim.tbl_contains(available, language) then
            require('nvim-treesitter').install(language):await(function() try_attach(args.buf, language) end)
          end
        end,
      })
    end,
  },

  { -- Mini utilities
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true }
      statusline.section_location = function() return '%2l:%-2v' end
    end,
  },

  { -- Which key popup
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 500,
      icons = { mappings = vim.g.have_nerd_font },
    },
  },

  -- Guess indent
  { 'NMAC427/guess-indent.nvim', opts = {} },

  -- Autopairs
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },

  { -- Command line popup
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    keys = {
      { ':', '<cmd>FineCmdline<CR>' },
    }
  },

  -- Git signs
  { 'lewis6991/gitsigns.nvim', opts = {} },

  { -- Todo comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘', config = '🛠', event = '📅', ft = '📂',
      init = '⚙', plugin = '🔌', start = '🚀', lazy = '💤 ',
    },
  },
})
