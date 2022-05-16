var shogunApplicationConfig = {
  appPrefix: '/admin',
  path: {
    base: 'https://localhost',
    swagger: '/v2/api-docs',
    user: '/users',
    layer: '/layers',
    imageFile: '/imagefiles',
    application: '/applications',
    appInfo: '/info/app',
    auth: {
      login: '/auth/login',
      logout: '/auth/logout',
      isSessionValid: '/auth/isSessionValid'
    },
    graphql: '/graphql',
    loggers: '/actuator/loggers',
    logfile: '/actuator/logfile',
    // TODO Fix path
    logo: '/static/img/shogun_logo.ed603078.png',
    evictCache: '/cache/evict',
    metrics: '/actuator/metrics',
    modelConfigs: '/modelconfigs'
  },
  models: [
    'Application',
    'Layer'
  ],
  dashboard: {
    news: {
      visible: false
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
      applications: {
        visible: true,
        schemas: {
          clientConfig: 'DefaultApplicationClientConfig',
          layerTree: 'DefaultLayerTree',
          layerConfig: 'DefaultApplicationLayerConfig'
        }
      },
      layers: {
        visible: true,
        schemas: {
          clientConfig: 'DefaultLayerClientConfig',
          sourceConfig: 'DefaultLayerSourceConfig',
          features: 'GeoJsonObject'
        }
      },
      users: {
        visible: true
      },
      imagefiles: {
        visible: false
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
