# Set up fzf key bindings
if command -q mise
    mise exec -- fzf --fish | source
else if command -q fzf
    fzf --fish | source
end
