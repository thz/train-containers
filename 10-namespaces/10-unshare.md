## unshare syscall

### network namespace

```
% unshare -n ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
```

### pid namespace

This one has an interesting aspect. According to section CLONE_NEWPID in unshare(2):
"The calling process is *not* moved into the new namespace. The first child created by the calling process will have the process ID 1 and will assume the role of init(1) in the new namespace."

So the calling process `unshare` execs itself to become `bash`, the shell itself is in the old pid namespace, but its first child process becomes the new pid 1 (init role, child reaper). Without init new processes cannot be allocated (signaled by ENOMEM). Adding the the -f(ork) option to unshare will fork a new process before executing the shell. By doing so the shell becomes PID 1 and the issue is resolved.


```
% unshare -p /bin/bash --norc
bash-4.4# ps
   PID TTY          TIME CMD
 44851 pts/12   00:00:00 sudo
 44852 pts/12   00:00:00 zsh
 44880 pts/12   00:00:00 bash
 44881 pts/12   00:00:00 ps
bash-4.4# ps
bash: fork: Cannot allocate memory

% unshare -fp /bin/bash --norc
# ps | grep bash
 45429 pts/12   00:00:00 bash
# kill 45429
bash: kill: (45429) - No such process
```

Also note: `ps` is just reading `/proc` and not necessarily giving you the actual processes of the new (almost empty) pid namespace. But `kill` as a system call itself indicates correctly that the respective process does not exist in the namespace. This can be fixed by unsharing the mount namespace too and having a dedicated /proc. And unshare(1) even has options for that:

```
# unshare -fp -m --mount-proc /bin/bash --norc
bash-4.4# ps
   PID TTY          TIME CMD
     1 pts/1    00:00:00 bash
     2 pts/1    00:00:00 ps

```


