if test -d $HOME/.opencode
    if not contains -- $HOME/.opencode/bin $PATH
        set -p PATH $HOME/.opencode/bin
    end
end