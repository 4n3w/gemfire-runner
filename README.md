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

### Load Testing Setup

    cd load-testing
    docker compose up -d

Surf to http://localhost:3001 for grafana. You should see the dashboards in grafana/provisioning/dashboards/json

Run whatever test you want with `docker compose exec`, for example:

    docker compose exec k6 k6 run /scripts/test.js

Just ensure whatever test you've built is in the scripts directory.