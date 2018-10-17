var mongoose = require('mongoose');
var utils = require('../utils/Utils');

function Copyright(_args, _fields, _cb) {
	if (!(this instanceof Copyright)) {
		throw new TypeError("Copyright constructor cannot be called as a function.");
	}

	CopyrightEntity.call(this, _args, _fields, _cb);
}

module.exports = Copyright;

var CopyrightEntity = require('./entities/CopyrightEntity');

Copyright.rapidModelObjectInheritsFrom(CopyrightEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};

Copyright.getPurchasedCopyrights = function(cb) {
	Copyright._model.find({status: Copyright.StatusType.PURCHASED}, '-__v', function(err, docs) {
		console.log(docs);
		cb(err, docs);
	});
};