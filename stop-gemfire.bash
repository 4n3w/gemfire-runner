#!/usr/bin/env bash

source common.bash

INSTANCE_NAME=${1:-"gemfire1"}
LOCATOR_PORT=${2:-"10334"}
MAX_ATTEMPTS=3

echo "Stopping GemFire instance: $INSTANCE_NAME"

# Try graceful shutdown first
for (( i=1; i<=$MAX_ATTEMPTS; i++ )); do
    echo "Attempting graceful shutdown (attempt $i/$MAX_ATTEMPTS)..."
    
    if gfsh -e "connect --locator=localhost[$LOCATOR_PORT]" -e "shutdown --include-locators=true" &>/dev/null; then
        echo "GemFire shutdown successfully"
        exit 0
    fi
    
    sleep 2
done

# If graceful shutdown fails, force kill the processes
echo "Graceful shutdown failed, forcing shutdown..."
if pgrep -f "$INSTANCE_NAME" > /dev/null; then
    pkill -f "$INSTANCE_NAME"
    echo "Forced shutdown completed"
else
    echo "No running GemFire processes found"
fi

# Verify all processes are stopped
if pgrep -f "$INSTANCE_NAME" > /dev/null; then
    echo "Warning: Some GemFire processes may still be running"
    ps aux | grep "$INSTANCE_NAME" | grep -v grep
    exit 1
else
    echo "All GemFire processes stopped"
fi

exit 0
