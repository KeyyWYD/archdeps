# OOOOO

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Import
eval "$(starship init bash)"

# Profile Management
alias rlp=". ~/.bashrc"
alias ep="nano ~/.bashrc"

# Git Shortcuts
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
