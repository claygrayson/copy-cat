var express = require('express');
var router = express.Router();

module.exports = function() {

/**
 *	/copyright/:copyright_id
 */
router.route('/:copyright_id')
	.get(function (req, res, next) {
		if(req.isAuthenticated()) {
			res.render('copyright', {
				title: 'CopyCat'
			});
		} else {
			console.log(process.env.HOST + '/copyright/' + req.params.copyright_id);
			res.redirect('/login?redirect=' + encodeURIComponent(process.env.HOST + '/copyright/' + req.params.copyright_id));
		}
	});


return router;
}


