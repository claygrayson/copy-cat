var mongoose = require('mongoose');

function CopyrightSenderEntity(_doc) {
	this._m = {};

	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
	}
};

module.exports = CopyrightSenderEntity;

var CopyrightSender = require('../CopyrightSender');

CopyrightSenderEntity.prototype.getId = function() {
	return this._m['_id'];
};

CopyrightSenderEntity.prototype.getLogin = function() {
	return this._m['login'];
};

CopyrightSenderEntity.prototype.getProfileId = function() {
	return this._m['profile_id'];
};

CopyrightSenderEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
	}
};

CopyrightSenderEntity.prototype.setLogin = function(login) {
	if(typeof(login) === 'undefined' || (typeof(login) === 'string' && login.length >= 1 && login.length <= 200)) {
		this._m['login'] = login;
	}
};

CopyrightSenderEntity.prototype.setProfileId = function(profile_id) {
	if(typeof(profile_id) === 'number' && (profile_id === +profile_id && profile_id%1 === 0)) {
		this._m['profile_id'] = profile_id;
	}
};

CopyrightSenderEntity.prototype.obj = function() {
	return this._m;
};

CopyrightSenderEntity._schema = mongoose.Schema({
	login : { type : String },
	profile_id : { type : Number }
});

CopyrightSenderEntity._model = mongoose.model('CopyrightSender', CopyrightSenderEntity._schema);

