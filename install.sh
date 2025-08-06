#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

log() {
    echo "[INFO] $1"
}

: "${ATUIN_USERNAME:?Environment variable ATUIN_USERNAME is not set}"
: "${ATUIN_PASSWORD:?Environment variable ATUIN_PASSWORD is not set}"
: "${ATUIN_KEY:?Environment variable ATUIN_KEY is not set}"

log "Creating configuration directories..."
mkdir -p "$CONFIG_DIR/fish" "$CONFIG_DIR/git" "$CONFIG_DIR/mise" "$CONFIG_DIR/atuin" "$CONFIG_DIR/helix"

log "Creating symlinks for configuration files..."
ln -sf "$SCRIPT_DIR/.config/fish/config.fish" "$CONFIG_DIR/fish/config.fish"
ln -sf "$SCRIPT_DIR/.config/git/config" "$CONFIG_DIR/git/config"
ln -sf "$SCRIPT_DIR/.config/git/ignore" "$CONFIG_DIR/git/ignore"
ln -sf "$SCRIPT_DIR/.config/mise/config.toml" "$CONFIG_DIR/mise/config.toml"
ln -sf "$SCRIPT_DIR/.config/atuin/config.toml" "$CONFIG_DIR/atuin/config.toml"
ln -sf "$SCRIPT_DIR/.config/helix/config.toml" "$CONFIG_DIR/helix/config.toml"
ln -sf "$SCRIPT_DIR/.config/helix/languages.toml" "$CONFIG_DIR/helix/languages.toml"

log "Trusting directories with mise..."
if command -v mise &>/dev/null; then
    # mise trust "$HOME/.config/mise/config.toml"
    # mise trust "/workspaces/*"
    mise trust
    mise install -y
else
    log "mise command not found. Skipping mise-related tasks."
fi

if command -v mise &>/dev/null; then
    log "Logging into Atuin..."
    "$(mise which atuin)" account login \
        --username "$ATUIN_USERNAME" \
        --password "$ATUIN_PASSWORD" \
        --key "$ATUIN_KEY"

    log "Syncing Atuin data..."
    "$(mise which atuin)" sync
else
    log "Atuin command not found. Skipping Atuin-related tasks."
fi

if command -v mise &>/dev/null; then
    log "Setting up GitHub CLI authentication..."
    "$(mise which gh)" auth setup-git
else
    log "GitHub CLI command not found. Skipping GitHub-related tasks."
fi

log "Dotfiles installation completed successfully."
