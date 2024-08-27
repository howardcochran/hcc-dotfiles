# For unknown reasons (a bug?), if $EDITOR is set during zsh's execution of
# /etc/zsh/zshrc at startup, then many useful completion-related bindings
# fail to happen, at least for Zsh 5.8.1 on Ubuntu. Example: "C-x m" to expand
# most recent file.
#
# Workaround this by unsetting EDITOR here (this file gets executed just
# before /etc/zsh/zshrc). My ~/.zshrc sets $EDITOR anyway, so this temporary
# unsetting of it won't cause any problems.
#
# However, don't do it for non-interactive shells, since they won't execute
# ~/.zshrc (not that it likely matters, cuz you're not likely to run the
# EDITOR in a non-interactive environment, but oh well).
[[ -o interactive ]] && unset EDITOR
