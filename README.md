# dots
personal dotfiles

## Install chezmoi and your dotfiles on a new machine with a single command

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot $GITHUB_USERNAME
```

```powershell
iex "&{$(irm 'https://get.chezmoi.io/ps1')}" -- init --one-shot $GITHUB_USERNAME
```
