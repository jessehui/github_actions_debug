#!/bin/bash

# Use `pgrep` with the full pattern to match the exact command
# You may adjust the pattern to make it more specific if needed
PIDS=$(pgrep -f "sudo qemu-system-x86_64.*prebuilt/fs.img")

# Check if any PIDs (Process IDs) are found
if [ -z "$PIDS" ]; then
    echo "No QEMU processes found."
else
    # Kill the processes
    for PID in $PIDS; do
        echo "Killing QEMU process with PID: $PID"
        sudo kill $PID

        # Check if the process was killed; if not, try with `kill -9` (forceful kill)
        if kill -0 $PID > /dev/null 2>&1; then
            echo "Process $PID did not terminate, trying with force kill"
            kill -9 $PID
        fi
    done
fi

PIDS=$(pgrep -f "./*backend-server")
if [ -z "$PIDS" ]; then
    echo "No backend server found."
else
    # Kill the processes
    for PID in $PIDS; do
        echo "Killing backend server process with PID: $PID"
        sudo kill $PID

        # Check if the process was killed; if not, try with `kill -9` (forceful kill)
        if kill -0 $PID > /dev/null 2>&1; then
            echo "Process $PID did not terminate, trying with force kill"
            kill -9 $PID
        fi
    done
fi
