#!/usr/bin/env bash

source common.bash

# Configuration variables
INSTANCE_NAME=${1:-"gemfire1"}
CACHE_SERVER_PORT=${2:-"40404"}

MAX_WAIT_TIME=60  # Maximum time to wait for services in seconds
CHECK_INTERVAL=2  # Time between checks in seconds

# Function to check if Java is installed
check_java() {
    if ! command -v java &> /dev/null; then
        echo "Error: Java is not installed or not in PATH"
        exit 1
    fi
}

# Function to check if GemFire is installed
check_gemfire() {
    if [ ! -d "$GEMFIRE_HOME" ]; then
        echo "Error: GemFire installation not found at $GEMFIRE_HOME"
        echo "Please set GEMFIRE_HOME environment variable"
        exit 1
    fi
}

# Function to create necessary directories
create_directories() {
    mkdir -p "$LOG_DIR"
    mkdir -p "$WORKING_DIR"
}

# Function to check if a port is in use
check_port() {
    local port=$1
    if lsof -i :$port > /dev/null 2>&1; then
        return 0  # Port is in use
    else
        return 1  # Port is not in use
    fi
}

# Function to wait for a service to be ready
wait_for_service() {
    local service_name=$1
    local port=$2
    local waited=0
    
    echo "Waiting for $service_name to start on port $port..."
    
    while [ $waited -lt $MAX_WAIT_TIME ]; do
        if check_port $port; then
            echo "$service_name is now running on port $port"
            return 0
        fi
        
        # Check for specific error conditions in log files
        if [ -f "$WORKING_DIR/$service_name/gemfire-$service_name.log" ]; then
            if grep -q "ERROR" "$WORKING_DIR/$service_name/gemfire-$service_name.log"; then
                echo "Error detected in $service_name startup. Check logs for details."
                return 1
            fi
        fi
        
        sleep $CHECK_INTERVAL
        waited=$((waited + CHECK_INTERVAL))
        echo "Still waiting for $service_name... ($waited seconds)"
    done
    
    echo "Timeout waiting for $service_name to start"
    return 1
}

# Function to verify member is ready
verify_member_ready() {
    local member_name=$1
    local waited=0
    
    echo "Verifying $member_name is ready..."
    
    while [ $waited -lt $MAX_WAIT_TIME ]; do
        # Try to connect and check member status
        if gfsh -e "connect --locator=localhost[$LOCATOR_PORT]" -e "list members" 2>&1 | grep -q "$member_name"; then
            echo "$member_name is ready and registered with the cluster"
            return 0
        fi
        
        sleep $CHECK_INTERVAL
        waited=$((waited + CHECK_INTERVAL))
        echo "Waiting for $member_name to be ready... ($waited seconds)"
    done
    
    echo "Timeout waiting for $member_name to be ready"
    return 1
}

