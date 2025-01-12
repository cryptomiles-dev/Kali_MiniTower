

## Set Time/Date Settings Manaully Or NTP  

You have the options of setting the time, date, timezone, keyboard locale, etc all manually or you can enable NTP Network Time Protocol and   
let NTP take care of all of the for you automatically.  

Skip to the bottom for manual configuration commands.  

Check if currently set time, date, timezone, and whether NTP is enabled:  
`timedatectl status`  
If NTP is enabled you will see `NTP service: active`


### Enable NTP  

NTP works by querying your Raspberry Pi to time servers over the internet. These servers   
provide highly accurate time based on atomic clocks. NTP ensures that your device continuously has the correct time.    

**NOTE:** You only have to choose one of the options below.  enable NTP using a script, enable NTP with commands, or change settings with commands reguarly.  Choose 1 method.  
#### Enable NTP Using The Script  

I have provided a script to enable NTP if you want to use it.   It is located  
in the scripts foler and is titled `Enable-Time-NTP.sh`  
To use the script simply download it, make it executable, then execute it.  
```
wget https://raw.githubusercontent.com/cryptomiles-dev/Kali_MiniTower/refs/heads/main/Scripts/Enable-Time-NTP.sh
chmod +x Enable-Time-NTP.sh
sudo ./Enable-Time-NTP.sh
```
Then reboot `sudo reboot`  

#### Enable NTP Using Commands  

Enter the following commands one at a time then press enter:  

```
sudo timedatectl set-ntp true   
sudo systemctl enable systemd-timesyncd   
sudo systemctl start systemd-timesyncd    
```

Verify NTP service:  
`timedatectl status`  

### Change Time/Date Settings Manually     

You can change the time, date, timezone, keyboard country, etc individually using the commands below.     

- List available timezones:   
`timedatectl list-timezones`
- Set the timezone (e.g., for New York, use `America/New_York`):   
`sudo timedatectl set-timezone America/New_York`
- Verify the timezone change:     
`timedatectl status`  

- Change Keyboard Locale    
`sudo nano /etc/default/keyboard`

In Linux the standard keyboard layout used in the USA is called pc105 / us    

```
# KEYBOARD CONFIGURATION FILE

# Consult the keyboard(5) manual page.

XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""

BACKSPACE="guess"
```

