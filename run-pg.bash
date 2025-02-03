#!/usr/bin/env bash
# Script to run prometheus and grafana locally and connect to local gemfire installation

source common.bash

# Function to stop any earlier running instances of prometheus and grafana
stop_existing_prom_graf() {
    # Check if Prometheus is running
    if [ -n "$(docker-compose ps -q prometheus)" ]; then
        echo "Stopping Prometheus..."
        docker-compose stop prometheus
    fi

    # Check if Grafana is running
    if [ -n "$(docker-compose ps -q grafana)" ]; then
        echo "Stopping Grafana..."
        docker-compose stop grafana
    fi
}

# Function to create prometheus and grafana working dir
create_pg_working_dir() {
    if [ ! -d "$PG_WORKING_DIR" ]; then
        mkdir -p "$PG_WORKING_DIR"
    fi
}

# Function to create docker compose file
create_docker_compose_file() {
	cat <<-EOF > docker-compose.yml
	version: "3.9"
	services:
	  prometheus:
	    image: prom/prometheus:latest
	    container_name: prometheus
	    volumes:
	      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
	    ports:
	      - "9090:9090"
	  grafana:
	    image: grafana/grafana:latest
	    container_name: grafana
	    ports:
	      - "3000:3000"
	    environment:
	      - GF_SECURITY_ADMIN_PASSWORD=secret
	EOF
}

# Function to create prometheus.yml file
create_prom_config_file() {
	cat <<-EOF > prometheus.yml
	global:
	  scrape_interval: 15s

	scrape_configs:
	  - job_name: 'prometheus'
	    static_configs:
	      - targets: ['localhost:9090']
	EOF
}

# Function to run docker compose
run_docker_compose() {
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed. Please install Docker and try again."
        exit 1
    fi

    # Check if Docker daemon is running
    if ! docker info > /dev/null 2>&1; then
        echo "Error: Docker is not running. Please start Docker and try again."
        exit 1
    fi

    # Check if docker-compose is installed
    if ! command -v docker-compose &> /dev/null; then
        echo "docker-compose is not installed, install and try again"
        exit 1
    fi
    docker-compose up -d
}



## Function to cleanup on script interruption
#cleanup() {
#    RC=$?
#    if [ -f "$GEMFIRE_TAR" ]; then
#        echo "Cleaning up downloaded tar file..."
#        rm -rf "$GEMFIRE_TAR"
#    fi
#    exit $RC
#}

## Set trap for cleanup
#trap cleanup SIGINT SIGTERM EXIT

# Main execution
create_pg_working_dir
pushd "$PG_WORKING_DIR" > /dev/null
stop_existing_prom_graf
create_docker_compose_file
create_prom_config_file
run_docker_compose
popd > /dev/null

exit 0