# Function to start GemFire server
start_gemfire() {
    echo "Starting GemFire instance: $INSTANCE_NAME"
    
    # Set GemFire environment
    export PATH=$GEMFIRE_HOME/bin:$PATH
    
    # Check if ports are already in use
    local ports_to_check=($LOCATOR_PORT $CACHE_SERVER_PORT $JMX_MANAGER_PORT $HTTP_SERVICE_PORT)
    for port in "${ports_to_check[@]}"; do
        if check_port $port; then
            echo "Error: Port $port is already in use"
            exit 1
        fi
    done
    
    # Start locator
    gfsh start locator \
        --name="$INSTANCE_NAME-locator" \
        --port=$LOCATOR_PORT \
        --dir="$WORKING_DIR" \
        --J=-Xmx$HEAP_SIZE \
        --J=-Xms$HEAP_SIZE \
        --J=-Dgemfire.distributed-system-id=${CLUSTER_ID} \
        --J=-Dgemfire.enable-metrics=true \
        --J=-Dgemfire.metrics-publication-enabled=true \
        --J=-Dgemfire.http-service-port=7070 \
        --J=-Dgemfire.jmx-manager-port=$JMX_MANAGER_PORT \
        --J=-Dgemfire.http-service-port=$HTTP_SERVICE_PORT \
        --J=-Dgemfire.prometheus.metrics.emission=All \
        --J=-Dgemfire.prometheus.metrics.interval=2m \
        --J=-Dgemfire.prometheus.metrics.host=127.0.0.1 \
        --J=-Dgemfire.prometheus.metrics.port=9050 \
        --J=-Dgemfire.enable-system-statistics=true \
        --J=-Dgemfire.enable-time-statistics=true \
        --J=-Dgemfire.metrics.logback.enabled=true \
        --J=-Dgemfire.metrics.jvm.enabled=true \
        --redirect-output \
        --log-level=config &
    
    # Wait for locator to be ready
    if ! wait_for_service "$INSTANCE_NAME-locator" $LOCATOR_PORT; then
        echo "Failed to start locator"
        exit 1
    fi
    
    # Verify locator is registered
    if ! verify_member_ready "$INSTANCE_NAME-locator"; then
        echo "Failed to verify locator status"
        exit 1
    fi
    
    # Start cache server
    gfsh start server \
        --name="$INSTANCE_NAME-server" \
        --server-port=$CACHE_SERVER_PORT \
        --dir="$WORKING_DIR" \
        --J=-Xmx$HEAP_SIZE \
        --J=-Xms$HEAP_SIZE \
        --J=-Dgemfire.distributed-system-id=${CLUSTER_ID} \
        --J=-Dgemfire.enable-metrics=true \
        --J=-Dgemfire.metrics-publication-enabled=true \
        --J=-Dgemfire.http-service-port=7070 \
        --J=-Dgemfire.jmx-manager-port=$JMX_MANAGER_PORT \
        --J=-Dgemfire.http-service-port=$HTTP_SERVICE_PORT \
        --J=-Dgemfire.prometheus.metrics.emission=All \
        --J=-Dgemfire.prometheus.metrics.interval=2m \
        --J=-Dgemfire.prometheus.metrics.host=127.0.0.1 \
        --J=-Dgemfire.prometheus.metrics.port=9051 \
        --J=-Dgemfire.enable-system-statistics=true \
        --J=-Dgemfire.metrics.logback.enabled=true \
        --J=-Dgemfire.metrics.jvm.enabled=true \
        --J=-Dgemfire.statistic.enable-statistics=true \
        --J=-Dgemfire.statistic.archive-file=stats.gfs \
        --J=-Dgemfire.statistic.sample-rate=1000 \
        --J=-Dgemfire.enable-time-statistics=true \
        --J=-Dgemfire.statistic-sampling-enabled=true \
        --J=-Dmicrometer.metrics.logback.enabled=true \
        --locators="localhost[$LOCATOR_PORT]" \
        --redirect-output \
        --log-level=config &
    
    # Wait for server to be ready
    if ! wait_for_service "$INSTANCE_NAME-server" $CACHE_SERVER_PORT; then
        echo "Failed to start cache server"
        exit 1
    fi
    
    # Verify server is registered
    if ! verify_member_ready "$INSTANCE_NAME-server"; then
        echo "Failed to verify server status"
        exit 1
    fi
    
    echo "GemFire instance started successfully"
    echo "Locator running on port: $LOCATOR_PORT"
    echo "Cache server running on port: $CACHE_SERVER_PORT"
    echo "JMX Manager port: $JMX_MANAGER_PORT"
    echo "HTTP Service port: $HTTP_SERVICE_PORT"
}

# Function to cleanup on script interruption
cleanup() {
    echo "Cleaning up..."
    pkill -f "$INSTANCE_NAME"
    exit 1
}

# Set trap for cleanup
trap cleanup SIGINT SIGTERM

# Main execution
check_java
check_gemfire
create_directories
start_gemfire

exit 0
