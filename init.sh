#/bin/sh

GITHUB_USERNAME=Wszl
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
