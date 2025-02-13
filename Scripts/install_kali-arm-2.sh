#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit 1
fi

echo "Welcome to GeeekPi ABS Minitower kit installation Program"

codename=$(lsb_release -c | awk '{print $2}')
arch=$(uname -m)
echo "Detecting system information..." 

if [[ $codename == 'kali-rolling' && $arch == 'aarch64' ]]; then
  echo "OS: Kali Linux 64bit"
  sleep 5
else 
  echo "OS: It's $arch : $codename" 
  sleep 3
fi

echo "Modifying /etc/resolv.conf to use Google DNS" 
sed -i 's/^/#/' /etc/resolv.conf
sed -i '$a\nameserver 114.114.114.114' /etc/resolv.conf
sed -i '$a\nameserver 8.8.8.8' /etc/resolv.conf

echo "Installing basic dependency packages..."
apt update && apt -y -q install git cmake scons python3-dev || { echo "Please check internet connection!"; exit 1; }

echo "Checking and installing dependencies..."
apt -y install python3 python3-pip python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 libtiff5-dev || { echo "Dependency installation failed!"; exit 1; }

echo "Installing psutil library..."
pip3 install psutil --break-system-packages || { echo "psutil installation failed!"; exit 1; }
echo "psutil library installed successfully."

# Grant privileges to the current user (replace with your username if different)
current_user=$(logname)
usermod -a -G gpio,i2c $current_user || { echo "Failed to grant privileges!"; exit 1; }
echo "Privileges granted to user $current_user"

# Download and install luma.examples
cd /tmp
if [ ! -d /tmp/luma.examples ]; then
  while [ ! -d /tmp/luma.examples ]; do 
    git clone https://github.com/rm-hull/luma.examples.git 
  done
  cd /tmp/luma.examples/examples/
  cp -Rvf /tmp/luma.examples/examples /home/$current_user/Downloads/ || { echo "Failed to download repository!"; exit 1; }
  echo "Downloaded repository to /tmp folder"
else 
  echo "luma.examples repository already exists in /tmp folder"
fi 

echo "Installing dependencies inside repository /tmp/luma.examples"
cd /tmp/luma.examples/ && pip3 install -e . --break-system-packages || { echo "Failed to install repository dependencies!"; exit 1; }
echo "Repository dependencies installed successfully"

# Download and install rpi_ws281x libraries
cd /tmp/
if [ ! -d /tmp/rpi_ws281x ]; then
  while [ ! -d /tmp/rpi_ws281x ]; do
    git clone https://github.com/jgarff/rpi_ws281x
  done
  cd /tmp/rpi_ws281x/
  scons && mkdir build && cd build/
  cmake -D BUILD_SHARED=OFF -D BUILD_TEST=ON ..
  make install || { echo "rpi_ws281x installation failed!"; exit 1; }
  cp ./test /usr/bin/moodlight || { echo "Failed to copy moodlight!"; exit 1; }
  echo "Installation finished"
else
  echo "rpi_ws281x repository already exists in /tmp"
fi

# Enable i2c function on Raspberry Pi
echo "Enabling i2c on Raspberry Pi"
sed -i '/dtparam=i2c_arm*/d' /boot/config.txt
sed -i '$a\dtparam=i2c_arm=on' /boot/config.txt
if [ $? -eq 0 ]; then
  echo "i2c has been set up successfully"
else
  echo "Failed to enable i2c"
  exit 1
fi

# Install minitower service
echo "Installing minitower service..."
if [ -f /usr/bin/moodlight ]; then
  echo "moodlight driver installed successfully"
else 
  cp /tmp/rpi_ws281x/build/test /usr/bin/moodlight || { echo "Failed to copy moodlight!"; exit 1; }
fi

if [ ! -e /usr/bin/moodlight ]; then
  cp /tmp/rpi_ws281x/build/test /usr/bin/moodlight || { echo "Failed to copy moodlight!"; exit 1; }
fi

service_file="/etc/systemd/system/minitower_moodlight.service"
cat <<EOF > $service_file
[Unit]
Description=Minitower moodlight Service
DefaultDependencies=no
StartLimitIntervalSec=60
StartLimitBurst=5

[Service]
RootDirectory=/
User=root
Type=simple
ExecStart=sudo /usr/bin/moodlight 
RemainAfterExit=yes
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF

echo "Created systemd service file: $service_file"
chown root:root $service_file
chmod 644 $service_file
systemctl daemon-reload
systemctl enable minitower_moodlight.service
systemctl start minitower_moodlight.service
systemctl restart minitower_moodlight.service

# OLED screen display service
mkdir -pv /usr/local/minitower/ && cd /usr/local/minitower/

demo_opts_file="/usr/local/minitower/demo_opts.py"
cat <<EOF > $demo_opts_file
# -*- coding: utf-8 -*-
# Copyright (c) 2014-2022 Richard Hull and contributors
# See LICENSE.rst for details.

import sys
import logging

from luma.core import cmdline, error


# logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)-15s - %(message)s'
)
# ignore PIL debug messages
logging.getLogger('PIL').setLevel(logging.ERROR)


def display_settings(device, args):
    """
    Display a short summary of the settings.

    :rtype: str
    """
    iface = ''
    display_types = cmdline.get_display_types()
    if args.display not in display_types['emulator']:
        iface = f'Interface: {args.interface}\n'

    lib_name = cmdline.get_library_for_display_type(args.display)
    if lib_name is not None:
        lib_version = cmdline.get_library_version(lib_name)
    else:
        lib_name = lib_version = 'unknown'

    import luma.core
    version = f'luma.{lib_name} {lib_version} (luma.core {luma.core.__version__})'

    return f'Version: {version}\nDisplay: {args.display}\n{iface}Dimensions: {device.width} x {device.height}\n{"-" * 60}'


def get_device(actual_args=None):
    """
    Create device from command-line arguments and return it.
    """
    if actual_args is None:
        actual_args = sys.argv[1:]
    parser = cmdline.create_parser(description='luma.examples arguments')
    args = parser.parse_args(actual_args)

    if args.config:
        # load config from file
        config = cmdline.load_config(args.config)
        args = parser.parse_args(config + actual_args)

    # create device
    try:
        device = cmdline.create_device(args)
        print(display_settings(device, args))
        return device

    except error.Error as e:
        parser.error(e)
        return None

EOF

python_file="/usr/local/minitower/sysinfo.py"
cat <<EOF > $python_file
#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import sys
import time
from pathlib import Path
from datetime import datetime
from demo_opts import get_device
from luma.core.render import canvas
from PIL import ImageFont
import psutil
import subprocess as sp


def bytes2human(n):
    symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = int(float(n) / prefix[s])
            return '%s%s' % (value, s)
    return "%sB" % n


def cpu_usage():
    # load average
    av1, av2, av3 = os.getloadavg()
    return "Ld:%.1f %.1f %.1f" % (av1, av2, av3)


def uptime_usage():
    # uptime,
