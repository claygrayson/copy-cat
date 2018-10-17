var express = require('express');
var config = require('../config/config');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session     = require('express-session');
var flash     = require('connect-flash');
var passport    = require('passport');
var compress = require('compression');
var MongoStore    = require('connect-mongo')(session);
var mongoose    = require('mongoose');
var methodOverride = require('method-override');

var Grid = require('gridfs-stream');
Grid.mongo = mongoose.mongo;

require('../app/models/db/Mongodb3')(config);

module.exports = function(app, config) {
  app.set('views', config.root + '/app/views');
  app.set('view engine', 'jade');

  mongoose.set('debug', true);

  // app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use(logger('dev'));
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use(cookieParser());
  app.use(compress());
  app.use(express.static(config.root + '/public'));
  app.use(methodOverride());

  // https://codeforgeek.com/2014/09/manage-session-using-node-js-express-4/
  app.use(session({
    cookie: { maxAge: 3600000 },
    store: new MongoStore({
      mongooseConnection : mongoose.connection
    }),
    saveUninitialized: true,
    resave: 'true',
    secret: process.env.SESSION_SECRET
  }));
  
  // https://gist.github.com/brianmacarthur/a4e3e0093d368aa8e423
  app.use(flash());
  
  // http://code.tutsplus.com/tutorials/authenticating-nodejs-applications-with-passport--cms-21619
  // https://scotch.io/tutorials/easy-node-authentication-setup-and-local
  require('./passport')(passport);
  app.use(passport.initialize());
  app.use(passport.session());

  // MongoDB GridFS Connection
  var gfs = Grid(mongoose.connection.db);

  // Main router
  require(config.root + '/app/routes')(app, passport, gfs);
  
  if(process.env.ENV === 'dev'){
    app.use(function (err, req, res, next) {
      res.status(err.status || 500);
      res.render('error', {
        message: err.message,
        error: err,
        title: 'error'
      });
      next(err);
    });
  }

};
