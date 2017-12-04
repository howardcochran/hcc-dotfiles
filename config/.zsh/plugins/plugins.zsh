ZSH_PLUGDIR=${0:a:h}

source $ZSH_PLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==== zsh-syntax-highlighting config ====
# NOTE: This plugin must come LAST cuz it wraps all the other ZLE widgets
source $ZSH_PLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan,bold'
