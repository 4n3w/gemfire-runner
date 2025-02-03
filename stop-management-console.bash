#!/usr/bin/env bash

source common.bash

# Try to stop using stored PID first
if [ -f "$LOG_DIR/console.pid" ]; then
    PID=$(cat "$LOG_DIR/console.pid")
    if ps -p $PID > /dev/null; then
        echo "Stopping Management Console (PID: $PID)..."
        kill $PID

        # Wait for process to stop
        for i in $(seq 1 $MAX_WAIT); do
            if ! ps -p $PID > /dev/null; then
                echo "Management Console stopped successfully"
                rm "$LOG_DIR/console.pid"
                exit 0
            fi
            sleep 1
        done

        # Force kill if still running
        echo "Process didn't stop gracefully, forcing termination..."
        kill -9 $PID
        rm "$LOG_DIR/console.pid"
        exit 0
    fi
    rm "$LOG_DIR/console.pid"
fi

# Fallback: find by process name
PID=$(pgrep -f "$CONSOLE_JAR")
if [ ! -z "$PID" ]; then
    echo "Found Management Console process (PID: $PID)"
    kill $PID

    # Wait for process to stop
    for i in $(seq 1 $MAX_WAIT); do
        if ! ps -p $PID > /dev/null; then
            echo "Management Console stopped successfully"
            exit 0
        fi
        sleep 1
    done

    # Force kill if still running
    echo "Process didn't stop gracefully, forcing termination..."
    kill -9 $PID
    exit 0
fi

echo "No running Management Console found"
exit 0
