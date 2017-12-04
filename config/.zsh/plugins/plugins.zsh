ZSH_PLUGDIR=${0:a:h}

autoload -U is-at-least

if is-at-least 5.1.1; then  # Not compatible with older
    source $ZSH_PLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ==== zsh-syntax-highlighting config ====
# NOTE: This plugin must come LAST cuz it wraps all the other ZLE widgets
source $ZSH_PLUGDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[arg0]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan,bold'
