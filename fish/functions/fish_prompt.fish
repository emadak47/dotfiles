# Default

#function fish_prompt --description 'Write out the prompt'
#    set -l last_pipestatus $pipestatus
#    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
#    set -l normal (set_color normal)
#    set -q fish_color_status
#    or set -g fish_color_status red
#
#    # Color the prompt differently when we're root
#    set -l color_cwd $fish_color_cwd
#    set -l suffix '>'
#    if functions -q fish_is_root_user; and fish_is_root_user
#        if set -q fish_color_cwd_root
#            set color_cwd $fish_color_cwd_root
#        end
#        set suffix '#'
#    end
#
#    # Write pipestatus
#    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
#    set -l bold_flag --bold
#    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
#    if test $__fish_prompt_status_generation = $status_generation
#        set bold_flag
#    end
#    set __fish_prompt_status_generation $status_generation
#    set -l status_color (set_color $fish_color_status)
#    set -l statusb_color (set_color $bold_flag $fish_color_status)
#    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
#
#	# echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
#    echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status "\n"$suffix " "
#end

# name: Arrow
# author: Bruno Ferreira Pinto, Pawel Zubrycki

function fish_prompt
    set -l __last_command_exit_status $status

    if not set -q -g __fish_arrow_functions_defined
        set -g __fish_arrow_functions_defined
        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)
            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end

        function _is_git_repo
            type -q git
            or return 1
            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            set -l stat (hg status -mard 2>/dev/null)
            test -n "$stat"
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end
            return 1
        end
    end

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    if test $__last_command_exit_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color➜ "
    if fish_is_root_user
        set arrow "$arrow_color# "
    end

    set -l cwd $cyan(basename (prompt_pwd))

    set -l repo_info
    if set -l repo_type (_repo_type)
        set -l repo_branch $red(_repo_branch_name $repo_type)
        set repo_info "$blue $repo_type:($repo_branch$blue)"

        if _is_repo_dirty $repo_type
            set -l dirty "$yellow ✗"
            set repo_info "$repo_info$dirty"
        end
    end

    echo -n -s $arrow ' '$cwd $repo_info $normal ' '
end
