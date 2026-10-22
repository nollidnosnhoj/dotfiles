## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

# Emit unique local socket owners as PORT, PROTOCOL, PID, PROCESS.
function __port_processes
    if not command -q lsof
        printf 'This function requires lsof.\n' >&2
        return 1
    end

    command lsof -nP -i -FpcPn | command awk '
        /^p/ { pid = substr($0, 2) }
        /^c/ { process = substr($0, 2) }
        /^P/ { protocol = substr($0, 2) }
        /^n/ {
            address = substr($0, 2)
            sub(/->.*/, "", address)
            sub(/^.*:/, "", address)
            if (address ~ /^[0-9]+$/ && protocol ~ /^(TCP|UDP)$/)
                printf "%s\t%s\t%s\t%s\n", address, protocol, pid, process
        }
    ' | command sort -u -k1,1n -k2,2 -k3,3n
end

# Includes listening sockets and the local ports of established connections.
function ports --description 'List local TCP/UDP ports and their owning processes'
    if test (count $argv) -gt 1
        printf 'Usage: ports [port]\n' >&2
        return 2
    end

    if set -q argv[1]
        if not string match -qr '^[0-9]{1,5}$' -- "$argv[1]"; or test "$argv[1]" -lt 1; or test "$argv[1]" -gt 65535
            printf 'Port must be an integer between 1 and 65535.\n' >&2
            return 2
        end
    end

    set -l rows (__port_processes)
    or return 1

    if set -q argv[1]
        set rows (printf '%s\n' $rows | command awk -v port="$argv[1]" '$1 + 0 == port + 0')
        if not set -q rows[1]
            printf '(None)\n'
            return 0
        end
    end

    begin
        printf 'PORT\tPROTOCOL\tPID\tPROCESS\n'
        if set -q rows[1]
            printf '%s\n' $rows
        end
    end | command column -t -s (printf '\t')
end

function killport --description 'Terminate processes using a local port; pick with fzf if omitted'
    if test (count $argv) -gt 1
        printf 'Usage: killport [port]\n' >&2
        return 2
    end

    set -l port $argv[1]
    if not set -q argv[1]
        if not command -q fzf
            printf 'Usage: killport <port> (install fzf to select interactively)\n' >&2
            return 2
        end
        set -l selected (ports | command fzf --header-lines=1 --prompt='Port to terminate> ')
        or return 1
        set port (string match -r '^\d+' -- $selected)
    end

    if not string match -qr '^[0-9]{1,5}$' -- "$port"; or test "$port" -lt 1; or test "$port" -gt 65535
        printf 'Port must be an integer between 1 and 65535.\n' >&2
        return 2
    end

    set -l rows (__port_processes)
    or return 1
    set -l pids (printf '%s\n' $rows | command awk -v port="$port" '$1 + 0 == port + 0 { print $3 }' | command sort -u)
    if not set -q pids[1]
        printf 'No visible process is using local port %s.\n' "$port" >&2
        return 1
    end

    # Graceful termination only; never escalate privileges or force-kill.
    command kill -TERM $pids
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end
