# Howard's ZLE Configuration
# Not ready yet

typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Basic key bindings.
bindkey -e # Emacs bindings
bindkey "^Q" push-input     # Was push-line
bindkey "^G" get-line       # Was send-break
bindkey "^XU"  redo         # Wanted to use ^X^R, but that is taken by _read_comp.
                            # Undo is ^xu and ^x^u, so Ctrl-x,Shift-u will redo

#################
# History Walking:
#################
# Normal Up & Down arrows are to use local history, searching for history
# that matches beginning of current line.i
#
# ^P, ^N will use global history (also searching for beginning of line match).
#
# PgUp, PgDown will use local history but NOT search for match.

# For these to work, we must have the share_history option ON
setopt share_history

up-line-or-search-local() {
    zle set-local-history 1
    zle up-line-or-search
    zle set-local-history 0
}
down-line-or-search-local() {
    zle set-local-history 1
    zle down-line-or-search
    zle set-local-history 0
}
zle -N up-line-or-search-local
zle -N down-line-or-search-local
[[ -n "$key[Up]" ]]     && bindkey "$key[Up]"     up-line-or-search-local
[[ -n "$key[Down]" ]]   && bindkey "$key[Down]"   down-line-or-search-local

# Make PageUp, PageDown do what "old" Up & Down used to do:
# Go to prev/next item regardless of what is already on this line,
# and operate only on local history
up-line-or-history-local() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
down-line-or-history-local() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-history-local
zle -N down-line-or-history-local
[[ -n "$key[PageUp]" ]]     && bindkey "$key[PageUp]"     up-line-or-history-local
[[ -n "$key[PageDown]" ]]   && bindkey "$key[PageDown]"   down-line-or-history-local

# Make ^P, ^N do what Up and Down did originally - use global history, and
# only show items that match beginning of this line.
bindkey "^P"     up-line-or-search
bindkey "^N"     down-line-or-search

# ^R, ^S are to incrementally search global history (as default), but
# ^Xr, ^Xs will incrementally search only local history
# (Their default is identical to ^R, ^S)
history-incremental-search-backward-local() {
    zle set-local-history 1
    zle history-incremental-search-backward
    zle set-local-history 0
}
history-incremental-search-forward-local() {
    zle set-local-history 1
    zle history-incremental-search-forward
    zle set-local-history 0
}
zle -N history-incremental-search-backward-local
zle -N history-incremental-search-forward-local
bindkey "^Xr" history-incremental-search-backward-local
bindkey "^Xs" history-incremental-search-forward-local

# Alt-m will copy prev word on command line. Makes renames faster
# Default binding is Esc,Ctrl+Shift+_, ("^]^_"), which is a pain!
# This mapping is what key-bindings.zsh in oh-my-zsh uses.
# If used after "Alt-." it cycles through prev words on that prev command
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

# Sudo: Alt-s
function add_sudo() {
    BUFFER="sudo "$BUFFER
    zle end-of-line
}
zle -N add_sudo
bindkey "^[s" add_sudo

#########
# Shift-Tab will unconditionally complete files, in case current completion
# won't normally complete files.
# This method came from: http://www.zsh.org/mla/users/2011/msg00974.html
# FIXME: Not colorized like normal file completeion
#########
zle -C complete-file menu-expand-or-complete _generic
zstyle ':completion:complete-file:*' completer _files
bindkey "^[[Z" complete-file # Shift-Tab: Do regular file completion
