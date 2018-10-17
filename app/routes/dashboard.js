var express = require('express');
var router = express.Router();

module.exports = function() {

/**
*	/dashboard
**/
router.route('/')
	.get(function (req, res, next) {
		if(req.isAuthenticated()) {
			res.render('dashboard', {
				title: 'CopyCat'
			});
		} else {
			res.redirect('/login');
		}
	});

return router;
}
