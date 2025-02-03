#!/usr/bin/env bash

GEMFIRE_HOME=$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2
GEMFIRE_MANAGEMENT_CONSOLE_PATH=$HOME/workspace/gemfire-artifacts
CONSOLE_JAR="$GEMFIRE_MANAGEMENT_CONSOLE_PATH/gemfire-management-console-1.3.0.jar"
export PATH=$GEMFIRE_HOME/bin:$PATH

LOCATOR_PORT="10334"
JMX_MANAGER_PORT="1099"
HTTP_SERVICE_PORT="7070"
INSTANCE_NAME="gemfire1"

HEAP_SIZE="1G"

LOG_DIR="./logs"
WORKING_DIR="./data"

MAX_WAIT=10  # Maximum seconds to wait for graceful shutdown


