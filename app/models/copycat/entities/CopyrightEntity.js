var mongoose = require('mongoose');

function CopyrightEntity(_args, _fields, _cb) {
	var _this = this;
	this._exists = false;
	this._dirty = false;
	this._atomic = false;
	this._m = new (mongoose.model('Copyright'))();
	this._owned_copyright_sender = null;
	this._triggering_repository = null;

	if(typeof(_args) !== 'undefined' && typeof(_fields) !== 'undefined' && typeof(_cb) !== 'undefined' && typeof(_cb) === 'function') {
		var objId = null;
		if(typeof(_args) === 'string') {
			objId = new mongoose.Types.ObjectId(_args);
		} else if(typeof(_args) === 'object' && (_args instanceof mongoose.Types.ObjectId)) {
			objId = _args;
		}
		CopyrightEntity._model.findById(objId, _fields, function(_err, _doc) {
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

module.exports = CopyrightEntity;

var Copyright = require('../Copyright');
var CopyrightSender = require('../CopyrightSender');
var Repository = require('../Repository');

CopyrightEntity.prototype.instantiate = function(_doc) {
	if(_doc) {
		for(key in _doc) {
			this._m[key] = _doc[key];
		}
		this._exists = true;
	}
};

CopyrightEntity.prototype.insert = function(_cb) {
	if(!this._exists && typeof(CopyrightEntity._model) !== 'undefined') {
		var _this = this;
		this._m.save(function(_err, _doc) {
			if(!_err) {
				_this._exists = true;
			}
			_cb(_err);
		});
	}
};

CopyrightEntity.prototype.update = function(_cb) {
	if(this._exists && this._dirty && typeof(CopyrightEntity._model) !== 'undefined') {
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

CopyrightEntity.prototype.remove = function(_cb) {
	this._m.remove(function(_err) {
		_cb(_err);
	});
};

CopyrightEntity.prototype.getId = function() {
	return this._m['_id'];
};

CopyrightEntity.prototype.getStatus = function() {
	return this._m['status'];
};

CopyrightEntity.prototype.getRef = function() {
	return this._m['ref'];
};

CopyrightEntity.prototype.getBeforeSha = function() {
	return this._m['before_sha'];
};

CopyrightEntity.prototype.getAfterSha = function() {
	return this._m['after_sha'];
};

CopyrightEntity.prototype.getFileObjectId = function() {
	return this._m['file_object_id'];
};

CopyrightEntity.prototype.getFileName = function() {
	return this._m['file_name'];
};

CopyrightEntity.prototype.getFileContentType = function() {
	return this._m['file_content_type'];
};

CopyrightEntity.prototype.getFileLength = function() {
	return this._m['file_length'];
};

CopyrightEntity.prototype.getFileChunkSize = function() {
	return this._m['file_chunk_size'];
};

CopyrightEntity.prototype.getFileUploadDate = function() {
	return this._m['file_upload_date'];
};

CopyrightEntity.prototype.getFileMd5 = function() {
	return this._m['file_md5'];
};

CopyrightEntity.prototype.getOwnedCopyrightSender = function() {
	return new CopyrightSender(this._m['owned_copyright_sender']);
};

CopyrightEntity.prototype.getTriggeringRepositoryId = function() {
	return this._m['triggering_repository_id'];
};

CopyrightEntity.prototype.getTriggeringRepository = function(_fields, _cb) {
	if(this._triggering_repository === null || _fields !== null) {
		var _this = this;
		var triggering_repository = new Repository(this._m['triggering_repository_id'], _fields, function(_err) {
			_this._triggering_repository = triggering_repository.obj();
			_cb(_err, triggering_repository);
		});
	} else {
		var triggering_repository = new Repository();
		triggering_repository.instantiate(this._triggering_repository);
		_cb(null, triggering_repository);
	}
};

CopyrightEntity.prototype.setId = function(_id) {
	if(typeof(_id) === 'string' || (typeof(_id) === 'object' && (_id instanceof mongoose.Types.ObjectId))) {
		this._m['_id'] = _id;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setStatus = function(status) {
	if(typeof(status) === 'number' && status >= 0 && status < 5) {
		this._m['status'] = status;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setRef = function(ref) {
	if(typeof(ref) === 'string' && ref.length >= 1 && ref.length <= 250) {
		this._m['ref'] = ref;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setBeforeSha = function(before_sha) {
	if(typeof(before_sha) === 'string' && before_sha.length == 40) {
		this._m['before_sha'] = before_sha;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setAfterSha = function(after_sha) {
	if(typeof(after_sha) === 'string' && after_sha.length == 40) {
		this._m['after_sha'] = after_sha;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileObjectId = function(file_object_id) {
	if(typeof(file_object_id) === 'string' && file_object_id.length == 24) {
		this._m['file_object_id'] = file_object_id;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileName = function(file_name) {
	if(typeof(file_name) === 'string' && file_name.length >= 46 && file_name.length <= 256) {
		this._m['file_name'] = file_name;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileContentType = function(file_content_type) {
	if(typeof(file_content_type) === 'string' && file_content_type.length == 15) {
		this._m['file_content_type'] = file_content_type;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileLength = function(file_length) {
	if(typeof(file_length) === 'number' && (file_length === +file_length && file_length%1 === 0)) {
		this._m['file_length'] = file_length;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileChunkSize = function(file_chunk_size) {
	if(typeof(file_chunk_size) === 'number' && (file_chunk_size === +file_chunk_size && file_chunk_size%1 === 0)) {
		this._m['file_chunk_size'] = file_chunk_size;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileUploadDate = function(file_upload_date) {
	if(file_upload_date instanceof Date) {
		this._m['file_upload_date'] = file_upload_date;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setFileMd5 = function(file_md5) {
	if(typeof(file_md5) === 'string' && file_md5.length == 32) {
		this._m['file_md5'] = file_md5;
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setOwnedCopyrightSender = function(owned_copyright_sender) {
	if(owned_copyright_sender !== null && typeof(owned_copyright_sender) !== 'undefined' && (owned_copyright_sender instanceof CopyrightSender)) {
		this._m['owned_copyright_sender'] = owned_copyright_sender.obj();
		this._dirty = true;
	}
};

CopyrightEntity.prototype.setTriggeringRepository = function(triggering_repository, _cb) {
	if(triggering_repository !== null && typeof(triggering_repository) !== 'undefined' && (triggering_repository instanceof Repository) && triggering_repository.exists() && (triggering_repository.getId() instanceof mongoose.Types.ObjectId)) {
		this._m['triggering_repository_id'] = triggering_repository.getId();
		this._dirty = true;

		var _this = this;
		if(this._exists && !this._atomic) {
			this.update(function(_err) {
				if(_err) { _cb(_err); }
				triggering_repository.atomic(true);
				triggering_repository.addTriggeredCopyright(_this);
				triggering_repository.update(function(_err) {
					_cb(_err);
				});
			});
		} else {
			if(typeof(_cb) === 'function') {
				_cb(null);
			}
		}
	}
};

CopyrightEntity.prototype.removeTriggeringRepositoryById = function() {};

CopyrightEntity.prototype.removeTriggeringRepository = function(_fields, _cb) {};

CopyrightEntity.prototype.exists = function() {
	return this._exists;
};

CopyrightEntity.prototype.dirty = function(_dirty) {
	if(typeof(_dirty) === 'undefined') {
		return this._dirty;
	} else if(typeof(_dirty) === 'boolean') {
		this._dirty = _dirty;
	}
};

CopyrightEntity.prototype.atomic = function(_atomic) {
	if(typeof(_atomic) === 'undefined') {
		return this._atomic;
	} else if(typeof(_atomic) === 'boolean') {
		this._atomic = _atomic;
	}
};

CopyrightEntity.prototype.obj = function() {
	if(this._exists) {
		var obj = this._m.toObject();
		if(this._owned_copyright_sender !== null) {
			obj.owned_copyright_sender = this._owned_copyright_sender;
		}
		if(this._triggering_repository !== null) {
			obj.triggering_repository = this._triggering_repository;
		}
		delete obj.__v;
		return obj;
	} else {
		return {};
	}
};

CopyrightEntity._collection = 'copyright';

CopyrightEntity.StatusType = Object.freeze({
	TRIGGERED : 0,
	PURCHASED : 1,
	SUBMITTED : 2,
	AWARDED : 3,
	CANCELLED : 4
});

CopyrightEntity._schema = mongoose.Schema({
	status : { type : Number, required : true },
	ref : { type : String, required : true },
	before_sha : { type : String, required : true },
	after_sha : { type : String, required : true, unique : true, index : true },
	file_object_id : { type : String, required : true },
	file_name : { type : String, required : true },
	file_content_type : { type : String, required : true },
	file_length : { type : Number, required : true },
	file_chunk_size : { type : Number, required : true },
	file_upload_date : { type : Date, required : true },
	file_md5 : { type : String, required : true },
	owned_copyright_sender : CopyrightSender._schema,
	triggering_repository_id : { type : mongoose.Schema.Types.ObjectId, ref : 'Repository' }
}, { collection : CopyrightEntity._collection });

CopyrightEntity._model = mongoose.model('Copyright', CopyrightEntity._schema);

CopyrightEntity._schema.pre('remove', function(next) {
	this.model('Repository').update(
		{_id: this['triggering_repository_id']},
		{$pull: {triggered_copyright_ids: this['_id']}},
		{multi: false},
		next
	);
});

CopyrightEntity.afterShaExists = function(after_sha, _cb) {
	CopyrightEntity._model.find({after_sha: after_sha}, function(_err, _docs) {
		if(!_err && _docs.length == 1) {
			_cb(_err, true);
		} else {
			_cb(_err, false);
		}
	});
};

CopyrightEntity.getCopyrightByAfterSha = function(after_sha, _fields, _cb) {
	CopyrightEntity._model.findOne({after_sha: after_sha}, _fields, function(_err, _doc) {
		if(!_err) {
			var copyright = new Copyright();
			copyright.instantiate(_doc);
			_cb(_err, copyright);
		}
	});
};

CopyrightEntity.addCopyrights = function(copyrights, _cb) {
	CopyrightEntity._model.collection.insert(copyrights, function(_err) {
		_cb(_err);
	});
};

CopyrightEntity.clear = function(_cb) {
	CopyrightEntity._model.remove({}, function(_err) {
		_cb(_err)
	});
};

CopyrightEntity.drop = function(_cb) {
	mongoose.connection.collections[CopyrightEntity._collection].drop(function(_err) {
		_cb(_err)
	});
};

CopyrightEntity.count = function(_cb) {
	Copyright._model.count({}, function(err, count) {
		_cb(err, count);
	});
};

