# This script is designed to be sourced by your interactive shell

# This function refreshes the environment from the current tmux client
# into this shell. This funciton normally bails if it is not running
# in a tmux session, unless -f is used. We consider ourselves to be
# inside a tmux session of $TMUX is non-null.
# Options:
# -f    Force this, even if we don't appear to be inside a TMUX session
# -v    Be verbose. Normally, no output is shown

# We require a modern shell. Silently bail if it doesn't understand =~
zsh -c '[[ "foo" =~ "foo" ]]' 2> /dev/null || return 0

function tmuxenv() {
    local ARGS
    ARGS=$(getopt -o fv -- "$@")

    # If not in tmux and caller didn't specify -f (force)
    if [[ -z "${TMUX}" && ! $ARGS =~ '-f' ]]; then
	[[ $ARGS =~ '-v' ]] && echo Not running in tmux. Nothing to do.
	return 0
    fi

    local v
    while read v; do
	[[ $ARGS =~ '-v' ]] && echo $v
        if [[ $v == -* ]]; then
            unset ${v/#-/}
        else
            # Add quotes around the argument
            v=${v/=/\=\"}
            v=${v/%/\"}
            eval export $v
        fi
    done < <(tmux show-environment)
}
