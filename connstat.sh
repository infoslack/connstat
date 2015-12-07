#!/bin/bash
# connstat.sh
#
# Filter netstat to check the total number of connections (TCP/UDP) open.
# Performs filter for specific ports and inform the ip number.
#
# Version 0.1: Added -a option for full listing
# Version 0.2: Added -t and -u options for tcp and udp listing
# Version 0.3: Added -p option for specific ports
#
# @infoslack - 2015

all=0
tcp=0
udp=0
port=0

MSG_HELP="
Connstat is a filter for Netstat to check the total number of connections(TCP/UDP)

Usage: $(basename "$0") [OPTIONS]

OPTIONS
    -a, --all         List all connections (TCP/UDP)
    -t, --tcp         List only TCP connections
    -u, --udp         List only UDP connections
    -p, --port        List connections from a specific port
    -h, --help        Displays this help menu
    -V, --version     Display version
"

if [ -z "$1" ]; then
    echo "$MSG_HELP"
    exit
else

    while test -n "$1"
    do
        case "$1" in

            -a | --all  )   all=1 ;;
            -t | --tcp  )   tcp=1 ;;
            -u | --udp  )   udp=1 ;;

            -p | --port)
                port=1

                shift
                number="$1"

                if test -z "$number"
                then
                    echo "You must specify the port number"
                    exit 1
                fi
            ;;

            -h | --help)
                echo "$MSG_HELP"
                exit 0
            ;;

            -V | --version)
                echo -n $(basename "$0")
                grep '^# Version ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
                exit 0
            ;;

            *)
                echo Invalid option: $1
                exit 1
            ;;
        esac
        shift
    done
fi

connections=$(netstat -alpn)
test "$all"   = 1 && connections=$(echo "$connections" | grep 'tcp\|udp')
test "$tcp"   = 1 && connections=$(echo "$connections" | grep 'tcp')
test "$udp"   = 1 && connections=$(echo "$connections" | grep 'udp')
test "$port"  = 1 && connections=$(echo "$connections" | grep :"$number")
echo "$connections" | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
