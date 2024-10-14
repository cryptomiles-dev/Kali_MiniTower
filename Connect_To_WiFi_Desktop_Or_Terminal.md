
## Connect To WiFi In Desktop Mode

To connect to WiFi when connected the tradtional way simply click the icons at >
screen and you will see WiFi in the pop down.  Click WiFi then select your netw>
enter the credentials.

## Connect to WiFi when connected the headless way - ie. from the terminal.

#### Search for available WiFi networks 
`nmcli device wifi list`

#### Connect to a WiFi network

 Replace `SSID` with your WiFi networks SSID and `password` with your password.
`nmcli device wifi connect "SSID" password "your_password"`
If your password contains special characters like !#@$ etc then use single quotes instead:
`nmcli device wifi connect 'mySSID' password 'myPA$$!word'`

**NOTE:** NetworkManager [nmcli] automatically saves the connection profile.  So in the future if you need to reconnect to the same network you can do this with the following command.  Replace `SSID` with your SSID. 
`nmcli connection up "SSID"`

---

**NOTES**

Once you setup a WiFi connection you do not need an Ethernet cable.  You only n>
Once you connect the device to WiFi the first time the device will automaticall>
`wlan0` is the built in WiFi interface
`eth0` is the built in Ethernet port interface

