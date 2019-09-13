# ugly solution to getting env vars `$GITLAB_URL` and `$GIT_ROOT_ROOT`
source ~/repos/dotfiles/.work_fish_config

# Add dotfiles subdir for fish function path
set fish_function_path ~/.config/fish/functions_from_dotfiles $fish_function_path

set -gx EDITOR vim

# Need to spend time cleaning this up
# I don't think these do anything since I'm not using the fish git prompt stuff
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Faster FZF init
set -x FZF_DEFAULT_COMMAND 'ag -g ""'

# Allow vim-style page up/down
# Lighter-colored foreground text and background
# the ctrl-a:select-all allows for ctrl-a -> ctrl-q for quickfix list, which is weird
set -x FZF_DEFAULT_OPTS '
    --bind=ctrl-d:page-down,ctrl-u:page-up,ctrl-a:select-all
    --color bg:234,fg:246
    '

# Not sure how useful these are
if not set -q abbrs_initialized
    abbr -a ht "history --show-time='%m-%d %a %I:%M:%S %p: ' | fzf"
    abbr -a gs git status
    abbr -a ga git add
    abbr -a gb git branch
    abbr -a gc git commit
    abbr -a gd git diff
    abbr -a gdc git diff --cached
    abbr -a go git checkout
    abbr -a gp git pull
end

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
# set fish_key_bindings fish_vi_key_bindings
set fish_pager_color_completion normal
set fish_pager_color_description 555\x1eyellow
set fish_pager_color_prefix cyan
set fish_pager_color_progress cyan
