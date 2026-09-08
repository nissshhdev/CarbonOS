# CarbonOS .zshrc - Styled with IBM Carbon Design System & IBM Plex Mono

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory sharehistory incappendhistory

# Basic Keybindings
bindkey -e
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# Completion System
autoload -Uz compinit
compinit -d ~/.zcompdump
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# IBM Carbon Colors (ANSI 256)
# IBM Blue: 33 / 27 (#0f62fe)
# Carbon Gray: 242 / 238
# Carbon Cyan: 45 (#1192e8)
# Carbon Green: 42 (#42be65)
# Carbon Purple: 135 (#a56eff)

# Custom Carbon Prompt
autoload -Uz vcs_info
precmd() {
    vcs_info
}
zstyle ':vcs_info:git:*' formats '%F{135}(%b)%f '

setopt PROMPT_SUBST
PROMPT='%F{33}┌──(%F{15}%Bcarbon%b%F{33}@%F{45}carbon-os%F{33})-[%F{15}%~%F{33}] ${vcs_info_msg_0_}
%F{33}└─%F{33}%B$ %b%f'

# Aliases
alias ls='eza --icons --group-directories-first 2>/dev/null || ls --color=auto'
alias ll='eza -la --icons --group-directories-first 2>/dev/null || ls -la --color=auto'
alias la='eza -a --icons --group-directories-first 2>/dev/null || ls -a --color=auto'
alias cat='bat --style=plain 2>/dev/null || cat'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias drawer='xfce4-popup-whiskermenu'
alias toggle-theme='carbon-toggle-theme'
alias theme-dark='carbon-toggle-theme dark'
alias theme-light='carbon-toggle-theme light'

# Syntax Highlighting and Autosuggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# CarbonOS Welcome Display
if [[ -o interactive ]] && command -v fastfetch &>/dev/null; then
    fastfetch
fi
