#!/usr/bin/env bash

GEMFIRE_PATH=$HOME/workspace/gemfire-artifacts
GEMFIRE_HOME=$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2
GEMFIRE_TAR="$GEMFIRE_PATH/vmware-gemfire-10.1.2.tgz"
CONSOLE_JAR="$GEMFIRE_PATH/gemfire-management-console-1.3.0.jar"
export PATH=$GEMFIRE_HOME/bin:$PATH

CLUSTER_ID="42"

LOCATOR_PORT="10334"
JMX_MANAGER_PORT="1099"
HTTP_SERVICE_PORT="7070"
CACHE_SERVER_PORT="40404"

INSTANCE_NAME="gemfire1"
HEAP_SIZE="1G"

LOG_DIR="./logs"
WORKING_DIR="./data"
PG_WORKING_DIR="./data/pg"

MAX_WAIT=10

# Function to check if pivnet CLI is installed
check_pivnet_cli() {
    if ! command -v pivnet &> /dev/null; then
        echo "pivnet cli not found, install via instructions here and try again: https://github.com/pivotal-cf/pivnet-cli"
        exit 1
    fi
}

# Function to check if TANZU_TOKEN is set
check_tanzu_token() {
    if [ -z "$TANZU_TOKEN" ]; then
        echo "TANZU_TOKEN is unset, access Tanzu token from here, export it as a variable and try again: https://support.broadcom.com/group/ecx/tanzu-token"
        exit 1
    fi
}

# Function to create workspace directories
create_directories() {
    if [ ! -d "$GEMFIRE_PATH" ]; then
        mkdir -p $GEMFIRE_PATH
    fi

    if [ ! -d "$LOG_DIR" ]; then
        mkdir -p $LOG_DIR
    fi

    if [ ! -d "$WORKING_DIR" ]; then
        mkdir -p $WORKING_DIR
    fi
}
