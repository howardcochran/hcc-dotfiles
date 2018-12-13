# vim: et sw=4 :
# In order to avoid causing multiple Vim's trying to bind to the same listen
# socket, we'll not use $NVIM_LISTEN_ADDRESS env var but a separate shell
# variable instead

# The socket will be based on the pseudo-terminal number for this shell,
# but if stdout is not a pseudo-terminal, base it on this shell's PID
nvim_sock_dir='/tmp/nvimsockets'
if [[ $(readlink /proc/$$/fd/1) = /dev/pts/* ]]; then
    nvim_socket="${nvim_sock_dir}/$(basename $(readlink /proc/$$/fd/1))"
else
    nvim_socket="${nvim_sock_dir}/$$"
fi

__find_nvim_job_and_socket() {
    jobs | sed -n '/ nvim --listen/ s/^\[\([0-9]\+\)\].* nvim --listen \([^ ]\+\).*/\1 \2/p;q'
}

function v() {
    ## force_new=0
    ## [ "$1" = '--new' ] && { force_new=1 ; shift }
    local opt_tab=''
    [ "$1" = '--newtab' ] && { opt_tab='-cc tabnew' ; shift }
    local opt_split=''
    [ "$1" = '--split' ] && { opt_split='-o' ; shift }

    local -a job_and_socket
    job_and_socket=( $(__find_nvim_job_and_socket) )

    if [[ $#job_and_socket == 2 ]]; then
        local job=$job_and_socket[1]
        local socket=$job_and_socket[2]
        local args="--nostart $opt_tab $opt_split"
    else
        local job=
        local socket=$nvim_socket
        local args="--listen $socket $opt_split"
    fi

    if [[ -z $job ]]; then
        # This silly game of writing the command to a file and then sourcing
        # it is what it takes to get the command's name in Zsh's job list to
        # be correct.
        local tmpfile=$(mktemp /tmp/vimstart.XXXXXX)
        print nvim "--listen" "$socket" $opt_split "$@" '&' >> "$tmpfile"
        source "$tmpfile"
        \rm "$tmpfile"
        fg
    else
        NVIM_LISTEN_ADDRESS="$socket" nvr --nostart $opt_tab $opt_split "$@" &
        fg %$job
    fi
}

alias vs='v --split'
alias vts='v --newtab --split'
alias vt='v --newtab'

# Force new is not implemented
# alias vnew='v --new'
# alias vnews='v --new --split'
