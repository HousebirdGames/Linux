#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Size of swap file in MB
SWAP_SIZE=1024

# Create swap file
echo "Creating swap file..."
fallocate -l ${SWAP_SIZE}M /swapfile

# Set correct permissions
echo "Setting permissions..."
chmod 600 /swapfile

# Set up the swap space
echo "Setting up swap space..."
mkswap /swapfile

# Enable swap
echo "Enabling swap..."
swapon /swapfile

# Make swap permanent
echo "Making swap permanent..."
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab

# Verify swap is enabled
echo "Verifying swap..."
swapon --show

echo "Swap space increased by ${SWAP_SIZE}M"
