var HttpController = require('./HttpController');

function GithubController(auth_token) {
	if (!(this instanceof GithubController)) {
		throw new TypeError("Invite constructor cannot be called as a function.");
	}

	this.http = new HttpController('api.github.com', 443, {
		'User-Agent': 'copy-cat.io',
		'Authorization': 'token ' + auth_token
	});
};

module.exports = GithubController;

GithubController.prototype.addPublicKey = function(title, key, cb) {
	var data = {
		title: title,
		key: key
	};
	this.http.request(HttpController.MethodType.POST, '/user/keys', null, data, '201', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.getRateLimit = function(cb) {
	this.http.request(HttpController.MethodType.GET, '/rate_limit', null, null, '200', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.getOrganizations = function(cb) {
	this.http.request(HttpController.MethodType.GET, '/user/orgs', null, null, '200', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.getRepos = function(name, cb) {
	var params = {
		"type": "all"
	};
	this.http.request(HttpController.MethodType.GET, '/users/' + name + '/repos', params, null, '200', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.getOrgRepos = function(name, cb) {
	var params = {
		"type": "all"
	};
	this.http.request(HttpController.MethodType.GET, '/orgs/' + name + '/repos', params, null, '200', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.createWebhook = function(owner, name, data, cb) {
	this.http.request(HttpController.MethodType.POST, '/repos/' + owner + '/' + name + '/hooks', null, data, '201', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.listWebhooks = function(owner, name, cb) {
	this.http.request(HttpController.MethodType.GET, '/repos/' + owner + '/' + name + '/hooks', null, null, '200', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};

GithubController.prototype.deleteWebhook = function(owner, name, id, cb) {
	this.http.request(HttpController.MethodType.DELETE, '/repos/' + owner + '/' + name + '/hooks/' + id, null, null, '204', HttpController.ContentType.JSON, HttpController.AcceptType.JSON, function(err, data) {
		cb(err, data);
	}, null);
};