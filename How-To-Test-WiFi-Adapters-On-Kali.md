

# Testing WiFi Adapter Capabilities  

A basic description of monitor mode and packet injection

- Monitor mode allows a computer to capture all wireless traffic in its range, providing visibility into the network regardless of intended destination or source.   
- Packet injection is the process of sending unauthorized packets into an established network connection, often used to interfere with legitimate communications. Together, these techniques are commonly employed in network analysis and security testing, including man-in-the-middle (MITM) and denial-of-service (DoS) attacks.

## Testing a WiFi adapter for monitor mode and packet injection support.  

To check if a WiFi adapter supports monitor mode.

1. Find your adapters name [wlan0, wlan1, or ath0] for example  
    `ip link`  
2. Check monitor mode support   
    `sudo iw list`  
Scroll up and look for the following:  
```
Supported interface modes:
                 * IBSS
                 * managed
                 * AP
                 * monitor
                 * P2P-client
                 * P2P-GO
                 * P2P-device
```
If "monitor" is listed under Supported interface modes then the adapter supports monitor mode.    

## Put Adapter Into Monitor Mode  


### Monitor Mode With airmon-ng  

Before putting any adapter into montir mode you should kill conflicting processes.  Luckily airmon-ng has built in ways to do this.  

1. Display conflicting processes (if any)   
`sudo airmon-ng check`
2. Kill conflicting processes  
`sudo airmon-ng check kill`    
3. Enable monitor mode   
`sudo airmon-ng start wlan0`

### Manual Monitor Mode  


To set a Wi-Fi card in monitor mode:

`sudo ip link set wlan0 down`  
`sudo iw wlan0 set monitor control`  
`sudo ip link set wlan0 up`  

---

## Checking for packet injection support.  

**NOTE** I will use `wlan0` in these examples.   Substitute your adapters name as needed.  On most systems airmon-ng renames the adapter be appending `mon` to the end of the adapters name.   So `wlan0` becomes `wlan0mon`.  This guide assums the adapter is renamed to `wlan0mon`.  Youcan always check your device name by simply running the command `ip link`.  Make sure to use the correct interface name.

1. Start monitor mode on your adapter  
    `sudo airmon-ng start wlan0`    
2. Verify the adapter is in monitor mode and verify if renamed to `wlan0mon`  
    `iw dev`  
    The mode the adapter is **currently** in will be listed as `type managed` or `type monitor`

**NOTE** Assuming the WiFi adapter is renamed from `wlan0` to `wlan0mon`  
3. Test packet injection   
    `sudo aireplay-ng --test wlan0mon`  
Aireplay-ng will perform a series of injection tests and display the results.
```
 11:01:06  wlan0 channel: 9
 11:01:06  Trying broadcast probe requests...
 11:01:06  Injection is working!
 11:01:07  Found 1 APs
 
 11:01:07  Trying directed probe requests...
 11:01:07  00:14:6C:7E:40:80 - channel: 9 - 'teddy'
 11:01:07  Ping (min/avg/max): 2.763ms/4.190ms/8.159ms
 11:01:07  30/30: 100%
```


The message "Injection is working!" indicates that the network card is capable of injecting packets successfully.
30/30: Indicates that 30 directed probe requests were sent and 30 responses were received.
100%: All probe requests were successfully acknowledged, indicating reliable packet injection and reception.


