source ~/.vim/vimrc-common

" Place any local / machine-specific settings here:
if filereadable(glob("~/.vimrc-local"))
    source ~/.vimrc-local
endif
