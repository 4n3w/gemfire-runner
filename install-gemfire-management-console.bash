#!/usr/bin/env bash

source common.bash

# Function to log in to pivnet and download GemFire files
download_gemfire_management_console() {
    pivnet login --api-token="$TANZU_TOKEN"
    pivnet accept-eula -p gemfire-management-console -r 1.3.0
    pivnet download-product-files -p gemfire-management-console -r 1.3.0 -d $GEMFIRE_PATH -i $(pivnet product-files -p gemfire-management-console -r 1.3.0 | awk '/gemfire-management-console-1.3.0.jar/{print $2}')
}


# Function to cleanup on script interruption
cleanup() {
    RC=$?
    if [ -f "$CONSOLE_JAR" ]; then
        echo "Cleaning up potentially partially downloaded jar file..."
        rm -rf "$CONSOLE_JAR"
    fi
    exit $RC
}

# Set trap for cleanup
trap cleanup SIGINT SIGTERM

# Main execution
# Check if the GemFire management console jar exists already
if [ ! -f "$CONSOLE_JAR" ]; then
    check_pivnet_cli
    check_tanzu_token
    create_workspace_directories
    download_gemfire_management_console
fi

echo "GemFire management console is installed at $CONSOLE_JAR"

exit 0
