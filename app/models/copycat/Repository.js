var mongoose = require('mongoose');
var utils = require('../utils/Utils');

function Repository(_args, _fields, _cb) {
	if (!(this instanceof Repository)) {
		throw new TypeError("Repository constructor cannot be called as a function.");
	}

	RepositoryEntity.call(this, _args, _fields, _cb);
}

module.exports = Repository;

var RepositoryEntity = require('./entities/RepositoryEntity');

Repository.rapidModelObjectInheritsFrom(RepositoryEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};
