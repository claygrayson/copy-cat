var utils = require('../utils/Utils');

function CopyrightSender(_doc) {
	if (!(this instanceof CopyrightSender)) {
		throw new TypeError("CopyrightSender constructor cannot be called as a function.");
	}

	CopyrightSenderEntity.call(this, _doc);
}

module.exports = CopyrightSender;

var CopyrightSenderEntity = require('./entities/CopyrightSenderEntity');

CopyrightSender.rapidModelObjectInheritsFrom(CopyrightSenderEntity);

/******* ADD OVERRIDING PROTOTYPED METHODS BELOW HERE *******/
/************************ FOR EXAMPLE ***********************/
//User.prototype.setEmail = function(email) {
//	this.parent.setEmail.call(this, email);
//};
