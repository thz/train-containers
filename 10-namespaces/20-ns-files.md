## just a convention

There is the convention of putting files holding network namespaces into /run/netns/

```
# ip netns add foo
# ls -li /run/netns/foo
4026533023 -r--r--r-- 1 root root 0 Apr  9 23:03 /run/netns/foo
# ip netns exec foo ls -l /proc/self/ns/net
lrwxrwxrwx 1 root root 0 Apr  9 23:04 /proc/self/ns/net -> 'net:[4026533023]'
```

In the following snippet we create+persist a namespace while following the convention. Doing so makes us compatible with what iproute(2) does. So `ip netns` will list our namespace too

```
# touch /run/netns/bar
# unshare --net=/run/netns/bar ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

# nsenter --net=/run/netns/bar ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

# ip netns
bar
foo
```
