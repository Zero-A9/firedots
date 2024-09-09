#!/bin/bash

# Network interface
INTERFACE="wlp0s20f3"

# Bring the network interface down
sudo ip link set $INTERFACE down

# Change the MAC address randomly
sudo macchanger -r $INTERFACE

# Bring the network interface up
sudo ip link set $INTERFACE up

# Restart Tor Network
sudo systemctl restart tor

