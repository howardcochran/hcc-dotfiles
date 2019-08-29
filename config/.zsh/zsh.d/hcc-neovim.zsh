# vim: et sw=4 :
# In order to avoid causing multiple Vim's trying to bind to the same listen
# socket, we'll not use $NVIM_LISTEN_ADDRESS env var but a separate shell
# variable instead

# The socket will be based on the pseudo-terminal number for this shell,
# but if stdout is not a pseudo-terminal, base it on this shell's PID
[[ -n "$XDG_RUNTIME_DIR" ]] || export XDG_RUNTIME_DIR="/run/user/$(id -u)"
nvim_sock_dir="$XDG_RUNTIME_DIR/nvimsockets"
if [[ $(readlink /proc/$$/fd/1) = /dev/pts/* ]]; then
    nvim_socket="${nvim_sock_dir}/$(basename $(readlink /proc/$$/fd/1))"
else
    nvim_socket="${nvim_sock_dir}/$$"
fi


# This will be copied to VIRTUAL_ENV in neovim's environment upon launch (see
# below). But just store it in a local var for now because this shell may want
# to work with a different python virtenv.
# This is needed for python-based neovim plugins such as LanguageServer_python
# to work right. Without this, it still works but launches a new language
# server for every call, which is very slow and it eventually runs out of file
# handles.
nvim_virtual_env=~/ve/py2neovim
[[ ! -d $nvim_virtual_env/bin ]] && nvim_virtual_env=''

__find_nvim_job() {
    jobs | sed -n '/ VIRTUAL_ENV=.*nvim --listen/ s/^\[\([0-9]\+\)\].* nvim --listen.*/\1/p;q'
}

function v() {
    local opt_tab=''
    [ "$1" = '--newtab' ] && { opt_tab='-cc tabnew' ; shift }
    local opt_split=''
    [ "$1" = '--split' ] && { opt_split='-o' ; shift }

    local job=$(__find_nvim_job)

    if [[ -z $job ]]; then
        mkdir -p "$nvim_sock_dir"
        # This silly game of writing the command to a file and then sourcing
        # it is what it takes to get the command's name in Zsh's job list to
        # be correct.
        local tmpfile=$(mktemp /tmp/vimstart.XXXXXX)
        print VIRTUAL_ENV=$nvim_virtual_env nvim "--listen" "$nvim_socket" $opt_split "$@" '&' >> "$tmpfile"
        source "$tmpfile"
        \rm "$tmpfile"
        fg
    else
        NVIM_LISTEN_ADDRESS="$nvim_socket" nvr --nostart $opt_tab $opt_split "$@" &
        fg %$job
    fi
}

alias vs='v --split'
alias vts='v --newtab --split'
alias vt='v --newtab'

# Force new is not implemented
# alias vnew='v --new'
# alias vnews='v --new --split'
