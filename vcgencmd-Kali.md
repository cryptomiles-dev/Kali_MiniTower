

Kali for Raspberry Pi 5 does not have `vcgencmd` installed by default.   `vcgencmd` on Raspberry Pi gives a quick and easy way to check CPU clock rates, CPU temperature, CPU throttle status, and more.

To install `vcgencmd` on Raspberry Pi 5 running Kali Linux.


1. Install `raspberrypi utils`

Install prereqs  
`sudo apt install cmake device-tree-compiler libfdt-dev`  

```

git clone https://github.com/raspberrypi/utils.git
cd utils
cmake .
make
sudo make install
```


2. Make `vcgencmd` work correctly  

```
sudo mknod /dev/vcio c 100 0
sudo chmod 666 /dev/vcio
```
