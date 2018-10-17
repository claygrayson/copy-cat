var mongoose = require('mongoose');

function GithubProfileEntity(_doc) {
	this._m = {};

	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
	}
};

module.exports = GithubProfileEntity;

var GithubProfile = require('../GithubProfile');

GithubProfileEntity.prototype.getId = function() {
	return this._m['_id'];
};

GithubProfileEntity.prototype.getEmail = function() {
	return this._m['email'];
};

GithubProfileEntity.prototype.getAccessToken = function() {
	return this._m['access_token'];
};

GithubProfileEntity.prototype.getLogin = function() {
	return this._m['login'];
};

GithubProfileEntity.prototype.getCompany = function() {
	return this._m['company'];
};

GithubProfileEntity.prototype.getLocation = function() {
	return this._m['location'];
};

GithubProfileEntity.prototype.getHireable = function() {
	return this._m['hireable'];
};

GithubProfileEntity.prototype.getBio = function() {
	return this._m['bio'];
};

GithubProfileEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
	}
};

GithubProfileEntity.prototype.setEmail = function(email) {
	if(typeof(email) === 'undefined' || (typeof(email) === 'string' && email.length >= 7 && email.length <= 50) && /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/igm.test(email)) {
		this._m['email'] = email;
	}
};

GithubProfileEntity.prototype.setAccessToken = function(access_token) {
	if(typeof(access_token) === 'undefined' || (typeof(access_token) === 'string' && access_token.length == 40)) {
		this._m['access_token'] = access_token;
	}
};

GithubProfileEntity.prototype.setLogin = function(login) {
	if(typeof(login) === 'undefined' || (typeof(login) === 'string' && login.length >= 1 && login.length <= 200)) {
		this._m['login'] = login;
	}
};

GithubProfileEntity.prototype.setCompany = function(company) {
	if(typeof(company) === 'undefined' || (typeof(company) === 'string' && company.length >= 1 && company.length <= 200)) {
		this._m['company'] = company;
	}
};

GithubProfileEntity.prototype.setLocation = function(location) {
	if(typeof(location) === 'undefined' || (typeof(location) === 'string' && location.length >= 1 && location.length <= 200)) {
		this._m['location'] = location;
	}
};

GithubProfileEntity.prototype.setHireable = function(hireable) {
	if(typeof(hireable) === 'boolean') {
		this._m['hireable'] = hireable;
	}
};

GithubProfileEntity.prototype.setBio = function(bio) {
	if(typeof(bio) === 'undefined' || (typeof(bio) === 'string' && bio.length >= 1 && bio.length <= 1200)) {
		this._m['bio'] = bio;
	}
};

GithubProfileEntity.prototype.obj = function() {
	return this._m;
};

GithubProfileEntity._schema = mongoose.Schema({
	email : { type : String },
	access_token : { type : String },
	login : { type : String },
	company : { type : String },
	location : { type : String },
	hireable : { type : Boolean },
	bio : { type : String }
});

GithubProfileEntity._model = mongoose.model('GithubProfile', GithubProfileEntity._schema);

