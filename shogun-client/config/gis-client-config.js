var clientConfig = {
  shogunBase: '/',
  keycloak: {
    enabled: true,
    host: 'https://<!--# echo var="keycloakhost" -->/auth',
    realm: 'SHOGun',
    clientId: 'shogun-client',
    onLoadAction: 'login-required'
  },
  featureEditRoles: {
    authorizedRolesForCreate: [
      'admin'
    ],
    authorizedRolesForUpdate: [
      'admin'
    ],
    authorizedRolesForDelete: [
      'admin'
    ],
    authorizedRolesForEditingGeometries: [
      'admin'
    ]
  },
  enableFallbackConfig: false,
  plugins: []
};
