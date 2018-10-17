var mongoose = require('mongoose');
var utils = require('../utils/Utils');

function User(_args, _fields, _cb) {
	if (!(this instanceof User)) {
		throw new TypeError("User constructor cannot be called as a function.");
	}

	UserEntity.call(this, _args, _fields, _cb);
}

module.exports = User;

var UserEntity = require('./entities/UserEntity');
var Copyright = require('./Copyright');

User.rapidModelObjectInheritsFrom(UserEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};

User.prototype.updateAccessToken = function(access_token, cb) {
	User._model.update({ _id:this.getId() }, { $set: { 'owned_github_profile.access_token': access_token }}, function(err) {
		cb(err);
	});
};

User.prototype.getNumCopyrightsByRepoId = function(cb) {
	Copyright._model.find({ triggering_repository_id: { $in : this.getMonitoredRepositoryIds() } }, function(err, docs) {
		cb(err, docs);
	});
};

User.prototype.getActiveCopyrights = function(cb) {
	Copyright._model.find({triggering_repository_id: {$in:this.getMonitoredRepositoryIds()}}, null, function(err, docs) {
		cb(err, docs);
	});
};

User.prototype.getRepoStats = function(ret, cb) {
	cb(null, ret);
};

User.prototype.isAdmin = function() {
	return true;
}