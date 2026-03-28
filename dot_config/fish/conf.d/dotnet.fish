if test -d $HOME/.dotnet
    if not contains -- $HOME/.dotnet/tools $PATH
        set -p PATH $HOME/.dotnet/tools
    end
end