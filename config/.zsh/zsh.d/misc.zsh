# Random, misc functions and aliases
#

# Make a directory and cd to it
function mkcd() {
    mkdir -p "$1"
    cd "$1"
}

alias rt='redshift-toggle'

# Edit the current command line in full-screen Vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
