var shogunApplicationConfig = {
  appPrefix: '/admin',
  defaultPageSize: 20,
  path: {
    modelConfigs: './modelconfigs',
    shogunBase: '/',
    logo: null
  },
  security: {
    keycloak: {
      enabled: true,
      host: 'https://<!--# echo var="keycloakhost" -->/auth',
      realm: 'SHOGun',
      clientId: 'shogun-admin',
      authorizedRoles: [
        'admin'
      ]
    }
  },
  geoserver: {
    base: '/geoserver',
    upload: {
      workspace: 'SHOGUN',
      limit: 200000000 // ~200MB
    }
  },
  models: [
    'Application',
    'Layer',
    'User',
    'Group'
  ],
  dashboard: {
    news: {
      visible: true
    },
    statistics: {
      visible: false
    },
    applications: {
      visible: true
    },
    layers: {
      visible: true
    },
    users: {
      visible: true
    }
  },
  navigation: {
    general: {
      imagefiles: {
        visible: true
      }
    },
    status: {
      metrics: {
        visible: true
      },
      logs: {
        visible: true
      }
    },
    settings: {
      global: {
        visible: true
      },
      logs: {
        visible: true
      }
    }
  }
};
