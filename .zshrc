# If you come from bash you might have to change your $PATH.

# custom: add homebrew binaries to PATH
export PATH="/opt/homebrew/bin:$HOME/.local/bin:$PATH"

# custom: add database clients to PATH
export PATH="/opt/homebrew/opt/libpq/bin:/opt/homebrew/opt/mysql-client/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/amagalhaes/.oh-my-zsh"

fpath+=$HOME/.zsh/pure
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git jsontools kubectl terraform)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# terminal env
autoload -U promptinit; promptinit
prompt pure

# rust aliases
alias rustdoc="rustup doc --toolchain=stable-x86_64-apple-darwin"

# python aliases
alias python="python3"
alias purge-pip-cache="python -m pip cache purge"

# vpn aliases
alias reset-vpn="sudo route delete pcs.flxvpn.net"
alias kill-vpn="sudo kill -SEGV $(ps auwx | grep dsAccessService | grep Ss | awk '{print $2}')"
alias reset-vpn-daemon="sudo launchctl unload -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist; sudo launchctl load -w /Library/LaunchDaemons/net.pulsesecure.AccessService.plist"

# git aliases
alias git-effort="git log --pretty=format: --name-only | sort | uniq -c | sort -rg"

# network aliases
alias flush-dns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# container aliases
alias psdocker="docker ps -q | xargs docker stats --no-stream"

# container utilities
search_dockerhub() {
  curl -s "https://hub.docker.com/api/content/v1/products/search?source=community&q=$1&page=1&page_size=10" | jq -r '.summaries[]["name"]'
}

fetch_tags_dockerhub() {
  curl -s "https://hub.docker.com/v2/repositories/$1/tags/?page_size=25&page=1" | jq -r '.results[]["name"]'
}

# mac utilities
alias wifi-pass="sudo security find-generic-password -D 'AirPort network password' -wa paodequeijo"
alias toggle-mac-theme="osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
alias fancy-date="date '+DATE: %Y-%m-%d%nTIME: %H:%M:%S'"
alias time-ams="TZ=Europe/Amsterdam fancy-date"
alias time-sp="TZ=America/Sao_Paulo fancy-date"
alias time-la="TZ=America/Los_Angeles fancy-date"
alias l="exa -lah"

export BAT_THEME="base16-256"

# work env vars 
## create a .workenvrc file with the following command:
## touch ~/.workenvrc && chmod +x ~/.workenvrc

[ -f ~/.workenvrc ] && source ~/.workenvrc

# tooling directories
export LIBRARY_PATH=$(brew --prefix openssl)/lib:$LIBRARY_PATH
export SDKMAN_DIR="$HOME/.sdkman"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export GCLOUD_SDK_DIR="$HOME/Projects/Personal/google-cloud-sdk"

# load tooling
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
if [ -f "$GCLOUD_SDK_DIR/path.zsh.inc" ]; then . "$GCLOUD_SDK_DIR/path.zsh.inc"; fi

# autocomplete utilities
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bitcomplete bit
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if [ -f "$GCLOUD_SDK_DIR/completion.zsh.inc" ]; then . "$GCLOUD_SDK_DIR/completion.zsh.inc"; fi

# --------------------------------------------------------- # 
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!! #
# --------------------------------------------------------- # 

[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
