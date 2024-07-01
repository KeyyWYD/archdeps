
ZSH=$HOME/.zsh
EDITOR=codium

check_aur() {
    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    fi
}
check_aur

### ---- zsh plugins -----------------------------------------------------------
#source $ZSH/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### ---- Fetch  ----------------------------------------------------------------
# neofetch
# pfetch
fastfetch
# catnap

### ---- Modules ---------------------------------------------------------------
eval $(thefuck --alias)
eval "$(zoxide init zsh)"

### ---- profile mgmt ----------------------------------------------------------
alias rlp=". ~/.zshrc"
alias ezp="$EDITOR ~/.zshrc"
alias ebp="$EDITOR ~/.bashrc"

### ---- Handy dir shortcuts ---------------------------------------------------
alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ls='eza -lha --git --git-repos --icons=auto'
alias mkdir='mkdir -p'

### ---- Handy aliases ---------------------------------------------------------
alias cls='clear'
alias vc='$EDITOR'
alias rmpkg='$AUR_HELPER -Rns'
alias clpkg='$AUR_HELPER -Sc'
alias sysup='$AUR_HELPER -Syyu'

### ---- Git shortcuts ---------------------------------------------------------
alias gcl='git clone'
alias status='git status'
alias gl='git pull'
alias ga='git add .'
alias gd='git diff | mate'
alias gau='git add --update'
alias gcm='git commit -m'
alias gca='git commit -v -a'
alias gb='git branch'
alias branch='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'
alias pushmain='git push origin main'
alias pushmaster='git push origin master'