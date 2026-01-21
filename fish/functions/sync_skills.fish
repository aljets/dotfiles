function sync_skills --description "Sync skills from dotfiles to Claude/Crush"
    # Accept optional skills source directory
    set -l skills_source $argv[1]
    if test -z "$skills_source"
        set skills_source ~/tools/dotfiles/skills
    end

    set -l skills_targets ~/.claude/skills ~/.config/skills

    # Only run if skills directory exists
    if test -d $skills_source
        # Sync to both target directories
        for skills_target in $skills_targets
            mkdir -p $skills_target

            # Symlink each skill
            for skill in $skills_source/*
                if test -d $skill
                    set -l skill_name (basename $skill)
                    set -l target_link $skills_target/$skill_name

                    # Create/update symlink if needed
                    if not test -L $target_link; or test (readlink $target_link) != $skill
                        ln -sf $skill $target_link
                    end
                end
            end
        end
    end
end
