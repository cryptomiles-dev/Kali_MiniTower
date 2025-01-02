#!/bin/bash

# Ensure the script is being run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Enable NTP synchronization
echo "Enabling NTP synchronization..."
sudo timedatectl set-ntp true

# Enable and start the systemd-timesyncd service
echo "Enabling systemd-timesyncd service..."
sudo systemctl enable systemd-timesyncd
sudo systemctl start systemd-timesyncd

# Check if the service started successfully
if systemctl is-active --quiet systemd-timesyncd; then
  echo "systemd-timesyncd service is running."
else
  echo "Failed to start systemd-timesyncd service."
  exit 1
fi

# Display the time synchronization status
echo -e "\nCurrent time synchronization status:"
timedatectl status
