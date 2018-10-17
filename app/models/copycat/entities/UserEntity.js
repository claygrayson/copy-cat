var mongoose = require('mongoose');

function UserEntity(_args, _fields, _cb) {
	var _this = this;
	this._exists = false;
	this._dirty = false;
	this._atomic = false;
	this._m = new (mongoose.model('User'))();
	this._owned_github_profile = null;
	this._owned_user_profile = null;
	this._monitored_repositories = null;

	if(typeof(_args) !== 'undefined' && typeof(_fields) !== 'undefined' && typeof(_cb) !== 'undefined' && typeof(_cb) === 'function') {
		var objId = null;
		if(typeof(_args) === 'string') {
			objId = new mongoose.Types.ObjectId(_args);
		} else if(typeof(_args) === 'object' && (_args instanceof mongoose.Types.ObjectId)) {
			objId = _args;
		}
		UserEntity._model.findById(objId, _fields, function(_err, _doc) {
			if(!_err && _doc !== null) {
				for(key in _doc) {
					_this._m[key] = _doc[key];
				}
				_this._exists = true;
			}
			_cb(_err);
		});
	}
};

module.exports = UserEntity;

var UserProfile = require('../UserProfile');
var Repository = require('../Repository');
var GithubProfile = require('../GithubProfile');
var User = require('../User');

UserEntity.prototype.instantiate = function(_doc) {
	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
		this._exists = true;
	}
};

UserEntity.prototype.insert = function(_cb) {
	if(!this._exists && typeof(UserEntity._model) !== 'undefined') {
		var _this = this;
		this._m.save(function(_err, _doc) {
			if(!_err) {
				_this._exists = true;
			}
			_cb(_err);
		});
	}
};

UserEntity.prototype.update = function(_cb) {
	if(this._exists && this._dirty && typeof(UserEntity._model) !== 'undefined') {
		var _this = this;
		this._m.save(function(_err, _doc) {
			if(!_err) {
				_this._dirty = false;
			}
			if(typeof(_cb) === 'function') {
				_cb(_err);
			};
		});
	} else {
		if(typeof(_cb) === 'function') {
			_cb(null);
		}
	}
};

UserEntity.prototype.remove = function(_cb) {
	this._m.remove(function(_err) {
		_cb(_err);
	});
};

UserEntity.prototype.getId = function() {
	return this._m['_id'];
};

UserEntity.prototype.getGithubId = function() {
	return this._m['github_id'];
};

UserEntity.prototype.getStripeId = function() {
	return this._m['stripe_id'];
};

UserEntity.prototype.getSignUpDate = function() {
	return this._m['sign_up_date'];
};

UserEntity.prototype.getLastLoginDate = function() {
	return this._m['last_login_date'];
};

UserEntity.prototype.getOwnedGithubProfile = function() {
	return new GithubProfile(this._m['owned_github_profile']);
};

UserEntity.prototype.getOwnedUserProfile = function() {
	return new UserProfile(this._m['owned_user_profile']);
};

UserEntity.prototype.getMonitoredRepositoryIds = function() {
	return this._m['monitored_repository_ids'];
};

UserEntity.prototype.getMonitoredRepositories = function(_fields, _cb) {
	var _this = this;
	Repository._model.find({'monitoring_user_ids': this._m['_id'] }, _fields, function(_err, _docs) {
		if(!_err) {
			var monitored_repositories = new Array();
			for(var i=0; i<_docs.length; i++) {
				var monitored_repository = new Repository();
				monitored_repository.instantiate(_docs[i]);
				monitored_repositories.push(monitored_repository.obj());
			}
			_this._monitored_repositories = monitored_repositories;
			_cb(_err, monitored_repositories);
		} else {
			_cb(_err, null);
		}
	});
};

UserEntity.prototype.getMonitoredRepositoriesByLimit = function(_start, _limit, _fields, _cb) {
	var _this = this;
	Repository._model.find({'monitoring_user_ids': this._m['_id'] }, _fields, function(_err, _docs) {
		if(!_err) {
			var monitored_repositories = new Array();
			for(var i=0; i<_docs.length; i++) {
				var monitored_repository = new Repository();
				monitored_repository.instantiate(_docs[i]);
				monitored_repositories.push(monitored_repository.obj());
			}
			_this._monitored_repositories = monitored_repositories;
			_cb(_err, monitored_repositories);
		} else {
			_cb(_err, null);
		}
	}).skip(_start).limit(_limit);
};

