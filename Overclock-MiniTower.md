

## Overclock the MiniTower CPU  



- **WARNING use this at your own risk!** Whenever using **any** overclock be sure to keep a close eye on the CPU temperature.
Check CPU temperature with `vcgencmd measure_temp`

The default CPU clock for the Raspberry Pi 5 is 2400 Mhz (2.4 Ghz).  However, the Rapsbery Pi uses a feature called CPU frequency scaling.  
This will make the CPU operate at a lower clock rate when the processor is under a light load.  Normally this is desireable but there are situations where you want to ensure you 
are getting a specific CPU clock speed.  

Check current CPU clock speed `vcgencmd get_config arm_freq`  

The Raspberry Pi CPU supports **CPU throttling**.  This only kicks in if the CPU temperature reaches a certain temperature.   
Above 80 C the CPU will **soft throttle** slightly reducing the CPU clock speed to prevent further temperature increases.  
At higher temperatures the CPU will enter **hard throttle** mode which will drstically reduce the CPU clock speed.  
You can verify if the CPU is being throttled by issuing the command `vcgencmd get_throttled`  

- If you set the overclock at 2400 Mhz it will make the CPU operate at 2400 Mhz st all times even under light load.  
- The `over_voltage` setting of `2` is appropriate for a 2400 Mhz clock.  If you higher than this you need to adjust the voltage accordingly.    


To overclock the CPU on the MiniTower you need to edit the `/boot/config.txt` file and uncomment the 2 options related to overclocking.  (remove the `#`)  

The 2 options to uncomment are 
```
# arm_freq=2400
# over_voltage=2
``` 
You MUST uncomment both of them to overclock the CPU.   Comment them out to revert back to OEM clock.  

Remove the `#` from the beginning of each line.  So afterwards you have:
```
arm_freq=2400
over_voltage=2
```



