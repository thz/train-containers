### Create a network namespace and ping into it
```
# create a network namespace
ip netns add foo

# create veth pair and move one iface into netns
ip link add name vethA type veth peer name vethB
ip link set dev vethB netns foo

ip addr add 192.168.0.1/24 dev vethA
ip link set vethA up

# bring vethB up as well
ip netns exec foo bash
  ip addr add 192.168.0.2/24 dev vethA
  ip link set vethA up
  ping -c3 192.168.0.1

ping -c3 192.168.0.2
```
