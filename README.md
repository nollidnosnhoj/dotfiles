# dotfiles

My dotfiles, managed by [chezmoi]

## Set up a CachyOS desktop

Once `chezmoi` and `git` are installed, initialize from this repository and answer
**yes** when asked if the machine has a desktop environment:

```sh
chezmoi init nollidnosnhoj/dotfiles
chezmoi --no-pager diff
```

CachyOS keeps its own `linux-cachyos` ID and uses the same package list and
desktop configuration as Arch Linux. If the age key is not already installed,
chezmoi will prompt for the encrypted bootstrap key's passphrase when reading
the source state.

When you're ready, run `chezmoi apply`. The first apply can install and upgrade
system and AUR packages and change desktop defaults.

## Capture live configuration changes

Run `dotfiles-sync` to copy changes from already-managed files in your home
directory back into this repository:

```sh
dotfiles-sync --dry-run --verbose # Preview changes
dotfiles-sync                   # Update all managed, non-template files
dotfiles-sync ~/.config/fish     # Update only a specific directory
```

The script wraps `chezmoi re-add`: it preserves encryption, skips templates,
and does not import untracked files, apply configuration, or commit changes.
Review the resulting Git diff before committing. Edit `.tmpl` files in this
repository manually when their live configuration changes. To track a new file,
use `chezmoi add <path>` explicitly rather than importing entire configuration
directories (which may contain secrets or application state).

Before the script is installed, use `chezmoi re-add` directly, or install only
the script with `chezmoi apply ~/.local/bin/dotfiles-sync`.
