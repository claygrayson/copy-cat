var mongoose = require('mongoose');

module.exports = function(config) {
	mongoose.connect(config.mongodb3);

	mongoose.connection.on('connected', function() {
		console.log('Mongoose connected');
	});

	mongoose.connection.on('error', function(e) {
		console.log('Mongoose connection error: ' + e);
	});

	mongoose.connection.on('disconnected', function() {
		console.log('Mongoose disconnected');
	});

	process.on('SIGINT', function() {
		mongoose.connection.close(function() {
			console.log('Mongoose disconnected through app termination');
			process.exit(0);
		});

	});

};
