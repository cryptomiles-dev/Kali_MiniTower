### Change the OLED display to show CPU temp. on the top line  


`sysinfo-net-w-temp.py`  This script is an updated version of the one that the MiniTower ships with.  It displays the CPU temperature on the top line instead of the load averages.  

To use this script, on the MiniTower.
1. Git the new script, make it executable, then copy it over to the correct directory:
```
git clone https://github.com/cryptomiles-dev/Kali_MiniTower.git
cd Kali_MiniTower
chmod +x sysinfo-net-w-temp.py
sudo cp sysinfo-net-w-temp.py /usr/local/minitower
```
2. Edit the service file to run the new script instead of the current one:
```
sudo nano /etc/systemd/system/minitower_oled.service  
```
Change the following line:  
`ExecStart=sudo /bin/bash -c '/usr/bin/python3 /usr/local/minitower/sysinfo-net-w-temp.py'`  
Change only `sysinfo-net.py` to `sysinfo-net-w-temp.py`  
The line should look like this.  You can copy and paste it.   **The tick marks are included**
`ExecStart=sudo /bin/bash -c '/usr/bin/python3 /usr/local/minitower/sysinfo-net-w-temp.py'`  

3. Reload the `systemctl` daemon
`sudo systemctl daemon-reload`
Start the `minitower_oled` service
`sudo systemctl start minitower_oled.service`
Just to be certain make sure it is enabled (starts at boot)
`sudo systemctl enable minitower_oled.service`


---

If you do not want the whole repo and only want the CPU temperature python script then you can download just the CPU temperature python script using `wget`.  To do this replace step 1. with the following:  
```  
wget https://raw.githubusercontent.com/cryptomiles-dev/Kali_MiniTower/refs/heads/main/sysinfo-net-w-temp.py   
chmod +x sysinfo-net-w-temp.py
sudo cp sysinfo-net-w-temp.py /usr/local/minitower
```
Then proceed to step 2. above.
