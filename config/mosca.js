var mosca = require('mosca');

module.exports = function(app) {
	var pubsubsettings = {
		type: 'mongo',
		url: process.env.MONGOLAB_URI || 'mongodb://localhost:27017/copycat',
		pubsubCollection: 'mqtt',
		mongo: {}
	};

	var server = new mosca.Server({
		persistence: {
			factory: mosca.persistence.Mongo,
			url: process.env.MONGOLAB_URI || 'mongodb://localhost:27017/copycat' 
		}
	}, function() {
		server.attachHttpServer(app);
	});

	server.on('ready', function() {
		console.log('Mosca is Running');
	});

	//fired when a client is connected
	server.on('clientConnected', function(client) {
		console.log('client connected', client.id);
	});

	//fired when a message is received
	server.on('published', function(packet, client) {
		console.log('Published ' + packet.topic + ' : ', packet.payload);
	});

	//fired when a client subscribes to a topic
	server.on('subscribed', function(topic, client) {
		console.log('subscribed : ', topic);
	});

	//fired when a client unsubscribes to a topic
	server.on('unsubscribed', function(topic, client) {
		console.log('unsubscribed : ', topic);
	});

	//fired when a client is disconnecting
	server.on('clientDisconnecting', function(client) {
		console.log('clientDisconnecting : ', client.id);
	});

	//fired when a client is disconnected
	server.on('clientDisconnected', function(client) {
		console.log('clientDisconnected : ', client.id);
	});

	return server;
};