var express = require('express');
var router = express.Router();

var Copyright = require('../../../models/copycat/Copyright');

module.exports = function(gfs) {

/**
 *	/api/v1/copyright/download/:filename
 */
router.route('/download/:filename')
	.get(function(req, resp, next) {
		gfs.findOne({ filename: req.params.filename }, function (err, file) {
			if(!err) {
				if(file) {
					var readstream = gfs.createReadStream({
						_id: file._id
					});
					readstream.on("error", function(err) { 
						resp.end();
					});

					resp.setHeader('Content-Type', 'application/zip');
					resp.setHeader('Content-Disposition', 'attachment; filename="' + file.filename + '"');
					readstream.pipe(resp);
				} else {
					resp.json({success:false, msg: 'File Does Not Exist'});
				}
			} else {
				resp.json({success:false, msg: 'Error Retrieving File', error : err});
			}
		});
	});

/**
 *	/api/v1/copyright/:copyright_id
 */
router.route('/:copyright_id')
	.get(function(req, resp, next) {
		if(req.isAuthenticated()) {
			var copyright = new Copyright(req.params.copyright_id, null, function(err) {
				if(!err) {
					resp.json({success:true, msg: 'Successfully Retrieved Copyright', data : copyright.obj()});
				} else {
					resp.json({success:false, msg: 'Error Retrieving Copyright', error : err});
				}
			});
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

	return router;
}
