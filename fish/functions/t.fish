function t
    ls $TOOL_REPOS_ROOT | fzf | read -l target_dir; and cd $TOOL_REPOS_ROOT/$target_dir
end
