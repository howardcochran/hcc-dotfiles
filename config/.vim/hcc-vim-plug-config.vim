" Configuration of Plugins managed by vim-plug:

" Auto-install vim-plug and all the plugins on first run
if has('nvim')
  let s:plug_script = '~/.local/share/nvim/site/autoload/plug.vim'
  let s:plug_dir = '~/.local/share/nvim/plugged'
else
  let s:plug_script = '~/.vim/autoload/plug.vim'
  let s:plug_dir = '~/.local/share/vim/plugged'
endif

if empty(glob(s:plug_script))
  silent exe '!curl -fLo ' . s:plug_script . ' --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent exe 'source ' . s:plug_script
  autocmd VimEnter * PlugInstall --sync | sleep 2 | :qa
endif

call plug#begin(s:plug_dir)

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
Plug 'joshdick/onedark.vim'   " Color scheme
Plug 'liuchengxu/vista.vim'

" Workaround until this is fixed: https://github.com/neovim/neovim/issues/1496
Plug 'lambdalisue/suda.vim'
cnoremap w!! execute 'silent! write suda://%'

call plug#end()
