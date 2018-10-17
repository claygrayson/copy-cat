var dotenv = require('dotenv').config({path: __dirname + '/.env'});
var express = require('express');
var config = require('./config/config');

var app = express();

var mosca = require('./config/mosca')(app);

require('./config/express')(app, config);

app.listen(process.env['PORT']);
