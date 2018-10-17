var path = require('path'),
    rootPath = path.normalize(__dirname + '/..'),
    env = process.env.NODE_ENV || 'development';

var config = {
  development: {
    root: rootPath,
    app: {
      name: 'copycat'
    },
    port: process.env.PORT || 3000,
    mongodb3: process.env.MONGOLAB_URI || 'mongodb://localhost/copycat'
  },

  test: {
    root: rootPath,
    app: {
      name: 'copycat'
    },
    port: process.env.PORT || 3000,
    mongodb3: process.env.MONGOLAB_URI || 'mongodb://localhost/copycat'
  },

  production: {
    root: rootPath,
    app: {
      name: 'copycat'
    },
    port: process.env.PORT || 3000,
    mongodb3: process.env.MONGOLAB_URI || 'mongodb://localhost/copycat'
  }
};

module.exports = config[env];
