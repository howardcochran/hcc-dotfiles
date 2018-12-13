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
Plug 'ncm2/ncm2'

" This is a dependency of ncm2:
Plug 'roxma/nvim-yarp'
" This thing is a beast: Plug 'ncm2/ncm2-bufword'

Plug 'vim-airline/vim-airline'
" I just autoload my own theme directoy, so I don't need this repo of themes:
" Plug 'vim-airline/vim-airline-themes'

call plug#end()
