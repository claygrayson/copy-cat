var express = require('express');
var router = express.Router();

var Copyright = require('../../../models/copycat/Copyright');

module.exports = function(passport) {

/**
 *	/api/v1/admin/copyrights
 */
router.route('/copyrights')
	.get(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			if(user.isAdmin()) {
				Copyright.getPurchasedCopyrights(function(err, docs) {
					if(!err) {
						resp.json({success:true, msg: 'Successfully Retrieved Purchased Copyrights', copyrights : docs});
					} else {
						resp.json({success:false, msg: 'Error Retrieving Purchased Copyrights', error : err});
					}
				});
			} else {
				resp.json(401, {success:false, msg:'Not Authorized'});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

/**
 *	/api/v1/admin/copyright/:copyright_id/submit
 */
router.route('/copyright/:copyright_id/submit')
	.put(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			if(user.isAdmin()) {
				var copyright = new Copyright(req.param.copyright_id, null, function(err) {
					if(!err) {
						copyright.setStatus(Copyright.StatusType.SUBMITTED);
						copyright.update(function(err) {
							if(!err) {
								resp.json({success:true, msg: 'Successfully Marked Copyright as Submitted', copyrights : docs});
							} else {
								resp.json({success:false, msg: 'Error Updating Copyright', error : err});
							}
						});
					} else {
						resp.json({success:false, msg: 'Error Retrieving Copyright', error : err});
					}
				});
			} else {
				resp.json(401, {success:false, msg:'Not Authorized'});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

/**
 *	/api/v1/admin/copyright/:copyright_id/award
 */
router.route('/copyright/:copyright_id/award')
	.put(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			if(user.isAdmin()) {
				var copyright = new Copyright(req.param.copyright_id, null, function(err) {
					if(!err) {
						copyright.setStatus(Copyright.StatusType.AWARDED);
						copyright.update(function(err) {
							if(!err) {
								resp.json({success:true, msg: 'Successfully Marked Copyright as Awarded', copyrights : docs});
							} else {
								resp.json({success:false, msg: 'Error Updating Copyright', error : err});
							}
						});
					} else {
						resp.json({success:false, msg: 'Error Retrieving Copyright', error : err});
					}
				});
			} else {
				resp.json(401, {success:false, msg:'Not Authorized'});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

	return router;
}
