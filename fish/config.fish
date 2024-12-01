if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setting PATH for Python 3.<x>
# set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Setting PATH for vim-iced
set -x PATH "~/.config/nvim/autoload/vim-iced/bin" "$PATH"
