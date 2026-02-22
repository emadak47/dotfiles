# Add HomeBrew's bin directory to path so you can use HomeBrew's binaries like `starship`
# Fish uses `fish_add_path` instead of `export PATH` modify $PATH.
fish_add_path "/opt/homebrew/bin/"

# Always enable Rust Backtrace
set -x RUST_BACKTRACE 1

# Enable Starship prompt
starship init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Pixi
set -gx PATH "/Users/emadak47/.pixi/bin" $PATH
pixi completion --shell fish | source

#### Aliases ####

# shell
alias c='clear'
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'

# eza
alias eza='eza --long --all'

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

