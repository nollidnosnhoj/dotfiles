if test -d ~/.local/bin
    fish_add_path -p ~/.local/bin
end

if command -q mise
    mise activate fish | source
end