UserEntity.prototype.getNumberOfMonitoredRepositories = function(_cb) {
	Repository._model.count({'monitoring_user_ids': this._m['_id']}, function(_err, _count) {
		if(!_err) {
			_cb(_err, _count);
		} else {
			_cb(_err, null);
		}
	});
};

UserEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
		this._dirty = true;
	}
};

UserEntity.prototype.setGithubId = function(github_id) {
	if(typeof(github_id) === 'number' && (github_id === +github_id && github_id%1 === 0)) {
		this._m['github_id'] = github_id;
		this._dirty = true;
	}
};

UserEntity.prototype.setStripeId = function(stripe_id) {
	if(typeof(stripe_id) === 'string' && stripe_id.length >= 10 && stripe_id.length <= 30) {
		this._m['stripe_id'] = stripe_id;
		this._dirty = true;
	}
};

UserEntity.prototype.setSignUpDate = function(sign_up_date) {
	if(sign_up_date instanceof Date) {
		this._m['sign_up_date'] = sign_up_date;
		this._dirty = true;
	}
};

UserEntity.prototype.setLastLoginDate = function(last_login_date) {
	if(last_login_date instanceof Date) {
		this._m['last_login_date'] = last_login_date;
		this._dirty = true;
	}
};

UserEntity.prototype.setOwnedGithubProfile = function(owned_github_profile) {
	if(owned_github_profile !== null && typeof(owned_github_profile) !== 'undefined' && (owned_github_profile instanceof GithubProfile)) {
		this._m['owned_github_profile'] = owned_github_profile.obj();
		this._dirty = true;
	}
};

UserEntity.prototype.setOwnedUserProfile = function(owned_user_profile) {
	if(owned_user_profile !== null && typeof(owned_user_profile) !== 'undefined' && (owned_user_profile instanceof UserProfile)) {
		this._m['owned_user_profile'] = owned_user_profile.obj();
		this._dirty = true;
	}
};

UserEntity.prototype.addMonitoredRepository = function(monitored_repository, _cb) {
	if(monitored_repository !== null && typeof(monitored_repository) !== 'undefined' && (monitored_repository instanceof Repository) && monitored_repository.exists() && (monitored_repository.getId() instanceof mongoose.Types.ObjectId)) {
		var _id_exists = false;
		for(var i=0; i<this._m['monitored_repository_ids'].length; i++) {
			if(this._m['monitored_repository_ids'][i].toString() === monitored_repository.getId().toString()) {
				_id_exists = true;
				break;
			}
		}
		if(!_id_exists) {
			this._m['monitored_repository_ids'].push(monitored_repository.getId());
			this._dirty = true;
		}
		var _this = this;
		if(this._exists && !this._atomic) {
			this.update(function(_err) {
				if(_err) { _cb(_err); }
				monitored_repository.atomic(true);
				monitored_repository.addMonitoringUser(_this, function(_err) {
					monitored_repository.update(function(_err) {
						if(typeof(_cb) === 'function') {
							_cb(_err);
						}
					});
				});
			});
		} else {
			if(typeof(_cb) === 'function') {
				_cb(null);
			}
		}
	} else {
		if(typeof(_cb) === 'function') {
			_cb(null);
		}
	}
};

UserEntity.prototype.addMonitoredRepositories = function(monitored_repositories, _cb) {};

UserEntity.prototype.setMonitoredRepositories = function(monitored_repositories, _cb) {};

UserEntity.prototype.setMonitoredRepositoryIds = function(monitored_repository_ids, _cb) {
	if(monitored_repository_ids !== null && typeof(monitored_repository_ids) !== 'undefined' && monitored_repository_ids.constructor == Array) {
		this._m['monitored_repository_ids'] = monitored_repository_ids;
		this._dirty = true;

		var _this = this;
		Repository._model.update({'_id':{$in:monitored_repository_ids}},{$addToSet:{monitoring_user_ids:this._m['_id']}}, {multi:true}, function(_err) {
			if(_this._exists && !_this._atomic) {
				_this.update(function(_err) {
					_cb(_err);
				});
			} else {
				_cb(_err);
			}
		});
	}
};

UserEntity.prototype.removeMonitoredRepositoryByIds = function(monitored_repository_ids, _cb) {
	if(monitored_repository_ids !== null && typeof(monitored_repository_ids) !== 'undefined' && monitored_repository_ids.constructor == Array) {
		Repository._model.update({'_id':{$in:monitored_repository_ids}},{$pull:{monitored_repository_ids:_this.getId()}},{multi:true},function(_err) {
			if(!_err) {
				if(_this._exists && !_this._atomic) {
					_this.update(function(_err) {
						_cb(_err);
					});
				} else {
					_cb(_err);
				}
			} else {
				_cb(_err);
			}
		});
	}
};

