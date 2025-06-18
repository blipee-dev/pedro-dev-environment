# Pedro's Elite Development Environment - Shell Configuration
# This configuration provides 60+ aliases and modern development tools

# PATH Configuration
export PATH=$HOME/.npm-global/bin:$PATH
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# Enhanced Shell Configuration
export EDITOR="code --wait"
export VISUAL="code --wait"

# History Configuration
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Key Bindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Aliases - Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Aliases - Git
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdc='git diff --cached'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias gsta='git stash push'
alias gstp='git stash pop'
alias gstl='git stash list'

# Aliases - npm/pnpm
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias nrt='npm run test'
alias nrl='npm run lint'

# Aliases - Directory Listing (Enhanced with modern tools)
alias ls='eza --color=always --group-directories-first'
alias ll='eza -la --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias l='eza -F --color=always --group-directories-first'
alias lt='eza -la --sort=modified --color=always'
alias tree='eza --tree --color=always'

# Fallback to system ls if eza not available
if ! command -v eza &> /dev/null; then
    alias ls='ls -GFh'
    alias ll='ls -la'
    alias la='ls -A'
    alias l='ls -CF'
    alias lt='ls -ltr'
fi

# Aliases - Safety
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Aliases - Utilities (Enhanced with modern tools)
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias reload='source ~/.zshrc'
alias myip='curl -s https://ipinfo.io/ip'
alias weather='curl wttr.in'
alias cat='bat --style=auto'
alias grep='rg'
alias find='fd'
alias ps='procs'

# Fallback to system tools if modern alternatives not available
if ! command -v bat &> /dev/null; then
    alias cat='cat'
fi

if ! command -v rg &> /dev/null; then
    alias grep='grep --color=auto'
fi

# Modern Git UI
alias tig='lazygit'

# Functions

# Create directory and cd into it
mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Git commit with message
gcmsg() {
    git commit -m "$*"
}

# Find process
findps() {
    ps aux | grep -v grep | grep -i "$@"
}

# Kill process by name
killps() {
    local pid
    pid=$(ps -ax | grep -v grep | grep -i "$@" | awk '{print $1}')
    if [ -z "$pid" ]; then
        echo "No process found"
    else
        echo "Killing process $pid"
        kill -9 $pid
    fi
}

# Extract archives
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick backup
backup() {
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# Search in history
histgrep() {
    history | grep "$@"
}

# Node version management (if fnm is installed)
if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
fi

# Enable syntax highlighting (install with: brew install zsh-syntax-highlighting)
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Enable autosuggestions (install with: brew install zsh-autosuggestions)
if [ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Claude Code specific aliases
alias claude='claude'
alias cc='claude'
alias cide='claude ide'

# Blipee Toolpad Automation
export PATH="$HOME/.blipee-automation:$PATH"
alias blipee='$HOME/.blipee-automation/blipee'

# Development shortcuts
alias dev='npm run dev'
alias build='npm run build'
alias test='npm test'
alias lint='npm run lint'
alias format='npm run format'

# Quick navigation to common directories
alias projects='cd ~/Documents/projects'
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'

# Color support
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Prompt configuration (simple and clean)
PROMPT='%F{blue}%~%f %F{green}❯%f '

# Homebrew configuration
eval "$(/opt/homebrew/bin/brew shellenv)"

# Enhanced shell features
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi