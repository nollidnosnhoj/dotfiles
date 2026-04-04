if status is-login
  /usr/sbin/wsl2-ssh-agent | source
end

set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/wsl2-ssh-agent.sock