UserEntity.prototype.removeMonitoredRepositories = function(monitored_repositories, _cb) {
	if(monitored_repositories !== null && typeof(monitored_repositories) !== 'undefined' && monitored_repositories.constructor == Array) {
		var _this = this;
		var _monitored_repository_ids = new Array();
		monitored_repositories.forEach(function(monitored_repository) {
			for(var i=0; i<_this._m['monitored_repository_ids'].length; i++) {
				if(_this._m['monitored_repository_ids'][i].toString() == monitored_repository.getId().toString()) {
					_this._m['monitored_repository_ids'].splice(i, 1);
				}
			}
			_monitored_repository_ids.push(monitored_repository.getId());
		});
		this._dirty = true;

		Repository._model.update({'_id':{$in:_monitored_repository_ids}},{$pull:{monitored_repository_ids:_this.getId()}},{multi:true},function(_err) {
			if(!_err) {
				if(_this._exists && !_this._atomic) {
					_this.update(function(_err) {
						_cb(_err);
					});
				} else {
					_cb(_err);
				}
			} else {
				_cb(_err);
			}
		});
	}
};

UserEntity.prototype.exists = function() {
	return this._exists;
};

UserEntity.prototype.dirty = function(_dirty) {
	if(typeof(_dirty) === 'undefined') {
		return this._dirty;
	} else if(typeof(_dirty) === 'boolean') {
		this._dirty = _dirty;
	}
};

UserEntity.prototype.atomic = function(_atomic) {
	if(typeof(_atomic) === 'undefined') {
		return this._atomic;
	} else if(typeof(_atomic) === 'boolean') {
		this._atomic = _atomic;
	}
};

UserEntity.prototype.obj = function() {
	if(this._exists) {
		var obj = this._m.toObject();
		if(this._owned_github_profile !== null) {
			obj.owned_github_profile = this._owned_github_profile;
		}
		if(this._owned_user_profile !== null) {
			obj.owned_user_profile = this._owned_user_profile;
		}
		if(this._monitored_repositories !== null) {
			obj.monitored_repositories = this._monitored_repositories;
		}
		delete obj.__v;
		return obj;
	} else {
		return {};
	}
};

UserEntity._collection = 'user';

UserEntity._schema = mongoose.Schema({
	github_id : { type : Number, unique : true, sparse : true, index : true },
	stripe_id : { type : String, required : true },
	sign_up_date : { type : Date, required : true },
	last_login_date : { type : Date },
	owned_github_profile : GithubProfile._schema,
	owned_user_profile : UserProfile._schema,
	monitored_repository_ids : [ { type : mongoose.Schema.Types.ObjectId, ref : 'Repository' } ]
}, { collection : UserEntity._collection });

UserEntity._model = mongoose.model('User', UserEntity._schema);

UserEntity._schema.pre('remove', function(next) {
	this.model('Repository').update(
		{monitoring_user_ids: this['_id']},
		{$pull: {monitoring_user_ids: this['_id']}},
		{multi: true},
		next
	);
});

UserEntity.githubIdExists = function(github_id, _cb) {
	UserEntity._model.find({github_id: github_id}, function(_err, _docs) {
		if(!_err && _docs.length == 1) {
			_cb(_err, true);
		} else {
			_cb(_err, false);
		}
	});
};

UserEntity.getUserByGithubId = function(github_id, _fields, _cb) {
	UserEntity._model.findOne({github_id: github_id}, _fields, function(_err, _doc) {
		if(!_err) {
			var user = new User();
			user.instantiate(_doc);
			_cb(_err, user);
		}
	});
};

UserEntity.addUsers = function(users, _cb) {
	UserEntity._model.collection.insert(users, function(_err) {
		_cb(_err);
	});
};

UserEntity.clear = function(_cb) {
	UserEntity._model.remove({}, function(_err) {
		_cb(_err)
	});
};

UserEntity.drop = function(_cb) {
	mongoose.connection.collections[UserEntity._collection].drop(function(_err) {
		_cb(_err)
	});
};

UserEntity.count = function(_cb) {
	User._model.count({}, function(err, count) {
		_cb(err, count);
	});
};

