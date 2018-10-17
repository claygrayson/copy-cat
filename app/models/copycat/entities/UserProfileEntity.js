var mongoose = require('mongoose');

function UserProfileEntity(_doc) {
	this._m = {};

	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
	}
};

module.exports = UserProfileEntity;

var UserProfile = require('../UserProfile');

UserProfileEntity.prototype.getId = function() {
	return this._m['_id'];
};

UserProfileEntity.prototype.getFirstName = function() {
	return this._m['first_name'];
};

UserProfileEntity.prototype.getLastName = function() {
	return this._m['last_name'];
};

UserProfileEntity.prototype.getEmail = function() {
	return this._m['email'];
};

UserProfileEntity.prototype.getPhone = function() {
	return this._m['phone'];
};

UserProfileEntity.prototype.getCompanyName = function() {
	return this._m['company_name'];
};

UserProfileEntity.prototype.getCompanyAddress1 = function() {
	return this._m['company_address_1'];
};

UserProfileEntity.prototype.getCompanyAddress2 = function() {
	return this._m['company_address_2'];
};

UserProfileEntity.prototype.getCompanyCity = function() {
	return this._m['company_city'];
};

UserProfileEntity.prototype.getCompanyState = function() {
	return this._m['company_state'];
};

UserProfileEntity.prototype.getCompanyCountry = function() {
	return this._m['company_country'];
};

UserProfileEntity.prototype.getCompanyZip = function() {
	return this._m['company_zip'];
};

UserProfileEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
	}
};

UserProfileEntity.prototype.setFirstName = function(first_name) {
	if(typeof(first_name) === 'undefined' || (typeof(first_name) === 'string' && first_name.length >= 1 && first_name.length <= 40)) {
		this._m['first_name'] = first_name;
	}
};

UserProfileEntity.prototype.setLastName = function(last_name) {
	if(typeof(last_name) === 'undefined' || (typeof(last_name) === 'string' && last_name.length >= 1 && last_name.length <= 40)) {
		this._m['last_name'] = last_name;
	}
};

UserProfileEntity.prototype.setEmail = function(email) {
	if(typeof(email) === 'undefined' || (typeof(email) === 'string' && email.length >= 7 && email.length <= 50) && /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/igm.test(email)) {
		this._m['email'] = email;
	}
};

UserProfileEntity.prototype.setPhone = function(phone) {
	if(typeof(phone) === 'undefined' || (typeof(phone) === 'string' && phone.length >= 5 && phone.length <= 20)) {
		this._m['phone'] = phone;
	}
};

UserProfileEntity.prototype.setCompanyName = function(company_name) {
	if(typeof(company_name) === 'undefined' || (typeof(company_name) === 'string' && company_name.length >= 1 && company_name.length <= 200)) {
		this._m['company_name'] = company_name;
	}
};

UserProfileEntity.prototype.setCompanyAddress1 = function(company_address_1) {
	if(typeof(company_address_1) === 'undefined' || (typeof(company_address_1) === 'string' && company_address_1.length >= 1 && company_address_1.length <= 200)) {
		this._m['company_address_1'] = company_address_1;
	}
};

UserProfileEntity.prototype.setCompanyAddress2 = function(company_address_2) {
	if(typeof(company_address_2) === 'undefined' || (typeof(company_address_2) === 'string' && company_address_2.length >= 1 && company_address_2.length <= 200)) {
		this._m['company_address_2'] = company_address_2;
	}
};

UserProfileEntity.prototype.setCompanyCity = function(company_city) {
	if(typeof(company_city) === 'undefined' || (typeof(company_city) === 'string' && company_city.length >= 1 && company_city.length <= 200)) {
		this._m['company_city'] = company_city;
	}
};

UserProfileEntity.prototype.setCompanyState = function(company_state) {
	if(typeof(company_state) === 'undefined' || (typeof(company_state) === 'string' && company_state.length >= 1 && company_state.length <= 3)) {
		this._m['company_state'] = company_state;
	}
};

UserProfileEntity.prototype.setCompanyCountry = function(company_country) {
	if(typeof(company_country) === 'undefined' || (typeof(company_country) === 'string' && company_country.length == 2)) {
		this._m['company_country'] = company_country;
	}
};

UserProfileEntity.prototype.setCompanyZip = function(company_zip) {
	if(typeof(company_zip) === 'undefined' || (typeof(company_zip) === 'string' && company_zip.length == 2)) {
		this._m['company_zip'] = company_zip;
	}
};

UserProfileEntity.prototype.obj = function() {
	return this._m;
};

UserProfileEntity._schema = mongoose.Schema({
	first_name : { type : String },
	last_name : { type : String },
	email : { type : String },
	phone : { type : String },
	company_name : { type : String },
	company_address_1 : { type : String },
	company_address_2 : { type : String },
	company_city : { type : String },
	company_state : { type : String },
	company_country : { type : String },
	company_zip : { type : String }
});

UserProfileEntity._model = mongoose.model('UserProfile', UserProfileEntity._schema);

