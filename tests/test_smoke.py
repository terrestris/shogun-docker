import os
import warnings
import psycopg2
import time
import requests
import yaml
from pkg_resources import parse_version
from pathlib import Path
from dotenv import load_dotenv
load_dotenv()

BASE_URL = os.environ.get('BASE_URL', 'https://localhost')
POSTGRES_HOST = os.environ.get('POSTGRES_HOST', 'localhost')
POSTGRES_PORT = os.environ.get('POSTGRES_PORT', '5555')
POSTGRES_USER = os.environ.get('POSTGRES_USER', 'shogun')
POSTGRES_PASSWORD = os.environ.get('POSTGRES_PASSWORD', 'shogun')
KEYCLOAK_USER = os.environ.get('KEYCLOAK_USER', 'admin')
KEYCLOAK_PASSWORD = os.environ.get('KEYCLOAK_PASSWORD', 'shogun')
GEOSERVER_USER = os.environ.get('GEOSERVER_USER', 'admin')
GEOSERVER_PASSWORD = os.environ.get('GEOSERVER_PASSWORD', 'geoserver')
ENDPOINTS = [
    '/',
    '/geoserver/',
    '/admin',
    '/auth/',
    '/admin-docs/',
    '/gis-docs/',
]
CONFIG = yaml.safe_load(Path("config.yaml").read_text())


def wait_for_service(url, timeout=10):
    """Wait until the service at url is available or timeout."""
    start = time.time()
    while time.time() - start < timeout:
        requests.packages.urllib3.disable_warnings()
        try:
            r = requests.get(url, verify=False)
            if r.status_code < 500:
                return True
        except Exception:
            pass
        time.sleep(2)
    return False


def test_services_up():
    """
    Case: All services are up and running
    Expected: All endpoints return 200 OK
    """
    for endpoint in ENDPOINTS:
        url = f"{BASE_URL}{endpoint}"
        assert wait_for_service(url), f"Service not available: {url}"
        requests.packages.urllib3.disable_warnings()
        r = requests.get(url, verify=False)
        assert r.status_code == 200, (
            f"Unexpected status for {url}: "
            f"{r.status_code}"
        )


def wait_for_db(
    host=POSTGRES_HOST,
    port=POSTGRES_PORT,
    user=POSTGRES_USER,
    password=POSTGRES_PASSWORD,
    dbname='postgres',
    timeout=10
):
    start = time.time()
    while time.time() - start < timeout:
        try:
            conn = psycopg2.connect(
                host=host,
                port=port,
                user=user,
                password=password,
                dbname=dbname
            )
            conn.close()
            return True
        except Exception as e:
            print(f"Waiting for DB: {e}")
            time.sleep(2)
    return False


def test_db_up():
    """
    Case: Databse is accessible
    Expected: Database connection is successful
    """
    assert wait_for_db(), 'Database not available'


def keycloak_authentification():
    url = f"{BASE_URL}/auth/realms/master/protocol/openid-connect/token"
    data = {
        'client_id': 'admin-cli',
        'username': KEYCLOAK_USER,
        'password': KEYCLOAK_PASSWORD,
        'grant_type': 'password'
    }
    headers = {'Content-Type': 'application/x-www-form-urlencoded'}

    requests.packages.urllib3.disable_warnings()
    response = requests.post(url, data=data, headers=headers, verify=False)
    response.raise_for_status()
    return response


def test_keycloak_login():
    """
    Case: Keycloak is instantiated
    Expected: Keycloak can be accessed and login is successful
    """
    response = keycloak_authentification()

    assert response.status_code == 200, (
        f"Keycloak login failed: {response.status_code} - {response.text}"
    )


def test_keycloak_realm():
    """
    Case: Realm is instantiated with expected clients
    Expected: Keycloak realm 'SHOGun' is available
              and contains expected clients
    """
    response = keycloak_authentification()
    token = response.json()['access_token']
    assert token, 'Authentication failed, no token received'
    realm = 'SHOGun'
    expected_clients = CONFIG['expected_keycloak_clients']

    url = f"{BASE_URL}/auth/admin/realms/{realm}/clients"
    headers = {
        'Authorization': f"Bearer {token}",
        'Content-Type': 'application/json'
    }

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, headers=headers, verify=False)
    assert response.status_code == 200, (
        f"Failed to fetch clients: {response.status_code} - {response.text}"
    )

    client_ids = [client['clientId'] for client in response.json()]

    for client in expected_clients:
        assert client in client_ids, (
            f"Client '{client}' not found in realm '{realm}'"
        )


def test_users_exist_in_realm():
    """
    Case: Realm has expected user(s)
    Expected: Keycloak realm 'SHOGun' contains expected user(s)
    """
    response = keycloak_authentification()
    token = response.json()['access_token']
    realm = 'SHOGun'
    expected_users = CONFIG['expected_keycloak_users']

    headers = {
        'Authorization': f"Bearer {token}",
        'Content-Type': 'application/json'
    }

    url = f"{BASE_URL}/auth/admin/realms/{realm}/users?max=100"
    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, headers=headers, verify=False)
    assert response.status_code == 200, (
        f"Failed to fetch users: {response.status_code} - {response.text}"
    )

    usernames = [user['username'] for user in response.json()]

    for expected_user in expected_users:
        assert expected_user in usernames, (
            f"User '{expected_user}' not found in realm '{realm}'"
        )


