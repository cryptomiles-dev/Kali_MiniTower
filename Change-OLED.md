

The OLED can be changed if you wish.   There are 45 example scripts for the OLED display already on the device.   
They are located at `/home/pi/luma.examples/examples`    

To use one of these scripts to change the OLED display:  
1. `cd ~/luma.examples/examples`  
2. `python <scriptname.py>`  
For example to use the `bitstamp_ticker.py` script:  
`python bitstamp_ticker.py`  

The OLED display will then display the Bitcoin ticker script on the OLED display.  
This will display the script on the OLED display until reboot.   If you want it to be permanent simply add the scripts name and path to the `.service` file.  

Edit the `.service` file
`sudo nano /etc/systemd/system/minitower_oled.service`
The line that needs to be edited which controls the OLED script at boot is:
`ExecStart=sudo /bin/bash -c '/usr/bin/python3 /usr/local/minitower/sysinfo-net.py'`
So for example, to change the OLED to show the bitstamp_ticker at boot everytime eid the line as shown below:
`ExecStart=sudo /bin/bash -c '/usr/bin/python3 /home/pi/luma.examples/examples/bitstamp_ticker.py'`
**NOTE** The easiest way is to just use the arrow keys to go to the line then only edit the sysinfo-net.py part.  Do not forget to leave the ' at the end it is required.  

Once you are done `CTRL + X` then `Y` to save  

Then reboot  
`sudo reboot`  



