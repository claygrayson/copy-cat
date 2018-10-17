var mongoose = require('mongoose');

function RepositoryEntity(_args, _fields, _cb) {
	var _this = this;
	this._exists = false;
	this._dirty = false;
	this._atomic = false;
	this._m = new (mongoose.model('Repository'))();
	this._triggered_copyrights = null;
	this._monitoring_users = null;

	if(typeof(_args) !== 'undefined' && typeof(_fields) !== 'undefined' && typeof(_cb) !== 'undefined' && typeof(_cb) === 'function') {
		var objId = null;
		if(typeof(_args) === 'string') {
			objId = new mongoose.Types.ObjectId(_args);
		} else if(typeof(_args) === 'object' && (_args instanceof mongoose.Types.ObjectId)) {
			objId = _args;
		}
		RepositoryEntity._model.findById(objId, _fields, function(_err, _doc) {
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

module.exports = RepositoryEntity;

var Copyright = require('../Copyright');
var Repository = require('../Repository');
var User = require('../User');

RepositoryEntity.prototype.instantiate = function(_doc) {
	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
		this._exists = true;
	}
};

RepositoryEntity.prototype.insert = function(_cb) {
	if(!this._exists && typeof(RepositoryEntity._model) !== 'undefined') {
		var _this = this;
		this._m.save(function(_err, _doc) {
			if(!_err) {
				_this._exists = true;
			}
			_cb(_err);
		});
	}
};

RepositoryEntity.prototype.update = function(_cb) {
	if(this._exists && this._dirty && typeof(RepositoryEntity._model) !== 'undefined') {
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

RepositoryEntity.prototype.remove = function(_cb) {
	this._m.remove(function(_err) {
		_cb(_err);
	});
};

RepositoryEntity.prototype.getId = function() {
	return this._m['_id'];
};

RepositoryEntity.prototype.getRepoId = function() {
	return this._m['repo_id'];
};

RepositoryEntity.prototype.getRepoName = function() {
	return this._m['repo_name'];
};

RepositoryEntity.prototype.getOwnerLogin = function() {
	return this._m['owner_login'];
};

RepositoryEntity.prototype.getWebhookId = function() {
	return this._m['webhook_id'];
};

RepositoryEntity.prototype.getWebhookSecret = function() {
	return this._m['webhook_secret'];
};

RepositoryEntity.prototype.getTriggeredCopyrightIds = function() {
	return this._m['triggered_copyright_ids'];
};

RepositoryEntity.prototype.getTriggeredCopyrights = function(_fields, _cb) {
	var _this = this;
	Copyright._model.find({ 'triggering_repository_id': this._m['_id'] }, _fields, function(_err, _docs) {
		if(!_err) {
			var triggered_copyrights = new Array();
			for(var i=0; i<_docs.length; i++) {
				var triggered_copyright = new Copyright();
				triggered_copyright.instantiate(_docs[i]);
				triggered_copyrights.push(triggered_copyright.obj());
			}
			_this._triggered_copyrights = triggered_copyrights;
			_cb(_err, triggered_copyrights);
		} else {
			_cb(_err, null);
		}
	});
};

RepositoryEntity.prototype.getTriggeredCopyrightsByLimit = function(_start, _limit, _fields, _cb) {};

RepositoryEntity.prototype.getNumberOfTriggeredCopyrights = function(_cb) {
	Copyright._model.count({'triggering_repository_id': this._m['_id'] }, '_id', function(_err, _cnt) {
		_cb(_err, _cnt);
	});
};

RepositoryEntity.prototype.getMonitoringUserIds = function(_fields, _cb) {
	return this._m['monitoring_user_ids'];
};

RepositoryEntity.prototype.getMonitoringUsers = function(_fields, _cb) {
	var _this = this;
	User._model.find({'monitored_repository_ids': this._m['_id']}, _fields, function(_err, _docs) {
		if(!_err) {
			var monitoring_users = new Array();
			for(var i=0; i<_docs.length; i++) {
				var monitoring_user = new User();
				monitoring_user.instantiate(_docs[i]);
				monitoring_users.push(monitoring_user.obj());
			}
			_this._monitoring_users = monitoring_users;
			_cb(_err, monitoring_users);
		} else {
			_cb(_err, null);
		}
	});
};

RepositoryEntity.prototype.getMonitoringUsersByLimit = function(_start, _limit, _fields, _cb) {
	var _this = this;
	User._model.find({'monitored_repository_ids': this._m['_id']}, _fields, function(_err, _docs) {
		if(!_err) {
			var monitoring_users = new Array();
			for(var i=0; i<_docs.length; i++) {
				var monitoring_user = new User();
				monitoring_user.instantiate(_docs[i]);
				monitoring_users.push(monitoring_user.obj());
			}
			_this._monitoring_users = monitoring_users;
			_cb(_err, monitoring_users);
		} else {
			_cb(_err, null);
		}
	}).skip(_start).limit(_limit);
};

RepositoryEntity.prototype.getNumberOfMonitoringUsers = function(_cb) {
	User._model.count({'monitored_repository_ids': this._m['_id']}, function(_err, _count) {
		if(!_err) {
			_cb(_err, _count);
		} else {
			_cb(_err, null);
		}
	});
};

RepositoryEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.setRepoId = function(repo_id) {
	if(typeof(repo_id) === 'number' && (repo_id === +repo_id && repo_id%1 === 0)) {
		this._m['repo_id'] = repo_id;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.setRepoName = function(repo_name) {
	if(typeof(repo_name) === 'string' && repo_name.length >= 0 && repo_name.length <= 250) {
		this._m['repo_name'] = repo_name;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.setOwnerLogin = function(owner_login) {
	if(typeof(owner_login) === 'string' && owner_login.length >= 0 && owner_login.length <= 250) {
		this._m['owner_login'] = owner_login;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.setWebhookId = function(webhook_id) {
	if(typeof(webhook_id) === 'number' && (webhook_id === +webhook_id && webhook_id%1 === 0)) {
		this._m['webhook_id'] = webhook_id;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.setWebhookSecret = function(webhook_secret) {
	if(typeof(webhook_secret) === 'string' && webhook_secret.length == 128) {
		this._m['webhook_secret'] = webhook_secret;
		this._dirty = true;
	}
};

RepositoryEntity.prototype.addTriggeredCopyright = function(triggered_copyright, _cb) {
	if(triggered_copyright !== null && typeof(triggered_copyright) !== 'undefined' && (triggered_copyright instanceof Copyright) && triggered_copyright.exists() && (triggered_copyright.getId() instanceof mongoose.Types.ObjectId)) {
		if(typeof(this._m['triggered_copyright_ids']) !== 'undefined') {
			var _id_exists = false;
			for(var i=0; i<this._m['triggered_copyright_ids'].length; i++) {
				if(this._m['triggered_copyright_ids'][i].toString() === triggered_copyright.getId().toString()) {
					_id_exists = true;
					break;
				}
			}
			if(!_id_exists) {
				this._m['triggered_copyright_ids'].push(triggered_copyright.getId());
				this._dirty = true;
			}
		} else {
			this._m['triggered_copyright_ids'] = new Array();
			this._m['triggered_copyright_ids'].push(triggered_copyright.getId());
		}

		var _this = this;
		if(this._exists && !this._atomic) {
			this.update(function(_err) {
				if(_err) { _cb(_err); }
				triggered_copyright.atomic(true);
				triggered_copyright.setTriggeringRepository(_this);
				triggered_copyright.update(function(_err) {
					_cb(_err);
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

RepositoryEntity.prototype.addTriggeredCopyrights = function(triggered_copyrights, _cb) {
	if(triggered_copyrights.constructor == Array && triggered_copyrights.length > 0) {
		var triggered_copyright_ids = new Array();
		for(var i=0; i < triggered_copyrights.length; i++) {
			if((triggered_copyrights[i] instanceof Copyright) && triggered_copyrights[i].exists() && (triggered_copyrights[i].getId() instanceof mongoose.Types.ObjectId)) {
				triggered_copyright_ids.push(triggered_copyrights[i].getId());
				this._m['triggered_copyright_ids'].push(triggered_copyrights[i].getId());
				this._dirty = true;
			}
		}

		var _this = this;
		if(this._exists && !this._atomic) {
			this.update(function(_err) {
				if(_err) { _cb(_err); }
				Copyright._model.update({'_id':{$in:triggered_copyright_ids}},{$addToSet:{triggering_repository_id:_this._m['_id']}}, {multi:true}, function(_err) {
					_cb(_err);
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

RepositoryEntity.prototype.setTriggeredCopyrightIds = function(triggered_copyright_ids, _cb) {};

RepositoryEntity.prototype.addMonitoringUser = function(monitoring_user, _cb) {
	if(monitoring_user !== null && typeof(monitoring_user) !== 'undefined' && (monitoring_user instanceof User) && monitoring_user.exists() && (monitoring_user.getId() instanceof mongoose.Types.ObjectId)) {
		var _id_exists = false;
		for(var i=0; i<this._m['monitoring_user_ids'].length; i++) {
			if(this._m['monitoring_user_ids'][i].toString() === monitoring_user.getId().toString()) {
				_id_exists = true;
				break;
			}
		}
		if(!_id_exists) {
			this._m['monitoring_user_ids'].push(monitoring_user.getId());
			this._dirty = true;
		}
		var _this = this;
		if(this._exists && !this._atomic) {
			this.update(function(_err) {
				if(_err) {
					if(typeof(_cb) === 'function') {
						_cb(_err);
					}
				}
				monitoring_user.atomic(true);
				monitoring_user.addMonitoredRepository(_this, function(_err) {
					monitoring_user.update(function(_err) {
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
	}
};

RepositoryEntity.prototype.addMonitoringUsers = function(_monitoring_users, _cb) {};

RepositoryEntity.prototype.setMonitoringUsers = function(_monitoring_users, _cb) {};

RepositoryEntity.prototype.setMonitoringUserIds = function(_monitoring_user_ids, _cb) {
	if(_monitoring_user_ids !== null && typeof(_monitoring_user_ids) !== 'undefined' && _monitoring_user_ids.constructor == Array) {
		this._m['monitoring_user_ids'] = _monitoring_user_ids;
		this._dirty = true;

		var _this = this;
		User._model.update({'_id':{$in:_monitoring_user_ids}},{$addToSet:{monitored_repository_ids:this._m['_id']}}, {multi:true}, function(_err) {
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

RepositoryEntity.prototype.removeTriggeredCopyrightIds = function() {};

RepositoryEntity.prototype.removeTriggeredCopyrights = function(_fields, _cb) {};

RepositoryEntity.prototype.removeMonitoringUserByIds = function(_fields, _cb) {};

RepositoryEntity.prototype.removeMonitoringUsers = function(monitoring_users, _cb) {
	console.log(monitoring_users);
	if(monitoring_users !== null && typeof(monitoring_users) !== 'undefined' && monitoring_users.constructor == Array) {
		var _this = this;
		var _monitoring_user_ids = new Array();
		monitoring_users.forEach(function(monitoring_user) {
			for(var i=0; i<_this._m['monitoring_user_ids'].length; i++) {
				if(_this._m['monitoring_user_ids'][i].toString() == monitoring_user.getId().toString()) {
					_this._m['monitoring_user_ids'].splice(i, 1);
				}
			}
			_monitoring_user_ids.push(monitoring_user.getId());
		});
		this._dirty = true;

		User._model.update({'_id':{$in:_monitoring_user_ids}},{$pull:{monitored_repository_ids:_this.getId()}},{multi:true},function(_err) {
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

RepositoryEntity.prototype.exists = function() {
	return this._exists;
};

RepositoryEntity.prototype.dirty = function(_dirty) {
	if(typeof(_dirty) === 'undefined') {
		return this._dirty;
	} else if(typeof(_dirty) === 'boolean') {
		this._dirty = _dirty;
	}
};

RepositoryEntity.prototype.atomic = function(_atomic) {
	if(typeof(_atomic) === 'undefined') {
		return this._atomic;
	} else if(typeof(_atomic) === 'boolean') {
		this._atomic = _atomic;
	}
};

RepositoryEntity.prototype.obj = function() {
	if(this._exists) {
		var obj = this._m.toObject();
		if(this._triggered_copyrights !== null) {
			obj.triggered_copyrights = this._triggered_copyrights;
		}
		if(this._monitoring_users !== null) {
			obj.monitoring_users = this._monitoring_users;
		}
		delete obj.__v;
		return obj;
	} else {
		return {};
	}
};

RepositoryEntity._collection = 'repository';

RepositoryEntity._schema = mongoose.Schema({
	repo_id : { type : Number, required : true, unique : true, index : true },
	repo_name : { type : String, required : true },
	owner_login : { type : String, required : true },
	webhook_id : { type : Number },
	webhook_secret : { type : String, required : true },
	triggered_copyright_ids : [ { type : mongoose.Schema.Types.ObjectId, ref : 'Copyright' } ],
	monitoring_user_ids : [ { type : mongoose.Schema.Types.ObjectId, ref : 'User' } ]
}, { collection : RepositoryEntity._collection });

RepositoryEntity._model = mongoose.model('Repository', RepositoryEntity._schema);

RepositoryEntity._schema.pre('remove', function(next) {
	this.model('Copyright').update(
		{triggering_repository_id: this['_id']},
		{$unset: {triggering_repository_id: ""}},
		{multi: true},
		next
	);
});

RepositoryEntity._schema.pre('remove', function(next) {
	this.model('User').update(
		{monitored_repository_ids: this['_id']},
		{$pull: {monitored_repository_ids: this['_id']}},
		{multi: true},
		next
	);
});

RepositoryEntity.repoIdExists = function(repo_id, _cb) {
	RepositoryEntity._model.find({repo_id: repo_id}, function(_err, _docs) {
		if(!_err && _docs.length == 1) {
			_cb(_err, true);
		} else {
			_cb(_err, false);
		}
	});
};

RepositoryEntity.getRepositoryByRepoId = function(repo_id, _fields, _cb) {
	RepositoryEntity._model.findOne({repo_id: repo_id}, _fields, function(_err, _doc) {
		if(!_err) {
			var repository = new Repository();
			repository.instantiate(_doc);
			_cb(_err, repository);
		}
	});
};

RepositoryEntity.addRepositories = function(repositories, _cb) {
	RepositoryEntity._model.collection.insert(repositories, function(_err) {
		_cb(_err);
	});
};

RepositoryEntity.clear = function(_cb) {
	RepositoryEntity._model.remove({}, function(_err) {
		_cb(_err)
	});
};

RepositoryEntity.drop = function(_cb) {
	mongoose.connection.collections[RepositoryEntity._collection].drop(function(_err) {
		_cb(_err)
	});
};

RepositoryEntity.count = function(_cb) {
	Repository._model.count({}, function(err, count) {
		_cb(err, count);
	});
};

