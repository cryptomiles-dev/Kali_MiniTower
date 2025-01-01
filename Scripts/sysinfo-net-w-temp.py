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
    # Get CPU temperature using vcgencmd
    temp_output = sp.check_output(["vcgencmd", "measure_temp"]).decode("UTF-8")
    return "CPU %s" % temp_output.strip()  # Display "CPU temp=XX.X'C"

def uptime_usage():
    # Get the IP address of wlan0
    wlan0_ip = sp.getoutput("ip -4 addr show wlan0 | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}'").strip()
    # Get the IP address of eth0
    eth0_ip = sp.getoutput("ip -4 addr show eth0 | grep -oP '(?<=inet\\s)\\d+(\\.\\d+){3}'").strip()

    wlan0_display = "wlan0: %s" % (wlan0_ip if wlan0_ip else "No IP")
    eth0_display = "eth0: %s" % (eth0_ip if eth0_ip else "No IP")

    return wlan0_display, eth0_display



def mem_usage():
    usage = psutil.virtual_memory()
    return "Mem:%s %.0f%%" % (bytes2human(usage.used), 100 - usage.percent)


def disk_usage(dir):
    usage = psutil.disk_usage(dir)
    return "SD:%s %.0f%%" % (bytes2human(usage.used), usage.percent)


# def network(iface):
#    stat = psutil.net_io_counters(pernic=True)[iface]
#    return "%s: Tx: %s,Rx: %s" % (iface, bytes2human(stat.bytes_sent), bytes2human(stat.bytes_recv))


def stats(device):
    # use custom font
    font_path = '/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf'
    font2 = ImageFont.truetype(font_path, 11)
    # New smaller font definition for wlan0
    small_font = ImageFont.truetype(font_path, 10)  # Adjust this value as necessary
    with canvas(device) as draw:
        draw.text((0, 1), cpu_usage(), font=font2, fill="white")
        if device.height >= 32:
            draw.text((0, 12), mem_usage(), font=font2, fill="white")

        if device.height >= 64:
            draw.text((0, 24), disk_usage('/'), font=font2, fill="white")
            try:
                # Display both wlan0 and eth0 IP addresses
                wlan0_ip, eth0_ip = uptime_usage()
                draw.text((0, 36), wlan0_ip, font=small_font, fill="white")
                draw.text((0, 48), eth0_ip, font=font2, fill="white")
            except KeyError:
                # no network interface available
                pass


device = get_device()

while True:
    stats(device)
    time.sleep(5)
