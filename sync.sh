#!/usr/bin/env bash
# =============================================================
# AcreetionOS Server — Git Mirror Sync Script
# Pushes to all mirrors: GitHub, GitLab, Codeberg
# =============================================================
set -e

REMOTES=(
    "origin-github-org   git@github.com:AcreetionOS-Code/acreetionos-server.git"
    "origin-github-user  git@github.com:spivanatalie64/acreetionos-server.git"
    "origin-gitlab       git@gitlab.com:sprungles/acreetionos-server.git"
    "origin-gitlab-self  ssh://git@gitlab.acreetionos.org:2499/natalie/acreetionos-server.git"
    "origin-codeberg     ssh://git@codeberg.org/sprunglesontheberg/acreetionos-server.git"
)

log() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

ok() {
    echo -e "\033[1;32m[OK]\033[0m $1"
}

fail() {
    echo -e "\033[1;31m[FAIL]\033[0m $1"
}

cd "$(dirname "$0")"

log "Pushing to all mirrors..."

for remote in "${REMOTES[@]}"; do
    name=$(echo "$remote" | awk '{print $1}')
    url=$(echo "$remote" | awk '{print $2}')
    
    if git remote get-url "$name" &>/dev/null; then
        log "Pushing to $name..."
        if git push "$name" main 2>&1; then
            ok "$name"
        else
            fail "$name (try: git push -f $name main)"
        fi
    else
        log "Adding remote $name..."
        git remote add "$name" "$url"
        log "Pushing to $name..."
        if git push -u "$name" main 2>&1; then
            ok "$name"
        else
            fail "$name"
        fi
    fi
done

echo ""
log "All mirrors synced."
