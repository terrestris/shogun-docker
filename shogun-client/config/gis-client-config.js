var clientConfig = {
  shogunBase: '/',
  keycloak: {
    enabled: true,
    host: 'https://<!--# echo var="keycloakhost" -->/auth',
    realm: 'SHOGun',
    clientId: 'shogun-client',
    onLoadAction: 'check-sso'
  }
};
