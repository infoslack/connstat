# connstat
Script filter for Netstat to check the total number of connections(TCP/UDP)

## Why ?
Whenever I need to check the total connections (TCP/UDP) and
check the list ips eliminating the repeated with [Netstat](http://linux.die.net/man/8/netstat),
the command line ends up being too long:

```
$ netstat -alpn | grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
```
My initial solution was to create a shortcut to the giant command,
so I sent the values to `grep`: `tcp`, `udp` and port numbers `:22`, `:80`, etc.
I wanted to practice my skills in shell script, so I prepared this little interface =)

## Usage
For example, filter port 443:
```
$ ./connstat.sh -p 443
    1 104.27.150.74
    1 173.194.42.181
    1 179.185.163.230
    1 187.58.66.157
    1 187.58.66.183
    1 192.30.252.87
    1 192.30.252.90
    1 192.30.252.92
    1 64.233.190.189
    2 179.185.163.238
    4 54.163.247.71
```

More options:
```
./connstat.sh -h

Usage: connstat.sh [OPTIONS]

OPTIONS
    -a, --all         List all connections (TCP/UDP)
    -t, --tcp         List only TCP connections
    -u, --udp         List only UDP connections
    -p, --port        List connections from a specific port
    -h, --help        Displays this help menu
    -V, --version     Display version
```
You can help by sending Pull Requests ;)

Happy Hacking!
