#!/bin/bash
# Make a bunch of key mappings to help implement something like Vim's
# "registers" using tmux buffers. These are populated in the custom
# buffer-reg key table, which some other binding will switch us to.
# Once the user presses one of these keys, we'll switch to the
# buffer-cmd key table, which will define the various commands that
# can be done with the register.

# Note: I had to use a shell script for this rather than just listing
# all of these bindings in a tmux conf file because doing that would
# generate a "no such key table" error on the preceding unbind.
# Here in the script, we can suppress that error.

function define_reg_key() {
    tmux unbind -Tbuffer-reg "$1" 2>/dev/null
    tmux bind -Tbuffer-reg "$1" set-environment -g TMUXBUF "$1" '\;' switch-client -Tbuffer-cmd
}

for reg in a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9; do
    define_reg_key $reg
done
