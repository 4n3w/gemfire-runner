# gemfire-runner

## Startup

    docker compose up

To seed the grafana with some dashboards:

    docker compose --profile manual up bootstrap-grafana


### Python Setup (if you're not using docker compose)

    python -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    python ...