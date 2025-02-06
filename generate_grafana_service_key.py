import requests
import json

def get_or_create_service_account(
    grafana_url,
    admin_username="admin",
    admin_password="admin",
    account_name="prometheus-automation",
    role="Admin"
):
    """
    Get existing service account or create a new one if it doesn't exist.

    Returns:
        int: service_account_id
    """
    base_url = grafana_url.rstrip('/')
    basic_auth = requests.auth.HTTPBasicAuth(admin_username, admin_password)

    # First, try to find existing service account
    search_endpoint = f"{base_url}/api/serviceaccounts/search"
    try:
        search_response = requests.get(
            search_endpoint,
            auth=basic_auth,
            params={"query": account_name}
        )
        search_response.raise_for_status()
        accounts = search_response.json()

        # Check if account already exists
        for account in accounts.get('serviceAccounts', []):
            if account['name'] == account_name:
                print(f"Found existing service account: {account_name} (ID: {account['id']})")
                return account['id']

        # If not found, create new account
        sa_endpoint = f"{base_url}/api/serviceaccounts"
        sa_payload = {
            "name": account_name,
            "role": role
        }

        sa_response = requests.post(
            sa_endpoint,
            auth=basic_auth,
            json=sa_payload
        )
        sa_response.raise_for_status()
        sa_data = sa_response.json()
        print(f"Created new service account: {account_name} (ID: {sa_data['id']})")
        return sa_data['id']

    except requests.exceptions.RequestException as e:
        print(f"Error managing service account: {str(e)}")
        if hasattr(e, 'response') and hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
        raise

def get_or_create_api_token(
    grafana_url,
    service_account_id,
    admin_username,
    admin_password,
    account_name="prometheus-automation",
    role="Admin"
):
    """
    Get existing API token or create a new one if none exists.
    """
    base_url = grafana_url.rstrip('/')
    basic_auth = requests.auth.HTTPBasicAuth(admin_username, admin_password)
    token_endpoint = f"{base_url}/api/serviceaccounts/{service_account_id}/tokens"

    try:
        # List existing tokens
        tokens_response = requests.get(
            token_endpoint,
            auth=basic_auth
        )
        tokens_response.raise_for_status()
        existing_tokens = tokens_response.json()

        # If tokens exist, return None to indicate we can't retrieve the actual token value
        if existing_tokens:
            print("API token already exists. Using existing token.")
            return None

        # If no tokens exist, create new one
        token_payload = {
            "name": f"{account_name}-token",
            "role": role
        }

        token_response = requests.post(
            token_endpoint,
            auth=basic_auth,
            json=token_payload
        )
        token_response.raise_for_status()
        token_data = token_response.json()
        print(f"Generated new API token for service account: {account_name}")
        return token_data['key']

    except requests.exceptions.RequestException as e:
        print(f"Error managing API token: {str(e)}")
        if hasattr(e, 'response') and hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
        raise

def get_or_create_datasource(
    grafana_url,
    api_key,
    prometheus_url,
    datasource_name="Prometheus"
):
    """
    Get existing datasource or create if it doesn't exist.
    """
    base_url = grafana_url.rstrip('/')
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    try:
        # Check if datasource exists
        datasources_response = requests.get(
            f"{base_url}/api/datasources",
            headers=headers
        )
        datasources_response.raise_for_status()
        datasources = datasources_response.json()

        # Look for existing Prometheus datasource
        for ds in datasources:
            if ds['name'] == datasource_name:
                print(f"Found existing datasource: {datasource_name}")
                return

        # If not found, create new datasource
        datasource_config = {
            "name": datasource_name,
            "type": "prometheus",
            "url": prometheus_url,
            "access": "proxy",
            "isDefault": True,
            "jsonData": {
                "httpMethod": "POST",
                "timeInterval": "15s"
            }
        }

        create_response = requests.post(
            f"{base_url}/api/datasources",
            headers=headers,
            json=datasource_config
        )
        create_response.raise_for_status()
        print(f"Created new datasource: {datasource_name}")

    except requests.exceptions.RequestException as e:
        print(f"Error managing datasource: {str(e)}")
        if hasattr(e, 'response') and hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
        raise

def setup_grafana_prometheus(
    grafana_url,
    prometheus_url,
    admin_username="admin",
    admin_password="admin"
):
    """
    Idempotent setup function that:
    1. Gets or creates a service account
    2. Gets or creates an API token
    3. Gets or creates the Prometheus datasource
    """
    try:
        # Get or create service account
        service_account_id = get_or_create_service_account(
            grafana_url,
            admin_username,
            admin_password
        )

        # Get or create API token
        api_key = get_or_create_api_token(
            grafana_url,
            service_account_id,
            admin_username,
            admin_password
        )

        # If no new API key was generated, we need to provide one
        if api_key is None:
            print("Please provide an existing API key for the service account:")
            api_key = input().strip()

        # Get or create Prometheus datasource
        get_or_create_datasource(
            grafana_url,
            api_key,
            prometheus_url
        )

        print("Setup complete!")
        if api_key:
            print(f"API key: {api_key}")
        return api_key

    except Exception as e:
        print(f"Setup failed: {str(e)}")
        raise

if __name__ == "__main__":
    # Configuration
    GRAFANA_URL = "http://localhost:3000"
    PROMETHEUS_URL = "http://prometheus:9090"
    ADMIN_USER = "admin"
    ADMIN_PASSWORD = "secret123"  # Change this to your admin password

    try:
        api_key = setup_grafana_prometheus(
            grafana_url=GRAFANA_URL,
            prometheus_url=PROMETHEUS_URL,
            admin_username=ADMIN_USER,
            admin_password=ADMIN_PASSWORD
        )
    except Exception as e:
        print(f"Setup failed: {str(e)}")