import requests
import json
import argparse

def manage_prometheus_datasource(
    grafana_url,
    api_key,
    prometheus_url,
    datasource_name="Prometheus",
    default=False
):
    """
    Add or update Prometheus datasource in Grafana.
    """
    base_url = grafana_url.rstrip('/')
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    # First check if datasource exists
    try:
        response = requests.get(
            f"{base_url}/api/datasources",
            headers=headers
        )
        response.raise_for_status()

        # Look for existing prometheus datasource
        existing_ds = None
        for ds in response.json():
            if ds['name'] == datasource_name:
                existing_ds = ds
                break

        # Datasource configuration
        datasource_config = {
            "name": datasource_name,
            "type": "prometheus",
            "url": prometheus_url,
            "access": "proxy",
            "isDefault": default,
            "jsonData": {
                "httpMethod": "POST",
                "timeInterval": "15s"
            }
        }

        if existing_ds:
            print(f"Found existing datasource: {datasource_name}")
            # Update existing datasource
            response = requests.put(
                f"{base_url}/api/datasources/{existing_ds['id']}",
                headers=headers,
                json=datasource_config
            )
            response.raise_for_status()
            print(f"Updated Prometheus datasource: {datasource_name}")
        else:
            # Create new datasource
            response = requests.post(
                f"{base_url}/api/datasources",
                headers=headers,
                json=datasource_config
            )
            response.raise_for_status()
            print(f"Added new Prometheus datasource: {datasource_name}")

        return response.json()

    except requests.exceptions.RequestException as e:
        print(f"Error managing datasource: {str(e)}")
        if hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
        raise

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Add or update Prometheus datasource in Grafana')
    parser.add_argument('api_key', help='Grafana API key')
    parser.add_argument('--grafana-url', default='http://localhost:3000', help='Grafana URL (default: http://localhost:3000)')
    parser.add_argument('--prometheus-url', default='http://prometheus:9090', help='Prometheus URL (default: http://prometheus:9090)')
    parser.add_argument('--name', default='prometheus', help='Datasource name (default: Prometheus)')
    parser.add_argument('--default', action='store_true', help='Set as default datasource')

    args = parser.parse_args()

    try:
        result = manage_prometheus_datasource(
            grafana_url=args.grafana_url,
            api_key=args.api_key,
            prometheus_url=args.prometheus_url,
            datasource_name=args.name,
            default=args.default
        )
        print(json.dumps(result, indent=2))
    except Exception as e:
        print(f"Failed to manage datasource: {str(e)}")
        exit(1)