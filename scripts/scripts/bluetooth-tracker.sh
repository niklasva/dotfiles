#!/bin/bash

DEVICE_NAME="Niklas ADB"  # Replace if the keyboard name changes
LOG_FILE="$HOME/bluetooth_uptime.log"

# Function to check if the device is listed under "Connected:"
is_connected() {
    system_profiler SPBluetoothDataType | awk '/Connected:/,/Not Connected:/' | grep -i "$DEVICE_NAME" > /dev/null
}

# Initialize tracking variables
start_time=""
connected=false

echo "Starting Bluetooth uptime tracker for $DEVICE_NAME..."
echo "Logging to $LOG_FILE"

while true; do
    if is_connected; then
        if [ "$connected" = false ]; then
            start_time=$(date +%s)
            echo "$(date): $DEVICE_NAME connected." | tee -a "$LOG_FILE"
            connected=true
        fi
    else
        if [ "$connected" = true ]; then
            end_time=$(date +%s)
            duration=$(( (end_time - start_time) / 60 ))  # Convert seconds to minutes
            echo "$(date): $DEVICE_NAME disconnected. Uptime: $duration minutes." | tee -a "$LOG_FILE"
            connected=false
            start_time=""
        fi
    fi
    sleep 60  # Check every minute
done

