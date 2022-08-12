return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim' -- Package manager
    use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
    require'lspconfig'.denols.setup{}
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'RRethy/nvim-base16'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    require('lualine').setup {
      options = {
        icons_enabled = false,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      sections = {
        lualine_x = {'encoding', 'filetype'}
      }
    }
end)
