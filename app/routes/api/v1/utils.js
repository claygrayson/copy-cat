var express = require('express');
var router = express.Router();

var User = require('../../../models/copycat/User');
var Repository = require('../../../models/copycat/Repository');
var CopyRight = require('../../../models/copycat/CopyRight');

module.exports = function() {

router.route('/clear')
	.get(function (req, resp, next) {
		User.clear(function(err) {
			if(!err) {
				Repository.clear(function(err) {
					if(!err) {
						CopyRight.clear(function(err) {
							if(!err) {
								resp.json({success:true, msg:'Successfully Cleared Database'});
							} else {
								resp.json({success:false, msg:'Error Clearing CopyRight', err : err});
							}
						});
					} else {
						resp.json({success:false, msg:'Error Clearing Repository', err : err});
					}
				});
			} else {
				resp.json({success:false, msg:'Error Clearing User', err : err});
			}
		});
	});

	return router;
}
