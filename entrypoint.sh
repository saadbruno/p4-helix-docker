#!/bin/bash

# ensures cert directory permissions
chown root:root /perforce/ssl
chmod 700 /perforce/ssl

# if /perforce/ssl/certificate.txt does NOT exist, then let's create it
if [ -f "/perforce/ssl/certificate.txt" ]; then
    echo "Certificate already exists. Skipping generation..."
else 
    echo "Certificate DOES NOT exist. Generating..."
    /perforce/bin/p4d -Gc
fi

# ensures server is in unicode mode
/perforce/bin/p4d -r /perforce/server -C1 -xi

# runs the server
/perforce/bin/p4d -r /perforce/server -p ssl:1666 -J journal -C1