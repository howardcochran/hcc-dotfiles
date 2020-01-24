" Configuration of Plugins managed by vim-plug:

" Auto-install vim-plug and all the plugins on first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | sleep 2 | :qa
endif

call plug#begin('~/.local/share/nvim/plugged')

"" Plug 'tpope/vim-unimpaired'
"" Plug 'tpope/vim-fugitive'
"" Plug 'benmills/vimux'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
" I just autoload my own theme directoy, so I don't need this repo of themes:
" Plug 'vim-airline/vim-airline-themes'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
