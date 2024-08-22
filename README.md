# Linux Server Management Scripts

A collection of scripts for efficiently managing, updating, and maintaining Linux servers and Raspberry Pi systems remotely.

## Contents

1. `connect_to_server_ssh.bat`: Windows batch script for remote setup and connection
2. `setup_update_script.bat`: Setup script for copying and configuring the update script on the Linux server
3. `update_script.sh`: Bash script for automated system updates on the Linux server
4. `config.example.ini`: Example configuration file for storing connection details securely - rename to `config.ini`

## Setup

1. Ensure you have SSH access to your Linux server or Raspberry Pi.
2. Clone this repository or download the scripts to your local machine.
3. Update the `config.ini` file with your server's IP address, username, and the path to the update script.

## Usage

### connect_to_server_ssh.bat

1. Open a command prompt in the script's directory.
2. Run `connect_to_server_ssh.bat`.
3. Follow the prompts to copy the update script, make it executable, add it to .bash_profile, and connect to your server.

### update_script.sh

This script runs automatically upon login to your Linux server or Raspberry Pi. It will:
- Update package lists
- Show upgradeable packages
- Perform system upgrades

You can set the script up by running the `setup_update_script.bat` script on your Windows machine.

## Requirements

- Windows system for running the batch script
- SSH client installed on the Windows system
- Linux server or Raspberry Pi with SSH access

## Contributing

Feel free to fork this repository and submit pull requests with improvements or additional scripts that could be useful for Linux server management. Keep it simple and short.