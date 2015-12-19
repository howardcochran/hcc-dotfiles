# Functions to help with xpra in my typical config
#

export XPRA_DISPLAY=:55
export ORIG_DISPLAY=$DISPLAY
export ORIG_XAUTHORITY=$XAUTHORITY

# Launch a command with its DISPLAY set to xpra
# We must unset XAUTHORITY since Xvfb was started without an XAUTHORITY.
# I chose to use a subshell + exec rather than 'env -u XAUTHORITY..."$@"'
# because the latter fails if the command to run is a shell function.
function xp() {
    (
        unset XAUTHORITY
        DISPLAY=$XPRA_DISPLAY
        exec "$@"
    )
}

alias env -u XAUTHORITY DISPLAY=$XPRA_DISPLAY "$@"

# Launch a command using original display, not Xpra
# We must unset XAUTHORITY since Xvfb was started without an XAUTHORITY.
function noxp() {
    XAUTHORITY=$ORIG_XAUTHORITY DISPLAY=$ORIG_DISPLAY "$@"
}

# Configure this shell to launch in Xpra by default.
function use_xpra() {
    DISPLAY=$XPRA_DISPLAY
    env -u XAUTHORITY
}

# Configure this shell to launch in the original DISPLAY by default
function unuse_xpra() {
    DISPLAY=$ORIG_DISPLAY
    export XAUTHORITY=$ORIG_XAUTHORITY
}

# Start Xpra server with my preferred defaults for running inside Tmux
# If already running, do nothing with a message. If -q specified, no message.
function xprastart() {
    local quiet=0
    [[ "$1" == "-q" ]] && quiet=1

    if xpra list | grep -q "LIVE session at $XPRA_DISPLAY"; then
        [[ $quiet == 0 ]] && echo "Xpra appears to be already running on display $XPRA_DISPLAY"
        return 0
    fi

    local redir="/dev/stderr"
    [[ $quiet == 1 ]] && redir=/dev/null

    xpra start --bind-tcp localhost:5055 --tcp-auth=none \
        --sharing=yes \
        --no-notifications $XPRA_DISPLAY 2>"$redir"
}

function xprattach() {
    local background=0
    if [[ "$1" == '-b' ]]; then
        background=1
        shift
    fi

    local dest=$XPRA_DISPLAY
    [[ -n "$1" ]] && dest="$1"

    local -a args
    args=( --pulseaudio=no --speaker=disabled --microphone=disabled \
	    --border=red.1 --sharing=yes "$dest" )

    local basefile="$HOME/.xpra/client-$dest"

    # If it's already running, exit quietly
    if [[ -f "$basefile.pid" ]]; then
        local pid=$(<"$basefile.pid")
        # Unfortunately, if I don't use cat here, I can't suppress ENOENT error
        if [[ $(cat /proc/$pid/comm 2>/dev/null) == "xpra" ]]; then
            return 0
        fi
    fi

    if [[ $background > 0 ]]; then
        xpra attach $args &>! "$basefile.log" &
        echo $! >! "$basefile.pid"
    else
        xpra attach "$args"
    fi
}

# Start my default local xpra server and also attach to it so that
# we can see Xpra programs locally and get clipboard integration
function lxpra() {
    xprastart -q

    # Skip attaching to it if we have no local display
    [[ -z $DISPLAY ]] && return 0

    xprattach -b
}
