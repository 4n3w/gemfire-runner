#!/usr/bin/env bash

source common.bash

if ! lsof -i :$LOCATOR_PORT > /dev/null 2>&1; then
    echo "Warning: No locator found running on port $LOCATOR_PORT"
fi

echo "Launching gfsh console..."
echo "To connect, use: connect --locator=localhost[$LOCATOR_PORT]"
echo ""

gfsh
