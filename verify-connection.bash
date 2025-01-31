#!/usr/bin/env bash

source common.bash

echo "Connecting to GemFire..."

# Method 1: Direct gfsh connection to locator
gfsh << EOF
connect --locator=localhost[$LOCATOR_PORT]
list members
list regions
EOF

# Method 2: Connect via JMX manager
# gfsh << EOF
# connect --jmx-manager=localhost[$JMX_MANAGER_PORT]
# list members
# list regions
# EOF

# Method 3: Connect via HTTP service (if configured)
# gfsh << EOF
# connect --use-http=true --url="http://localhost:$HTTP_SERVICE_PORT/gemfire/v1"
# list members
# list regions
# EOF
