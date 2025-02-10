import requests
import json
import argparse

def get_prometheus_datasource_uid(grafana_url, api_key):
    """Get the UID of the Prometheus datasource"""
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    try:
        response = requests.get(
            f"{grafana_url.rstrip('/')}/api/datasources",
            headers=headers
        )
        response.raise_for_status()

        # Find Prometheus datasource
        datasources = response.json()
        for ds in datasources:
            if ds['type'] == 'prometheus':
                print(f"Found Prometheus datasource with UID: {ds['uid']}")
                return ds['uid']

        raise Exception("No Prometheus datasource found")

    except requests.exceptions.RequestException as e:
        print(f"Error getting datasource: {str(e)}")
        raise

def update_datasource_refs(dashboard_json, new_uid):
    """Update all Prometheus datasource references in the dashboard"""
    def update_refs(obj):
        if isinstance(obj, dict):
            # Update datasource reference if this is a datasource object
            if 'datasource' in obj:
                if isinstance(obj['datasource'], dict):
                    if obj['datasource'].get('type') == 'prometheus':
                        old_uid = obj['datasource'].get('uid')
                        if old_uid:
                            print(f"Updating panel datasource reference from {old_uid} to {new_uid}")
                            obj['datasource']['uid'] = new_uid
                elif isinstance(obj['datasource'], str):
                    # Handle legacy string datasource references
                    if obj['type'] in ['prometheus', 'query']:
                        print(f"Updating template variable datasource reference from {obj['datasource']} to {new_uid}")
                        obj['datasource'] = {'type': 'prometheus', 'uid': new_uid}

            # Recursively update all nested objects
            for key, value in obj.items():
                update_refs(value)
        elif isinstance(obj, list):
            for item in obj:
                update_refs(item)

    # Update panel datasources
    update_refs(dashboard_json)

    # Specifically handle template variables
    if 'templating' in dashboard_json and 'list' in dashboard_json['templating']:
        for variable in dashboard_json['templating']['list']:
            if variable.get('type') in ['query', 'datasource']:
                if isinstance(variable.get('datasource'), (str, dict)):
                    update_refs(variable)

    return dashboard_json

def import_dashboard(
    grafana_url,
    api_key,
    dashboard_file,
    folder_id=0,
    overwrite=True
):
    """
    Import a dashboard JSON file into Grafana.
    """
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    try:
        # Read dashboard JSON
        with open(dashboard_file, 'r') as f:
            try:
                dashboard_json = json.load(f)
                print("Successfully loaded JSON file")
            except json.JSONDecodeError as e:
                print(f"Error parsing JSON file: {str(e)}")
                raise

        # Get Prometheus datasource UID
        prometheus_uid = get_prometheus_datasource_uid(grafana_url, api_key)

        # Update datasource references
        dashboard_json = update_datasource_refs(dashboard_json, prometheus_uid)

        # Remove any existing id to avoid conflicts
        if 'id' in dashboard_json:
            del dashboard_json['id']

        # Prepare the import payload
        payload = {
            "dashboard": dashboard_json,
            "folderId": folder_id,
            "overwrite": overwrite,
            "message": "Dashboard imported via API"
        }

        # Make the API request
        endpoint = f"{grafana_url.rstrip('/')}/api/dashboards/db"
        print(f"\nSending request to: {endpoint}")

        response = requests.post(
            endpoint,
            headers=headers,
            json=payload
        )

        response.raise_for_status()
        result = response.json()

        print(f"\nSuccessfully imported dashboard: {result.get('slug', 'unknown')}")
        print(f"Dashboard URL: {grafana_url}/d/{result.get('uid', '')}")
        return result

    except FileNotFoundError:
        print(f"Error: Dashboard file not found: {dashboard_file}")
        raise
    except json.JSONDecodeError:
        print(f"Error: Invalid JSON in dashboard file: {dashboard_file}")
        raise
    except requests.exceptions.RequestException as e:
        print(f"Error importing dashboard: {str(e)}")
        if hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
            try:
                error_json = json.loads(e.response.text)
                print(f"Detailed error message: {json.dumps(error_json, indent=2)}")
            except:
                pass
        raise

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Import dashboard to Grafana')
    parser.add_argument('api_key', help='Grafana API key')
    parser.add_argument('dashboard_file', help='Path to dashboard JSON file')
    parser.add_argument('--grafana-url', default='http://grafana:3000',
                       help='Grafana URL (default: http://grafana:3000)')
    parser.add_argument('--folder-id', type=int, default=0,
                       help='Folder ID to import to (default: 0 for General)')
    parser.add_argument('--no-overwrite', action='store_false', dest='overwrite',
                       help='Do not overwrite existing dashboard')

    args = parser.parse_args()

    try:
        result = import_dashboard(
            grafana_url=args.grafana_url,
            api_key=args.api_key,
            dashboard_file=args.dashboard_file,
            folder_id=args.folder_id,
            overwrite=args.overwrite
        )
    except Exception as e:
        print(f"\nFailed to import dashboard: {str(e)}")
        exit(1)