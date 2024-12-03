

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

Make these changes stay after reboots (persistent)  

### 1. Create a udev rule for `/dev/vcio`

1. Open or create a new udev rules file in `/etc/udev/rules.d/`:

    `sudo nano /etc/udev/rules.d/99-vcio.rules`

2. Add the following line to create the `/dev/vcio` device with the correct permissions:

    `KERNEL=="vcio", MODE="0666", GROUP="video"`

1. Save and exit the file.
 

---

### 2. Reload udev rules

To apply the new udev rule immediately, run:

`sudo udevadm control --reload-rules`   
`sudo udevadm trigger`

---

### 3. Test the configuration

Now, check if the `/dev/vcio` device exists with the correct permissions:

`ls -l /dev/vcio`

