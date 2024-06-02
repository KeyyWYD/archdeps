export ZSH=$HOME/.zsh

### ---- load modules ----------------------------------------------------------
pfetch
eval $(thefuck --alias)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

### ---- auto completion & suggestions, syntax highlighting --------------------
source $ZSH/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### ---- profile mgmt ----------------------------------------------------------
alias rlp=". ~/.zshrc"
alias ep1="codium ~/.zshrc"
alias ep2="codium ~/.bashrc"

### ---- Shotcuts --------------------------------------------------------------
alias yay-clean='yay -Scc'
alias sys-update='sudo pacman -Syyu'

### ---- Git shortcuts ---------------------------------------------------------
alias gcl='git clone'
alias status='git status'
alias gl='git pull'
alias ga='git add .'
alias pushmain='git push origin main'
alias gd='git diff | mate'
alias gau='git add --update'
alias commit='git commit -m '
alias gca='git commit -v -a'
alias gb='git branch'
alias branch='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log'
alias glogp='git log --pretty=format:"%h %s" --graph'