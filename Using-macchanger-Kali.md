## Objective

The objective is to change or fake an original network card’s hardware MAC address. The following article will show how to change MAC address using `macchanger` on Kali Linux.

## Requirements

Privileged access to you Kali Linux system.

## Difficulty

EASY

## Conventions

-   **#** – requires given to be executed with root privileges either directly as a root user or by use of `sudo` command
-   **$** – requires given to be executed as a regular non-privileged user

## Instructions

### Change to a Random MAC address

First, let’s see how we can use `macchanger` to change network card’s hardware MAC address to a random address. We can start by investigating our current MAC address of eg `eth0` network interface. To do this we execute `macchanger` with an option `-s` and an argument `eth0`.  

```
# macchanger -s eth0
```

The network interface you are about to change a MAC address on must be turned off prior your MAC address change attempt. Use `ifconfig` command to turn off your network interface:

```
# ifconfig eth0 down
```

If the following error message appears you have most likely failed to turn off your network interface:

```
ERROR: Can't change MAC: interface up or not permission: Cannot assign requested address
```

Now, its time to change network card’s hardware MAC address to some random hexadecimal numbers:

```
# macchanger -r eth0
```

Bring your network interface up and display your new MAC addres:

```
# ifconfig eth0 down
# macchanger -s eth0
```

### Check new MAC address

Your new MAC address will now show while listing network interface using `ifconfig` command:


### Change to a Specific MAC address

The following procedure on Kali Linux can be used to spoof MAC address to a specific string. This can be achieved by use `maccachnager`‘s `-m` option:

```
# ifconfig eth0 down
# macchanger -m 00:d0:70:00:20:69 eth0
# ifconfig eth0 up
# macchanger -s eth0
```



Use `-l` option to find a MAC address prefix of a specific hardware vendor:

```
# macchanger -l
```


___