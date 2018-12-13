" Configuration of Plugins managed by vim-plug:

" Auto-install vim-plug and all the plugins on first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

"" Plug 'tpope/vim-unimpaired'
"" Plug 'tpope/vim-fugitive'
"" Plug 'benmills/vimux'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
"" Plug 'Valloric/YouCompleteMe'
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'install --all' }

call plug#end()
