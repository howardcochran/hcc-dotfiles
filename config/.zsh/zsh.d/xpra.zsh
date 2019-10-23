# Functions to help with xpra in my typical config
#

export XPRA_XAUTHORITY="$HOME/.Xauthority"
export XPRA_DISPLAY=:55
export ORIG_DISPLAY=$DISPLAY
export ORIG_XAUTHORITY=$XAUTHORITY

# Launch a command with its DISPLAY set to xpra
# We must unset XAUTHORITY since Xvfb was started without an XAUTHORITY.
# I chose to use a subshell + exec rather than 'env -u XAUTHORITY..."$@"'
# because the latter fails if the command to run is a shell function.
function xp() {
        DISPLAY=$XPRA_DISPLAY XAUTHORITY=$XPRA_XAUTHORITY "$@"
}

# Suppress err if non-interactive shell. Used by xpra-sync-clip script
compdef _precommand xp 2>/dev/null

alias env -u XAUTHORITY DISPLAY=$XPRA_DISPLAY "$@"

# Launch a command using original display, not Xpra
# We must unset XAUTHORITY since Xvfb was started without an XAUTHORITY.
function noxp() {
    XAUTHORITY=$ORIG_XAUTHORITY DISPLAY=$ORIG_DISPLAY "$@"
}
compdef _precommand noxp 2>/dev/null

# Configure this shell to launch in Xpra by default.
function use_xpra() {
    DISPLAY=$XPRA_DISPLAY
    XAUTHORITY=$XPRA_XAUTHORITY
}

# Configure this shell to launch in the original DISPLAY by default
function unuse_xpra() {
    DISPLAY=$ORIG_DISPLAY
    XAUTHORITY=$ORIG_XAUTHORITY
}

# Internal function to return the major version number of Xpra.
# For example, for xpra v0.15.6, this will output "15"
function __xpra_major_version() {
    xpra --version | sed 's/xpra v0\.\([0-9]\+\).*/\1/'
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

    local ver=$(__xpra_major_version)
    if [[ -z "$ver" || $ver < 15 ]]; then
        echo 1>&2 "Cannot start Xpra, either because it is not installed or is too old."
        echo 1>&2 "Need version 0.14.0+. Current version is $(xpra --version)"
        return 2
    fi

    local redir="/dev/stderr"
    [[ $quiet == 1 ]] && redir=/dev/null

    local tcp_port=$(( 5000 + ${XPRA_DISPLAY#:} ))

    xp xpra start --mdns=no --systemd-run=no --bind-tcp localhost:$tcp_port --tcp-auth=none \
        --sharing=yes --start-child=xterm \
        --no-notifications --clipboard=yes --pulseaudio=yes --bell=yes \
	$XPRA_DISPLAY 2>"$redir"

    # Workaround: As of xpra v1.0.1, xpra daemonizes before it is ready
    # to accept connections (boo!), so wait till its port is open.
    local tmp_time=$(date +%s.%N)
    if ~/bin/wait-for-tcp localhost $tcp_port 10; then
        echo Xpra server startup took $(( $(date +%s.%N) - $tmp_time )) secs
    else
        echo "ERROR: Xpra server appears to have failed to start!\n"
        ps auxw |grep xpra
        return 1
    fi
}

function xprattach() {
    local background=0
    if [[ "$1" == '-b' ]]; then
        background=1
        shift
    fi

    # Convention: Local xpra windows will have a purple border, remote red.
    local border
    case "$1" in
    *local)
        border="--border=#a040ff,2"; shift ;;
    *remote)
        border="--border=red,2"; shift ;;
    *border*)
        border="$1"; shift ;;
    esac

    local dest=$XPRA_DISPLAY
    [[ -n "$1" ]] && dest="$1"

    local -a args
    args=( --clipboard=no --pulseaudio=yes --speaker=disabled \
            --microphone=disabled $border --sharing=yes "$dest" \
	    --desktop-scaling=off )

    local basefile="$HOME/.xpra/client-$dest"

    # If it's already running, exit quietly
    if [[ -f "$basefile.pid" ]]; then
        local pid=$(<"$basefile.pid")
        # Unfortunately, if I don't use cat here, I can't suppress ENOENT error
        if [[ $(cat /proc/$pid/comm 2>/dev/null) == "xpra" ]] &&
            ! grep -q zombie /proc/$pid/status; then
            return 0
        fi
    fi

    if [[ $background > 0 ]]; then
        xpra attach $args &>! "$basefile.log" &
        echo $! >! "$basefile.pid"
    else
        xpra attach $args
    fi
}

# Start my default local xpra server and also attach to it so that
# we can see Xpra programs locally and get clipboard integration
function lxpra() {
    xprastart -q

    # Skip attaching to it if we have no local display
    [[ -z $DISPLAY ]] && return 0

    xprattach -b --border=local
}
