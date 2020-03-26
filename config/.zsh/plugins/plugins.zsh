ZSH_PLUGDIR=${0:a:h}

autoload -U is-at-least

# ==== Frecent directory changing plugin ====
source $ZSH_PLUGDIR/z/z.sh

# ==== zsh-autosuggestions config ====
if is-at-least 5.1.1; then  # Not compatible with older
    source $ZSH_PLUGDIR/zsh-autosuggestions/zsh-autosuggestions.zsh

    # Make zsh-autosuggest ignore these wrapper widgets that I defined in
    # zsh.d/hcc-zle.zsh. Cuz it just invokes an underlying widget which
    # zsh-autosuggest will wrap at that level. Otherwise it double wraps,
    # which breaks the widget. Note that changes to this array only take
    # affect until the first time the ZSH Line Editor is invoked after
    # sourcing the zsh-autosuggestions plugin.
    ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(
        'forward-word-normal'
        'forward-word-bash'
    )
fi

# ==== fast-syntax-highlighting config ====
# NOTE: This plugin must come LAST cuz it wraps all the other ZLE widgets
# NOTE: Prevent reloading of it if we re-source zsh dotfiles because this
#       leads to buildup of zle wrapper widgets so that each re-source
#       takes exponentially longer!
if [[ -z "${FAST_BASE_DIR}" ]]; then
    FAST_WORK_DIR=XDG  # i.e. ~/.config/fsh. Must set before loding plugin
    source ${ZSH_PLUGDIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

if [[ ! -r ${FAST_WORK_DIR}/current_theme.zsh ]]; then
    # First-time initialization of fast-syntax-highlighting
    # Results are cached in $FAST_WORK_DIR
    mkdir -p ${FAST_WORK_DIR}
    fast-theme default
    fast-theme ${ZSH_PLUGDIR}/highlighting-theme-overlay.ini
fi
