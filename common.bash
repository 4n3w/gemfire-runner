#!/usr/bin/env bash

GEMFIRE_HOME=$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2
GEMFIRE_MANAGEMENT_CONSOLE_PATH=$HOME/workspace/gemfire-artifacts
export PATH=$GEMFIRE_HOME/bin:$PATH

LOCATOR_PORT="10334"
JMX_MANAGER_PORT="1099"
HTTP_SERVICE_PORT="7070"
INSTANCE_NAME="gemfire1"

HEAP_SIZE="1G"