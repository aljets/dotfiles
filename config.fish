# Need to spend time cleaning this up

set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

function git_branch
    git rev-parse --abbrev-ref HEAD 2> /dev/null
end

# Way, way faster Vagrant SSH. Run vagrant ssh-config to find private key location.
set vagrant_private_key '~/.vagrant.d/boxes/base/0/virtualbox/vagrant_private_key'
function vs
    ssh -Y -i $vagrant_private_key -p 2222 vagrant@127.0.0.1
end

function fish_prompt
    echo -n (prompt_pwd)
    if test -d .hg
        echo -n '['(cat .hg/branch)']'
    end
    if set branch (git_branch)
        echo -n [(set_color bryellow)$branch(set_color normal)]
    end
    echo -n '$ '
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end
end

# Faster FZF init
set -x FZF_DEFAULT_COMMAND 'ag -g ""'
# Allow vim-style page up/down
set -x FZF_DEFAULT_OPTS '--bind=ctrl-d:page-down,ctrl-u:page-up'

# Not sure how useful these are
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff --cached'
alias go='git checkout '
alias gp='git pull'

# https://iterm2.com/documentation-shell-integration.html
source ~/.iterm2_shell_integration.fish

# Theme
set fish_color_autosuggestion 555\x1eyellow
set fish_color_command 005fd7\x1epurple
set fish_color_comment red
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_error red\x1e\x2d\x2dbold
set fish_color_escape cyan
set fish_color_history_current cyan
set fish_color_host \x2do\x1ecyan
set fish_color_match cyan
set fish_color_normal normal
set fish_color_operator cyan
set fish_color_param 00afff\x1ecyan
set fish_color_quote brown
set fish_color_redirection normal
set fish_color_search_match \x2d\x2dbackground\x3dpurple
set fish_color_selection \x2d\x2dbackground\x3dpurple
set fish_color_status red
set fish_color_user \x2do\x1egreen
set fish_color_valid_path \x2d\x2dunderline
set fish_greeting Welcome\x20to\x20fish\x2c\x20the\x20friendly\x20interactive\x20shell\x0aType\x20\x1b\x5b32mhelp\x1b\x5b30m\x1b\x28B\x1b\x5bm\x20for\x20instructions\x20on\x20how\x20to\x20use\x20fish
set fish_key_bindings fish_default_key_bindings
set fish_pager_color_completion normal
set fish_pager_color_description 555\x1eyellow
set fish_pager_color_prefix cyan
set fish_pager_color_progress cyan
