var utils = require('../utils/Utils');

function UserProfile(_doc) {
	if (!(this instanceof UserProfile)) {
		throw new TypeError("UserProfile constructor cannot be called as a function.");
	}

	UserProfileEntity.call(this, _doc);
}

module.exports = UserProfile;

var UserProfileEntity = require('./entities/UserProfileEntity');

UserProfile.rapidModelObjectInheritsFrom(UserProfileEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};
