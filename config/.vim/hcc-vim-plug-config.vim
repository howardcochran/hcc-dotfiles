" Configuration of Plugins managed by vim-plug:

" Auto-install vim-plug and all the plugins on first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

function! BuildCquery(info)
    !git submodule update --init
    !mkdir -p build
    !cd build
    !cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=release -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    !make -j 8 install
endfunction

call plug#begin('~/.local/share/nvim/plugged')

"" Plug 'tpope/vim-unimpaired'
"" Plug 'tpope/vim-fugitive'
"" Plug 'benmills/vimux'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdcommenter'
"" Plug 'Valloric/YouCompleteMe'
Plug 'wesQ3/vim-windowswap'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'install --all' }
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'cquery-project/cquery', { 'do': function('BuildCquery') }
Plug 'ncm2/ncm2'

" This is a dependency of ncm2:
Plug 'roxma/nvim-yarp'
" This thing is a beast: Plug 'ncm2/ncm2-bufword'

Plug 'vim-airline/vim-airline'
" I just autoload my own theme directoy, so I don't need this repo of themes:
" Plug 'vim-airline/vim-airline-themes'

call plug#end()
