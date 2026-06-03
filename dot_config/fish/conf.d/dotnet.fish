if test -d $HOME/.dotnet
    if not contains -- $HOME/.dotnet/tools $PATH
        set -p PATH $HOME/.dotnet/tools
    end
end

set -gx ASPIRE_CONTAINER_RUNTIME podman

# Added by get-aspire-cli.sh
fish_add_path $HOME/.aspire/bin

# for dev certs
set -gx SSL_CERT_DIR "$HOME/.aspnet/dev-certs/trust:/etc/ssl/certs"
