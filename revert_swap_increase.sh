#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Reverting swap space changes..."

# Disable swap
echo "Disabling swap..."
swapoff /swapfile

# Remove swap entry from /etc/fstab
echo "Removing swap entry from /etc/fstab..."
sed -i '/\/swapfile none swap sw 0 0/d' /etc/fstab

# Delete swap file
echo "Deleting swap file..."
rm -f /swapfile

# Verify swap is disabled
echo "Verifying swap is disabled..."
swapon --show

echo "Swap space changes have been reverted."
