filetype off                   " required!

set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-unimpaired.git'
Bundle 'vim-scripts/EasyGrep.git'
Bundle 'kien/ctrlp.vim.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'benmills/vimux.git'
Bundle 'tpope/vim-eunuch.git'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Valloric/YouCompleteMe'
Bundle 'wesQ3/vim-windowswap'

filetype plugin indent on     " required!
