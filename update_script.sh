#!/bin/bash

echo "Welcome! Would you like to update and upgrade your system? (Y/n)"
read -r response

if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]; then
    echo "Update canceled. Have a great day!"
    exit 0
fi

echo "Updating package lists..."
sudo apt update

echo "Would you like to see the list of upgradeable packages? (Y/n)"
read -r response

if [[ ! "$response" =~ ^([nN][oO]|[nN])$ ]]; then
    apt list --upgradeable
fi

echo "Do you want to proceed with the upgrade? (Y/n)"
read -r response

if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]; then
    echo "Upgrade canceled. Have a great day!"
    exit 0
fi

echo "Performing upgrade..."
sudo apt upgrade -y

echo "Update and upgrade completed successfully!"