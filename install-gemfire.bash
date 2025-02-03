#!/usr/bin/env bash

source common.bash

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

# Function to log in to pivnet and download GemFire files
download_gemfire() {
    pivnet login --api-token="$TANZU_TOKEN"
    pivnet accept-eula -p pivotal-gemfire -r 10.1.2
    pivnet download-product-files -p pivotal-gemfire -r 10.1.2 -i $(pivnet product-files -p pivotal-gemfire -r 10.1.2 | awk '/vmware-gemfire-10.1.2.tgz/{print $2}')
}

# Function to create workspace directories
create_workspace_directories() {
    mkdir -p $HOME/workspace/gemfire-artifacts
    cd $HOME/workspace/gemfire-artifacts
}

# Function to unpack GemFire tarball
unpack_gemfire() {
    tar -xzvf "$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2.tgz" -C "$HOME/workspace/gemfire-artifacts/"
    if [ $? -ne 0 ]; then
        echo "Problem unpacking gemfire .tgz file"
        exit 1
    fi
}

# Function to cleanup on script interruption
cleanup() {
    RC=$?
    if [ -f "$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2.tgz" ]; then
        echo "Cleaning up downloaded tar file..."
        rm -rf "$HOME/workspace/gemfire-artifacts/vmware-gemfire-10.1.2.tgz"
    fi
    exit $RC
}

# Set trap for cleanup
trap cleanup SIGINT SIGTERM EXIT

# Main execution
# Check if the GemFire gfsh binary exists already
if [ ! -f "$GEMFIRE_HOME/bin/gfsh" ]; then
    check_pivnet_cli
    check_tanzu_token
    create_workspace_directories
    download_gemfire
    unpack_gemfire
fi

echo "GemFire is installed at $GEMFIRE_HOME"

exit 0

