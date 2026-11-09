# Repository guidance

## Source vs. live configuration
- This is chezmoi's source state, not an application. Edit files here: `dot_config/` maps to `~/.config/`, and `dot_local/` to `~/.local/`. `executable_` and `private_` are chezmoi attributes; `.tmpl` files use Go templates, despite VS Code's Handlebars association.
- `.chezmoi.yaml.tmpl` defines host data and package lists. macOS selects `hosttype=work`; WSL selects `wsl`; other Linux hosts choose `desktop` or `laptop`. `.chezmoiignore` uses destination paths and gates most desktop configuration specifically on `osid=linux-arch` and `hosttype=desktop`.
- Preview with `chezmoi --no-pager diff ~/.config/<tool>/<file>` (destination path), or render a source template with `chezmoi execute-template --file dot_config/<tool>/<file>.tmpl`. Rendering on this machine only checks its current host branch.
- Treat `chezmoi apply` as deployment, not validation: `.chezmoiscripts/run_onchange_*` can install packages, upgrade Arch, enable services, and change desktop defaults. Apply only when requested, scoped to intended targets.
- Source-state reads can run `.decrypt-private-key.sh`, which prompts for a passphrase if `~/.config/chezmoi/key.txt` is missing. Keep the identity outside Git; `key.txt.age` is the encrypted bootstrap key.
- Keep repository-only guidance in `.chezmoiignore`, like `README.md` and `AGENTS.md`, so it is not deployed into `$HOME`.

## Deployed configuration
- The OpenCode configuration under `dot_config/opencode/` is deployed user configuration, not a root project config.

## Focused verification
- There is no root build/lint/test pipeline or CI configuration. Check the affected tool or render its template rather than inventing a package-manager workflow.
