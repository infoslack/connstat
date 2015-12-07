# connstat
Script filter for Netstat to check the total number of connections(TCP/UDP)

## Why ?
Whenever I need to check the total connections (TCP/UDP) with [Netstat](http://linux.die.net/man/8/netstat),
the command line ends up being too long:

```
$ netstat -alpn | grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
```
My initial solution was to create a shortcut to the giant command,
so I sent the values to `grep`: `tcp`, `udp` and port numbers `:22`, `:80`, etc.
I wanted to practice my skills in shell script, so I prepared this little interface =)

You can help by sending Pull Requests ;)

Happy Hacking!
