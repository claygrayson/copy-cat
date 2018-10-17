var utils = require('../utils/Utils');

function GithubProfile(_doc) {
	if (!(this instanceof GithubProfile)) {
		throw new TypeError("GithubProfile constructor cannot be called as a function.");
	}

	GithubProfileEntity.call(this, _doc);
}

module.exports = GithubProfile;

var GithubProfileEntity = require('./entities/GithubProfileEntity');

GithubProfile.rapidModelObjectInheritsFrom(GithubProfileEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};
