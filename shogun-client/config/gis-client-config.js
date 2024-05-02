var clientConfig = {
  appLogo: '',
  shogunBase: '/',
  keycloak: {
    enabled: true,
    host: 'https://<!--# echo var="keycloakhost" -->/auth',
    realm: 'SHOGun',
    clientId: 'shogun-client',
    onLoadAction: 'login-required'
  },
  print: {
    url: '/print'
  },
  geoserver: {
    base: '/geoserver',
    upload: {
      workspace: 'SHOGUN-UPLOADS',
      limit: 209715200, // 200MB
      authorizedRoles: [
        'admin'
      ]
    }
  },
  search: {
    solrBasePath: '/search/query',
    coreName: 'search',
    defaultUseViewBox: true,
    useNominatim: true,
    useSolrHighlighting: true,
    delay: 1000,
    minChars: 3,
    solrQueryConfig: {
      queryParser: 'edismax',
      rowsPerQuery: 100,
      tagPre: '<b>',
      tagPost: '</b>',
      requireFieldMatch: true
    }
  },
  wfsLockFeatureEnabled: false,
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
