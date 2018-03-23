function r
    find $GIT_ROOT_ROOT -type d -name ".git" | python3.6 -c "import sys; [print('/'.join(line.split('/')[4:-1])) for line in sys.stdin]" | fzf | read -l target_dir; and cd $GIT_ROOT_ROOT/$target_dir
end
