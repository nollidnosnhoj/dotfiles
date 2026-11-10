# dotfiles

My dotfiles, managed by [chezmoi]

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
