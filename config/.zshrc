# Fix $SHELL, since we often inherited csh's idea of $SHELL
export SHELL=/bin/zsh

# Do this early as some setup files use whence to test for the existance
# of things normally in ~/.local/bin
export PATH=~/bin:~/.local/usr/local/bin:~/.local/usr/bin:~/.local/bin:~/.local/share/umake/bin:/snap/bin:$PATH

# Turn off Xon/Xoff in this termal so that can use <CTRL-Q> in progs like vim
stty start undef   # normally ^Q
stty stop undef    # normally ^S

# Make completions case-insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Be very verbose with completions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Menu completion allows cursor keys to highlight desired completion
zstyle ':completion:*' menu select

autoload -U compinit
compinit  # -C means just use cached .zcompdump unconditionally - CAUSED ERRORS

compdef _precommand eatmydata

setopt PROMPT_SUBST # Allow parameter substitution in prompt

for file in ~/.zsh/zsh.d/*; do
    source $file
done

# Actually set my prompt.  Depends on already sourcing gencolors above
source ~/.zsh/setprompt

# Put this in front of a command to execute it only if prev command succeeded
# Allows easy piece-meal authoring of lines like cmd1 && cmd2 && cmd3
alias ok='[ $? -eq 0 ] && '

# Automatically list choices on an ambiguous completion.
setopt AUTO_LIST

# Make cd push the old directory onto the directory stack.
setopt AUTO_PUSHD PUSHD_MINUS

setopt NO_BG_NICE

setopt NO_CLOBBER

setopt NO_HUP

# If a pattern for filename generation has no matches, delete the pattern from the argument list; do not report an error unless all the patterns in a command have no matches. Overrides NOMATCH.
setopt CSH_NULL_GLOB

setopt EXTENDED_GLOB

setopt HIST_NO_STORE

# Whenever the user enters a line with history expansion, don't execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
setopt HIST_VERIFY

# Do not exit on end-of-file.
setopt IGNORE_EOF

# (No) Beep on an ambiguous completion.
setopt NO_LIST_BEEP

# When listing files that are possible completions, show the type of each file with a trailing identifying mark.
setopt LIST_TYPES

# Don't print exit status when non-zero. My prompt does that already
unsetopt PRINT_EXIT_VALUE

# Perform implicit tees or cats when multiple redirections are attempted (see 6. Redirection).
setopt MULTIOS

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NOTIFY

# Perform a path search even on command names with slashes in them.
setopt PATH_DIRS

# Perform foo=/path/to/filename expansion
setopt EQUALS

# long jobs listing
setopt long_list_jobs  # NOTE: Doesn't work...?? Workaround with alias:
alias jobs='jobs -l'
alias j='jobs -l'

# set ignore case for ls etc
setopt no_case_glob

# Recognize the # character in interactive command line
setopt INTERACTIVE_COMMENTS

# Split var references into words when values have spaces (like bash & tcsh)
setopt SH_WORD_SPLIT

# Disable ^S / ^Q flow control so can use ^Q for push-line
unsetopt FLOW_CONTROL

# automatically remove duplicates from these arrays
typeset -U path PATH cdpath fpath manpath MANPATH

# Prevent the prompt from overwriting the last line of output of a command
# does not end in a newline. These two options work together
setopt promptsp
setopt promptcr

# Tab completion of a word with wildcard does menu completion rather than
# the default of inserting all matches onto the line immediately
setopt GLOB_COMPLETE

# Save timestamp and command durations to history file
setopt EXTENDED_HISTORY

# Don't save a command to history if it is identical to previous command
setopt HIST_IGNORE_DUPS

# Don't save a command to history if it has a leading space
# (useful for dangerous commands)
setopt HIST_IGNORE_SPACE

# Don't add the history (fc -l) command itself to history
setopt HIST_NO_STORE

# Remove superflous whitespace from history entries
setopt HIST_REDUCE_BLANKS

# Use fcntl() to lock history file when writing, which performs better than
# default ad hoc locking, and is safer on NFS.
setopt HIST_FCNTL_LOCK

# When searching history, do not display dups of a line previously found
setopt HIST_FIND_NO_DUPS

# When reading history from file, split shell words up the same way that
# normal shell parser does. Otherwise, quoted words with spaces are wrong
setopt HIST_LEX_WORDS

limit coredumpsize 0

# Fedora's limit is 1 million by default, which really slows down fork() in
# Python / bitbake, because it calls close() for every possible descriptor!
limit descriptors 1024

# Give me "time" usage for any non-bg cmd that takes more than 2s sys & usr time
REPORTTIME=2
TIMEFMT="Time: %*E real %U usr %S sys %P %J"

# This makes forward/backward-word in zle behave like the zsh default, which
# treats word boundaries only on space chars. I set it here explicitly because
# oh-my-zsh hard-codes this to emty string, which makes it behave like bash (yuck!)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'

# Add a few more chars beyond the default so it will only stop on spaces
WORDCHARS+='":'"'"

# I like ls -s to tell me the number of blocks in 1K blocks.
BLOCKSIZE=K ; export BLOCKSIZE

# color-ls This sets LS_COLORS for my dark background
eval `dircolors --sh`

# This makes file completion use same colors as ls
zstyle ':completion:*' list-colors "$LS_COLORS"

# LS aliases
alias ls='ls --color=auto -Fs'
alias ll='ls --color=auto -lF'
alias la='ls --color=auto -aF'
alias lla='ls --color=auto -latrF'
alias lls='ls --color=auto -ltrF'

# List only directories and symbolic links that point to directories.
# Takes an optional directory name as argument and searches relative to it.
# Parens make whole thing happen in subshell so cd not permanent
function lsd() { 
   ( if [ $1 ]; then 
         \cd $1;
     fi
     ls -ld *(-/DN)
   )
}

function namedir () {
	if [ ! ! "$2" ]
	then
		dir="$2"
	else
		dir="$PWD"
	fi

	eval "$1=$dir"
	echo ~$1 >& /dev/null
}

function up () {
	count=$1
	[ -z "$count" ] && count=1
	local ups
	while [ "$count" -gt 0 ] ; do
	    ups="../$ups"
	    ((count--))
	done
	if [ ! -z "$ups" ] ; then
	    cd "$ups"
	fi
}

alias upp='up 2'
alias uppp='up 3'
alias upppp='up 4'
alias uppppp='up 5'
alias upppppp='up 6'

# Set the gnome-terminal tab title to given string
function settitle() {
	echo -ne "\033]0;$*\007"
}


# These vars only make sense for an interactive shell, so they're in zshrc
export HISTIGNORE=ls:ll:lls:la:c
export HISTSIZE=16384
export SAVEHIST=$HISTSIZE
export HISTFILE=$HOME/.zsh_history

# GREP_OPTIONS was deprecated. My former setting for this was:
# export GREP_OPTIONS='--exclude=*.svn* --directories=recurse --color=auto'
# Note I really hate to drop recursion by default, but -r on the command line
# did not act like --directories=recurse did in that it added an implied .
# argument, so it always grepped everything under the current directory, even
# when you are just piping something into its stdin :(
# As far as I know, I have no recourse but to lose "recursive by default"
alias grep='grep --color=auto'
export GREP_COLOR='1;32'

# These use to be default on Ubuntu, but apparently not on Fedora 22, so
# let's set them explicitly. In particular, -R is needed to get color
# output to look correctly (which was on by default, but became OFF if
# $LESS was set to any string that did not include it!)
export LESS='-R --ignore-case'

if [[ "$(lsb_release --id -s)" == "Ubuntu" ]]; then
	# (Ubuntu-only) Use my wrapper script for less,
	# which fixes --quit-if-one-screen behavior.
	# Since less itself works correctly on Fedora, this workaround
	# caused duplicate output when fits on one screen!
	export PAGER=~/bin/pager
	export MANPAGER=~/bin/pager\ -s  # Don't use quotes so tilde expands
	alias less=~/bin/pager
fi

function ..() { cd .. }
## alias cd='cd -L' # This interferes with tab completion on the cd command
alias rm='rm -i'
alias cp='cp -i'
alias c=clear
alias m=less
alias h=history
alias hi='history | tail -25'
alias dh='dirs -v'
alias j='jobs -l'
alias eat='cat > /dev/null'
alias mv="mv -i"
alias a=alias
alias u=unalias
alias mroe=more
function ga { a | egrep $* }
compdef _grep ga
alias sz="source ~/.zshrc"
alias gitags='git ls-files | ctags -L - --sort=foldcase'
alias gitagpp='git ls-files | ctags -L - --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++'
alias mktags='find . -name \*.\[ch\] | ctags -L - --sort=foldcase'
alias mktagpp='find . -name \*.\[ch\]\* | ctags -L - --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++'
alias gba='git branch -a'
alias gbl='git branch -l'
alias gr='git rebase'
alias bb='bitbake'

# A few global aliases of interest
alias -g NF='$(\ls -a *(.om[1]))'    # newest file
alias -g ND='$(\ls -a -d *(/om[1]))' # newest directory
alias -g G='| grep'
alias -g L='| less'
alias -g LL="2>&1 | less"
alias -g NE='2> /dev/null'
alias -g DN=/dev/null

# Pipe output of command to tmux's "clipboard"
alias -g CL='| one-line-strip | tmux load-buffer -'

alias psg='ps -Af | grep '

alias sdis='export DISPLAY=$(cat ~/.DISPLAY)'

# function periodic() {
#     #typeset -g periodic_cur periodic_prev
#     #export periodic_cur
#     #export periodic_prev
#     echo debug: c $periodic_cur  p $periodic_prev
#     periodic_cur="$(stat --format=%Y ~/.zshrc) $(stat --format=%Y ~/.zsh/rc-common)"
#     echo debug: c $periodic_cur  p $periodic_prev
#     if [ "$periodic_prev" != "$periodic_cur" ] ; then
#         if [ ! -z "$periodic_prev" ] ; then
#             echo Re-reading .zshrc...
#             source ~/.zshrc
#         fi
#         periodic_cur="$periodic_prev"
#     fi
#     return 0
# }
# PERIOD=60


# Load plugins:
source ~/.zsh/plugins/plugins.zsh

# Simple bulk renamer
autoload -U zmv            # zmv '(*)-(*).mp3' '$2_$1.mp3'
alias mmv='noglob zmv -W'  # mmv *.JPG *.jpg

# Put any local / machine-specific settings into the following file:
[ -f ~/.zshrc-local ] && source ~/.zshrc-local || true

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
