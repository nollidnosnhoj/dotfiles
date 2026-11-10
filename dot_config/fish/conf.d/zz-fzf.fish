# Set up fzf key bindings
if command -q fzf
    fzf --fish | source
else if command -q mise
    set -l fzf_bin (mise which fzf 2>/dev/null)
    if test -n "$fzf_bin"
        "$fzf_bin" --fish | source
    end
end
