import os
import psycopg2
import time
import requests

BASE_URL = os.environ.get('BASE_URL', 'https://localhost')
POSTGRES_HOST = os.environ.get('POSTGRES_HOST', 'localhost')
POSTGRES_PORT = os.environ.get('POSTGRES_PORT', '5555')
POSTGRES_USER = os.environ.get('POSTGRES_USER', 'shogun')
POSTGRES_PASSWORD = os.environ.get('POSTGRES_PASSWORD', 'shogun')
KEYCLOAK_USER = os.environ.get('KEYCLOAK_USER', 'admin')
KEYCLOAK_PASSWORD = os.environ.get('KEYCLOAK_PASSWORD', 'shogun')
ENDPOINTS = [
    "/",
    '/geoserver/',
    '/admin',
    '/auth/',
    '/admin-docs/',
    '/gis-docs/',
]


def wait_for_service(url, timeout=10):
    """Wait until the service at url is available or timeout."""
    start = time.time()
    while time.time() - start < timeout:
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
    dbname="postgres",
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
    assert wait_for_db(), "Database not available"


def keycloak_authentification():
    url = f"{BASE_URL}/auth/realms/master/protocol/openid-connect/token"
    data = {
        'client_id': 'admin-cli',
        'username': KEYCLOAK_USER,
        'password': KEYCLOAK_PASSWORD,
        'grant_type': 'password'
    }
    headers = {'Content-Type': 'application/x-www-form-urlencoded'}

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
    assert token, "Authentication failed, no token received"
    realm = "SHOGun"
    expected_clients = [
        "shogun-admin",
        "shogun-boot",
        "shogun-client",
        "shogun-geoserver"
    ]

    url = f"{BASE_URL}/auth/admin/realms/{realm}/clients"
    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }

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
    realm = "SHOGun"
    expected_users = ["shogun"]

    headers = {
        'Authorization': f'Bearer {token}',
        'Content-Type': 'application/json'
    }

    url = f"{BASE_URL}/auth/admin/realms/{realm}/users?max=100"
    response = requests.get(url, headers=headers, verify=False)
    assert response.status_code == 200, (
        f"Failed to fetch users: {response.status_code} - {response.text}"
    )

    usernames = [user['username'] for user in response.json()]

    for expected_user in expected_users:
        assert expected_user in usernames, (
            f"User '{expected_user}' not found in realm '{realm}'"
        )
