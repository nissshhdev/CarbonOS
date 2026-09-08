# CarbonOS root .zshrc
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory sharehistory

autoload -Uz compinit && compinit
setopt PROMPT_SUBST
PROMPT='%F{196}┌──(%F{15}%Broot%b%F{196}@%F{45}carbon-os%F{196})-[%F{15}%~%F{196}]
%F{196}└─%F{196}%B# %b%f'

alias ls='eza --icons --group-directories-first 2>/dev/null || ls --color=auto'
alias ll='eza -la --icons --group-directories-first 2>/dev/null || ls -la --color=auto'
alias cat='bat --style=plain 2>/dev/null || cat'
alias toggle-theme='carbon-toggle-theme'

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
