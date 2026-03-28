set --export BUN_INSTALL "$HOME/.bun"

if test -d $BUN_INSTALL
    if not contains -- $BUN_INSTALL/bin $PATH
        set -p PATH $BUN_INSTALL/bin
    end
end
