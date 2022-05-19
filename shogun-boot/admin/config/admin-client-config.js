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
    logo: '/assets/img/shogun_logo.png',
    evictCache: '/cache/evict',
    metrics: '/actuator/metrics',
    modelConfigs: '/modelconfigs'
  },
  models: [
    'Application',
    'Layer',
    'User',
    'Group'
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
