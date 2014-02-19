# vim: et sw=4 :

# Private helper: Get an array of shell jobs that are vim servers
function __vim_get_serverjobs() {
    # Newbie comment: (@f) modifier makes it split words on newlines
    # instead of spaces. The quotes preserve the spaces in each line,
    # and outer parenthesis make the result into an array. Each array
    # element is a complete line from the jobs|sed command.
    serverjobs=("${(@f)$(jobs -l | sed -n "/vim.*--servername/p" )}")
}

# Private function:
# Given one line of output from the jobs command, print two words:
# 1. The job number, and 2. The vim servername.
# Example: given this line:
# [4]  - suspended  vim --servername aserver Makefile
# We will return:
# 4 aserver
function __vim_parse_job_and_server() {
    print "$1" |sed -n "/suspended \+vim.*--servername/s/\[\([0-9]\)\].*--servername \+\([^ ]\+\).*/\1 \2/p"
}

# Private function:
# Generate a unique name for new vim server, globally incrementing
# a number in a persistent config file
function __vim_unique_server_name() {
    local seq_num
    local num_file=~/.config/vim_seq_num
    if [ -f $num_file ]; then
        seq_num=$(cat ~/.config/vim_seq_num)
        seq_num=$(( $seq_num + 1 ))
    else
        seq_num=0
    fi
    print $seq_num >! $num_file
    print "vim"$seq_num
}

# Private function:
# Create the command line for a launching a new vim instance as a server
# and write it to a tmpfile
function __vim_build_new_vim_cmd() {
    local tmpfile="$1"
    shift
    print "vim --servername $(__vim_unique_server_name)" "$@" '&' > "$tmpfile"
}

# Internal function:
# Find existing vim server within current shell to talk to. If multiple
# exist, ask user which to talk to. A result is assigned to __vim_job:
# 0: User canceled. Do nothing.
# n: Launch a new vim instance. The vim command has been written to the
#    given $tmpfile. Our caller must actually launch it.
# integer: We sent the command to the given vim instance. We did not create
#          $tmpfile. Our caller is to forground $__vim_job
function __vim_build_launch_cmd() {
    local tmpfile="$1"
    shift
    local force_new=0
    [ "$1" = '--new' ] && { force_new=1 ; shift }

    local serverjobs
    local row # full text of chosen row of "jobs" output
    local job_and_server

    serverjobs=''

    __vim_get_serverjobs  # Function populates serverjobs array

    # If there are no server jobs (or caller said --new), launch new vim
    if [ $force_new -eq 1 ] || [ $(print "${serverjobs}" | wc -w) -eq 0 ]; then
        __vim_build_new_vim_cmd "$tmpfile" "$@"
        __vim_job='n'
        return 0
    fi

    if [ ${#serverjobs} -gt 1 ] ; then
       print "Choose which vim.  (q: Quit  n: New vim)"
       select row in ${serverjobs[@]} ; do
           __vim_job=0  # Default=quit
           [[ $REPLY = 'q' ]] && { return 0 }
           [[ $REPLY = 'n' ]] && { __vim_build_new_vim_cmd "$tmpfile" "$@"; __vim_job='n' ; return 0 }
           [[ -z "$row" ]] && { print "Unknown selection." ; return 0 }
           break
       done
    else
        # Only one server found, pick the obvious one
        row="${serverjobs[1]}"
    fi

    # job_and_server becomes an array: 1st element is shell job number,
    # and second element is the name of the corresponding vim server
    job_and_server=( $(__vim_parse_job_and_server "$row") )
    __vim_job="${job_and_server[1]}"

    vim --servername ${job_and_server[2]} --remote "$@"
}


# Open a file in an existing vim. If none exists, launch a new one.
# If multiple exist, ask user which to open it in.
function v() {
    # Populated by inner function. 0=quit, n=new vim, integer=existing vim
    local __vim_job

    local tmpfile=$(mktemp /tmp/vimstart.XXXXXX)
    rm -f $tmpfile  # Shouldn't exist, but just in case
    __vim_build_launch_cmd $tmpfile "$@"

    [[ $__vim_job == 0 ]] && return 0

    if [[ $__vim_job == 'n' ]]; then
        # We're to launch a new shell. Command given in tmpfile
        # In order for command to show up in jobnames correctly,
        # it will run in background.
        local bg_nice_save=$BG_NICE
        BG_NICE=0  # Don't nice the backgrounded vim
        source $tmpfile
        rm -f $tmpfile
        BG_NICE=$bg_nice_save

        # There seems to be no direct way of finding out the job num of
        # the new backgrounded vim, and no way to specify a pid to th fg cmd,
        # so parse it from the output of the jobs list.
        local pid=$!
        __vim_job="$(jobs -l | sed -n -e 's/^\[\([0-9]*\)\][ +-]*'$pid'\s.*/\1/p')"
    fi
    fg %$__vim_job
}

function vnew() {
    v --new "$@"
}
