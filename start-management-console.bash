#!/usr/bin/env bash

source common.bash

INSTANCE_NAME=${1:-"gemfire1"}
LOCATOR_PORT=${2:-"10334"}
JMX_MANAGER_PORT="1099"
LOG_DIR="./logs"
WORKING_DIR="./data"

# Console specific configuration
CONSOLE_JAR="$GEMFIRE_MANAGEMENT_CONSOLE_PATH/gemfire-management-console-1.3.0.jar"
JAVA_MIN_HEAP="512m"
JAVA_MAX_HEAP="1024m"
JAVA_OPTS=""

# Function to check if Java is installed (shared with other scripts)
check_java() {
    if ! command -v java &> /dev/null; then
        echo "Error: Java is not installed or not in PATH"
        exit 1
    fi
}

# Function to check if GemFire is installed (shared with other scripts)
check_gemfire() {
    if [ ! -d "$GEMFIRE_HOME" ]; then
        echo "Error: GemFire installation not found at $GEMFIRE_HOME"
        echo "Please set GEMFIRE_HOME environment variable"
        exit 1
    fi
}

# Function to create necessary directories (shared with other scripts)
create_directories() {
    mkdir -p "$LOG_DIR"
    mkdir -p "$WORKING_DIR"
}

# Function to check if the locator is running
check_locator() {
    if ! lsof -i :$LOCATOR_PORT > /dev/null 2>&1; then
        echo "Warning: No locator found running on port $LOCATOR_PORT"
        echo "The management console may not be able to connect automatically"
    fi
}

# Function to check console prerequisites
check_console() {
    if [ ! -f "$CONSOLE_JAR" ]; then
        echo "Error: Management Console JAR not found: $CONSOLE_JAR"
        echo "Please ensure the JAR is in the current directory"
        exit 1
    fi
}

# Function to setup Java options
setup_java_opts() {
    # GemFire specific options
    JAVA_OPTS="$JAVA_OPTS \
        -Xms$JAVA_MIN_HEAP \
        -Xmx$JAVA_MAX_HEAP \
        -XX:+UseG1GC \
        -Djava.awt.headless=false \
        -Dgemfire.jmx-manager-port=$JMX_MANAGER_PORT \
        -Dgemfire.DEFAULT_STARTUP_CONNECT_RETRY_ATTEMPTS=5 \
        -Dgemfire.log-dir=$LOG_DIR"

    # Add default connection information
    JAVA_OPTS="$JAVA_OPTS \
        -Dgemfire.default-locator=localhost[$LOCATOR_PORT]"

    JAVA_OPTS="$JAVA_OPTS \
        --add-opens=java.base/java.util=ALL-UNNAMED \
        --add-opens=java.base/java.lang=ALL-UNNAMED \
        --add-opens=java.base/java.nio=ALL-UNNAMED \
        --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
        --add-opens=java.management/sun.management=ALL-UNNAMED \
        --add-opens=java.management/com.sun.jmx.remote.security=ALL-UNNAMED"
}

# Function to start the console
start_console() {
    echo "Starting GemFire Management Console..."
    echo "Java options: $JAVA_OPTS"
    echo "Log directory: $LOG_DIR"
    echo "Default locator: localhost:$LOCATOR_PORT"

    # Launch the management console
    java $JAVA_OPTS -jar "$CONSOLE_JAR" > "$LOG_DIR/console.log" 2>&1 &

    # Save PID for potential cleanup
    echo $! > "$LOG_DIR/console.pid"
    echo "Management Console started with PID: $!"
}

# Function to cleanup on script interruption
cleanup() {
    echo "Cleaning up..."
    if [ -f "$LOG_DIR/console.pid" ]; then
        kill $(cat "$LOG_DIR/console.pid")
        rm "$LOG_DIR/console.pid"
    fi
    exit 1
}

# Set trap for cleanup
trap cleanup SIGINT SIGTERM

# Main execution
check_java
check_gemfire
check_console
create_directories
check_locator
setup_java_opts
start_console

echo "Management Console is starting..."
echo "Logs are available at: $LOG_DIR/console.log"