#!/usr/bin/env bash
set -euxo pipefail

mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.config/git"
mkdir -p "$HOME/.config/mise"
mkdir -p "$HOME/.config/atuin"
mkdir -p "$HOME/.config/helix"

ln -sf "$PWD/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
ln -sf "$PWD/.config/git/config" "$HOME/.config/git/config"
ln -sf "$PWD/.config/git/ignore" "$HOME/.config/git/ignore"
ln -sf "$PWD/.config/mise/config.toml" "$HOME/.config/mise/config.toml"
ln -sf "$PWD/.config/atuin/config.toml" "$HOME/.config/atuin/config.toml"
ln -sf "$PWD/.config/helix/config.toml" "$HOME/.config/helix/config.toml"
ln -sf "$PWD/.config/helix/languages.toml" "$HOME/.config/helix/languages.toml"

mise trust
mise install -y
$(mise which atuin) account login \
    --username "$ATUIN_USERNAME" \
    --password "$ATUIN_PASSWORD" \
    --key "$ATUIN_KEY"
$(mise which atuin) sync
$(mise which gh) auth setup-git
