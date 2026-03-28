set -x GOPATH $HOME/go

if test -d $GOPATH
    if not contains -- $GOPATH/bin $PATH
        set -p PATH $GOPATH/bin
    end
end