if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setting PATH for Python 3.<x>
# set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Setting PATH for vim-iced
set -x PATH "~/.config/nvim/autoload/vim-iced/bin" "$PATH"

#### Aliases ####

# shell
alias c='clear'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'

# exa
alias exa='exa --long --all'

# editor
alias nv='nvim'

# tmux
alias tx='tmux'
alias txls='tmux ls'
alias txn='tmux new -s'
alias txat='tmux a -t'

# Git + Tig + unix tree
alias tig='tig --all'
alias g='git'
alias gb='git branch'
alias ggraph='git log --graph --stat --decorate --patch'
alias glog='git log -n'
alias gch='git checkout'
alias gst='git status'
alias gd='git diff'
alias ga='git add'
alias gcm='git commit -m'
alias gf='git fetch'
alias gp='git pull'
alias gs='git stash'
alias gsp='git stash pop'
alias gsd='git stash drop'
alias gss='git stash show'
alias gsl='git stash list'
alias gerase='git credential-osxkeychain erase'

function gtree
    if test (count $argv) -eq 2; and test $argv[1] = "--ff"
        set folder $argv[2]
        git ls-tree -r --name-only HEAD $folder | tree --fromfile
    else
        echo "Usage: gtree --ff FOLDER"
    end
end

fzf --fish | source
