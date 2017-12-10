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

#########################################
# Word-style-wrapper bindings
#########################################

# In this section, we create two different bindings for many of the -word
# widgets. One which uses the "normal zsh" definition of words, and one
# that uses the bash definition. In general, the default Alt-key binding
# maps to the normal style and, and the Ctrl-key binding uses the bash style,
# wherever this makes sense.
#
# Implementaiton:
# For each -word widget function, we define two new widgets that have the
# same names with -normal and -bash appended. All of these are bound to
# the word-style-zle-wrapper function, herein, which sets the word style
# to whatever the suffix of whatever widget name it was called from, then
# calls whatever function the base widget was originally mapped to.
# NOTE: It is safe to run this multiple times without adverse consequences
# (as when re-sourcing zsh's dotfiles)

autoload -U select-word-style
select-word-style normal

word-style-zle-wrapper() {
    local word_style=${WIDGET/*-}
    [[ $word_style == (bash|normal|shell|whitespace) ]] || word_style='default'
    select-word-style $word_style
    zle -w ${WIDGET%-$word_style} # Call original widget

    # Restore word style so we don't affect any widgets not wrapped by us.
    # TODO: Actually read the prior word style and restore it rather than
    #       assuming default.
    select-word-style default
}
zle -N bash-word-wrapper

declare -a __word_functions

__word_widgets=(backward-kill-word backward-word
  capitalize-word down-case-word
  forward-word kill-word
  transpose-words up-case-word)

for f in $__word_widgets; do
    zle -N $f-bash word-style-zle-wrapper
    zle -N $f-normal word-style-zle-wrapper
done

# zle -N backward-word-before-style-wrapper ${widgets[backward-word]#user:}
zle -N backward-word-bash word-style-zle-wrapper
zle -N backward-word-normal word-style-zle-wrapper

# The Alt- bindings use normal word style, while Ctrl- bindings use bash style
bindkey '^[b'     backward-word-normal
bindkey '^b'      backward-word-bash         # (default: backward-char)
bindkey '^[f'     forward-word-normal
bindkey '^f'      forward-word-bash          # (default: backward-char)
bindkey '^[d'     kill-word-normal
bindkey '^d'      kill-word-bash
bindkey '^]^?'    backward-kill-word-normal  # Alt-backspace
bindkey '^h'      backward-kill-word-bash    # Ctrl-backspace and Ctrl-h (default: backward-kill-char)
bindkey '^[[3;3~' kill-word-normal           # Alt-Del (default: unbound)
bindkey '^[[3;5~' kill-word-bash             # Ctrl-Del (default: unbound)

# TODO: Wrap transpose, up-case, down-case, copy-as-kill.  Deferring for
#       now because I don't know what bindings I want to use since the default
#       mappings already distinguish Ctrl- and Alt- for these things.

#########
# Modify the current argument to the absolute path to it.
#########
autoload -U modify-current-argument
zle-expand-to-realpath() {
    # ~ expands homedir if the arg starts with '~'.  :a does "realpath"
    # For more info, search for "modify-current-argument" in:
    # http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
    modify-current-argument '${~ARG:a}'
}
zle -N zle-expand-to-realpath
bindkey "^XA" zle-expand-to-realpath

#########
# Expand path containing wildcards by inserting all the matching filenames.
# This used to be the default behavior, but it can be annoying, so I changed
# the default to show matches in a menu instead.
#########
zle-insert-glob-files() {
    set -o LOCAL_OPTIONS
    set -o NOGLOB_COMPLETE
    zle -c expand-or-complete
}
zle -N zle-insert-glob-files
bindkey "^[*"  zle-insert-glob-files   # Alt+shift+8  (i.e. Alt+*)

#########
# Replace argument containing escaped spaces with single-quoted, non-escaped.
# Useful after using tab completion to expand a filename that contains spaces
# #######
zle-single-quote-argument() {
    modify-current-argument '${(qq)${(Q)ARG}}'
}
zle -N zle-single-quote-argument
bindkey "^X'" zle-single-quote-argument

zle-double-quote-argument() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
}
zle -N zle-double-quote-argument
bindkey '^X"' zle-double-quote-argument

#########
# Increment/decrement number under cursor.
# TODO: Make wrapper widget that first moves the cursor left to the nearest
#       number on the command line.
# And make it preserve leading zeros
#########
autoload -U incarg
zle -N incarg
decarg() {
    NUMERIC="-1"
    incarg
}
zle -N decarg
bindkey "^[+" incarg
bindkey "^[_" decarg  # Cant use Alt-- because that is "negative numeric arg"

#########
# Shift-Tab will unconditionally complete files, in case current completion
# won't normally complete files.
# This method came from: http://www.zsh.org/mla/users/2011/msg00974.html
# FIXME: Not colorized like normal file completeion
#########
zle -C complete-file menu-expand-or-complete _generic
zstyle ':completion:complete-file:*' completer _files
bindkey "^[[Z" complete-file # Shift-Tab: Do regular file completion