def test_geoserver_default_login():
    """
    Case: Attempt login with default GeoServer credentials
    Expected: If login succeeds, warn user that
              default credentials are still in use
    """
    url = f"{BASE_URL}/geoserver/rest/workspaces.xml"
    auth = ('admin', 'geoserver')

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, auth=auth, verify=False)

    if response.status_code == 200:
        warnings.warn(
            UserWarning(
                "GeoServer default credentials are still active. "
                "It's recommended to change them for security reasons."
                )
            )
    else:
        print(
            "Login with default credentials failed as expected:"
            f"{response.status_code}"
        )


def test_geoserver_workspaces():
    """
    Case: GeoServer has expected workspaces
    Expected: GeoServer contains expected workspaces
    """
    url = f"{BASE_URL}/geoserver/rest/workspaces.json"
    auth = (GEOSERVER_USER, GEOSERVER_PASSWORD)
    expected_workspaces = CONFIG['expected_geoserver_workspaces']

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, auth=auth, verify=False)

    assert response.status_code == 200, (
        "Geoserver connection failed:"
        f"{response.status_code} - {response.text}"
    )

    workspaces = response.json()['workspaces']['workspace']

    workspace_names = [ws['name'] for ws in workspaces]

    for expected_workspace in expected_workspaces:
        assert expected_workspace in workspace_names, (
            f"Workspace '{expected_workspace}' not found in GeoServer"
        )


def test_geoserver_layers():
    """
    Case: GeoServer has expected layers
    Expected: GeoServer contains expected layers
    """
    url = f"{BASE_URL}/geoserver/rest/layers.json"
    auth = (GEOSERVER_USER, GEOSERVER_PASSWORD)
    expected_layers = CONFIG['expected_geoserver_layers']

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, auth=auth, verify=False)

    assert response.status_code == 200, (
        "Geoserver connection failed:"
        f"{response.status_code} - {response.text}"
    )

    layers = response.json()['layers']['layer']

    layer_names = [ws['name'] for ws in layers]

    for expected_layer in expected_layers:
        assert expected_layer in layer_names, (
            f"Layer '{expected_layer}' not found in GeoServer"
        )


def test_geofence_rules():
    """
    Case: GeoServer has expected geofence rules
    Expected: GeoServer has expected geofence rules defined
    """
    url = f"{BASE_URL}/geoserver/rest/geofence/rules.json"
    auth = (GEOSERVER_USER, GEOSERVER_PASSWORD)
    expected_rules = CONFIG['expected_geofence_rules']

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, auth=auth, verify=False)

    assert response.status_code == 200, (
        "Geoserver connection failed:"
        f"{response.status_code} - {response.text}"
    )

    rules = response.json()['rules']

    for expected_rule in expected_rules:
        matched = any(
            all(rule.get(k) == v for k, v in expected_rule.items())
            for rule in rules
        )
        assert matched, (
            f"Expected rule {expected_rule} not found in GeoServer rules"
        )


def test_geoserver_version():
    """
    Case: GeoServer has expected version
    Expected: GeoServer has expected version or higher
    """
    url = f"{BASE_URL}/geoserver/rest/about/version.json"
    auth = (GEOSERVER_USER, GEOSERVER_PASSWORD)
    expected_version = CONFIG['expected_geoserver_version']
    actual_expected_version = parse_version(expected_version)

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, auth=auth, verify=False)

    assert response.status_code == 200, (
        'Geoserver connection failed:'
        f"{response.status_code} - {response.text}"
    )

    version_str = response.json()['about']['resource'][0]['Version']
    actual_version = parse_version(version_str)

    assert actual_version >= actual_expected_version, (
        f"GeoServer version is {version_str}, but should be at least "
        f"{expected_version}"
    )


def test_plugins_loaded():
    """
    Case: Client plugins index.js is accessible and contains expected plugins
    Expected: index.js is served correctly and
              includes known plugin identifiers
    """
    url = f"{BASE_URL}/client-plugins/index.js"
    expected_plugins = CONFIG['expected_plugins']

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, verify=False)

    assert response.status_code == 200, (
        'Could not fetch plugin index.js: '
        f"{response.status_code} - {response.text}"
    )

    assert (
        'webpack' not in response.text.lower()
        or 'error' in response.text.lower()
    ), 'Webpack error possibly detected in index.js'
    assert len(response.text) > 100, (
        "index.js is unexpectedly small — build may have failed"
    )

    content = response.text

    for plugin in expected_plugins:
        assert plugin in content, f"Plugin '{plugin}' not found in index.js"


def test_admin_client_config():
    """
    Case: admin-client-config.js is accessible and contains expected content
    Expected: admin-client-config.js is served correctly and
              includes known config identifiers
    """
    url = f"{BASE_URL}/admin/config/admin-client-config.js"
    expected_admin_configs = CONFIG['expected_admin_configs']

    requests.packages.urllib3.disable_warnings()
    response = requests.get(url, verify=False)

    assert response.status_code == 200, (
        'Could not fetch admin-client-config.js: '
        f"{response.status_code} - {response.text}"
    )

    content = response.text

    for expected_admin_config in expected_admin_configs:
        assert expected_admin_config in content, (
            f"Admin configuration '{expected_admin_config}' "
            "not contained in admin-client-config.js"
        )
