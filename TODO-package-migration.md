# Package migration to mise

Before removing native packages on each machine:

- [ ] Deploy the updated mise configuration and Fish configuration.
- [ ] Run `mise install` successfully.
- [ ] Open a new shell and verify the migrated commands work through mise.

## Arch Linux — pacman

- [ ] Remove `eza`
- [ ] Remove `fd`
- [ ] Remove `fzf`
- [ ] Remove `github-cli` (mise key: `gh`)
- [ ] Remove `jq`
- [ ] Remove `lazygit`
- [ ] Remove `ripgrep`

```bash
sudo pacman -R eza fd fzf github-cli jq lazygit ripgrep
```

## macOS — Homebrew formulae

- [ ] Remove `copilot-cli` (mise key: `copilot`)
- [ ] Remove `eza`
- [ ] Remove `fd`
- [ ] Remove `fzf`
- [ ] Remove `gh`
- [ ] Remove `helm`
- [ ] Remove `jq`
- [ ] Remove `kustomize`
- [ ] Remove `lazygit`
- [ ] Remove `ripgrep`
- [ ] Remove `tree-sitter`

```bash
brew uninstall --formula copilot-cli eza fd fzf gh helm jq kustomize lazygit ripgrep tree-sitter
```

## macOS — Homebrew casks

- [ ] Confirm the mise-provided Codex CLI is the intended replacement.
- [ ] Remove `codex`.

```bash
brew uninstall --cask codex
```

If a package manager reports dependent packages, review those dependencies rather
than forcing removal. These lists cover only packages migrated to mise; keep the
remaining native packages installed.
