#!/bin/sh
set -eu

git_get_main_branch() {
    if upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null); then
        remote=${upstream%%/*}
        git rev-parse --abbrev-ref "$remote/HEAD" | sed "s/^$remote\///"
    else
        # If no upstream, we're already the upstream branch
        git rev-parse --abbrev-ref HEAD
    fi
}

echo "TEST!: $(git_get_main_branch)"
# Only act if branch has an upstream
if upstream=$(git rev-parse --abbrev-ref @{u} 2>/dev/null); then
    echo "Upstream: $upstream"
    remote=${upstream%%/*}
    echo "Remote: $remote"
    default_branch_full=$(git rev-parse --abbrev-ref "$remote/HEAD")
    default_branch=${default_branch_full#"$remote/"}
    echo "Default branch: $default_branch"
    echo "Will run: git fetch \"$remote\" \"$default_branch\""
    git fetch "$remote" "$default_branch"

    # Abort if rebase would fail
    echo "Will run: rebase --onto \"$remote/$default_branch\" \"$upstream\""
    git rebase --onto "$remote/$default_branch" "$upstream" || {
        echo "Rebase failed. Fix conflicts, then push."
        exit 1
    }
else
    echo "No upstream, assuming default branch. Push allowed."
fi

