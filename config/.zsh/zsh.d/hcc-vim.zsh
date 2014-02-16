# vim: et sw=4 :

# With the help of the python program vimstart, open the given files in vim.
# Search for any existing vims that were launced as a --vimserver among this
# shell's list of processes under job control. If one is found, open the
# files in that vim and bring it to the foreground. If many are found,
# present a menu to let the user choose a vim, and if none are found, launch
# a new vim with a unique server name.
function v() {
    local tmpfile=$(mktemp /tmp/vimstart.XXXXXX)
    jobs -l >! $tmpfile
    ~/bin/vimstart --tempfile $tmpfile "$@"
    local reply="$?"
    if [ "$reply" -ne 0 ] || [ ! -e $tmpfile ]; then
        rm -f $tmpfile
        return $reply
    fi
    local reply="$(cat $tmpfile)"
    if [[ $reply = vim* ]] ; then
        # We're to launch a new shell. Command given in tmpfile
        # In order for command to show up in jobnames correctly,
        # it will run in background.
        local bg_nice_save=$BG_NICE
        BG_NICE=0  # Don't nice the backgrounded vim
        source $tmpfile
        BG_NICE=$bg_nice_save

        # There seems to be no direct way of finding out the job num of
        # the new backgrounded vim, and no way to specify a pid to th fg cmd,
        # so parse it from the output of the jobs list.
        local pid=$!
        local jobnum="$(jobs -l | sed -n -e 's/^\[\([0-9]*\)\][ +-]*'$pid'\s.*/\1/p')"
    else
        # We've sent it to existing vim server. Foreground it.
        local jobnum="$(cat $tmpfile)"
    fi
    rm -f $tmpfile
    fg %$jobnum
}

alias j='v --list-jobs'

