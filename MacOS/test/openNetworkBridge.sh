#!/bin/bash
#TEST UTILITY
# This script uses `socat` to open a TCP listener on the default X window port (6000).
# This bridges the network socket with the X server on the running OSX host, so that the
# container can send displays to OSX from applications running within it.
# Usage:
# This script should be run inside its own terminal, and left running as long as X forwarding is desired.

echo -e "\nUSAGE: This script should be run in its own shell, and must be left running as long as X forwarding of displays is required.\n"

echo -e "\nCtrl-C to stop when no longer needed.\n"

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\” & SOCAT_PID=$!

echo $SOCAT_PID
