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

# Quick alias to find filename
function f.() {
    find . -name "$@"
}

# Case-insensitive version
function fi.() {
    find . -iname "$@"
}

# "find star"  Find file whose name contains string
function fs.() {
    local name="$1"
    shift
    find . -name "*${name}*" "$@"
}

# Case-insensitive version
function fis.() {
    local name="$1"
    shift
    find . -iname "*${name}*" "$@"
}

compdef _find f. fi. fs. fis.
