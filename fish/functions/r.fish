function r
    # probably don't need to know if it's an actual git repo anymore since I only put git repos in there now
    # find $GIT_REPO_ROOT -type d -name ".git" | python3.7 -c "import sys; [print('/'.join(line.split('/')[4:-1])) for line in sys.stdin]" | fzf | read -l target_dir; and cd $GIT_REPO_ROOT/$target_dir, etc.
    set -l root $GIT_REPO_ROOT
    test -z "$root"; and set -l root "."
    ls $root | fzf | read -l target_dir; and cd $root/$target_dir
end
