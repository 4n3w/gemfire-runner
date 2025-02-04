#!/usr/bin/env bash

source common.bash

# Function to log in to pivnet and download GemFire files
download_gemfire() {
    cd $GEMFIRE_PATH
    pivnet login --api-token="$TANZU_TOKEN"
    pivnet accept-eula -p pivotal-gemfire -r 10.1.2
    pivnet download-product-files -p pivotal-gemfire -r 10.1.2 -d $GEMFIRE_PATH -i $(pivnet product-files -p pivotal-gemfire -r 10.1.2 | awk '/vmware-gemfire-10.1.2.tgz/{print $2}') 
}

# Function to unpack GemFire tarball
unpack_gemfire() {
    tar -xzf "$GEMFIRE_TAR" -C "$GEMFIRE_PATH"
    if [ $? -ne 0 ]; then
        echo "Problem unpacking gemfire .tgz file"
        exit 1
    fi
}

# Function to cleanup on script interruption
cleanup() {
    RC=$?
    if [ -f "$GEMFIRE_TAR" ]; then
        echo "Cleaning up downloaded tar file..."
        rm -rf "$GEMFIRE_TAR"
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
    create_directories
    download_gemfire
    unpack_gemfire
fi

echo "GemFire is installed at $GEMFIRE_HOME"

exit 0
