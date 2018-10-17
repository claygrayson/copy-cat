var express = require('express');
var router = express.Router();

module.exports = function() {
/**
*	/
**/
router.route('/')
	.get(function (req, res, next) {
		res.render('landing', {
			title: ''
		});
	});

/**
*	/login
**/
router.route('/login')
	.get(function (req, res, next) {
		res.render('login', {
			title: 'login'
		});
	});

/**
 *	/logout
 */
router.route('/logout')
	.get(function (req, resp, next) {
		req.logout();
		resp.redirect('/login');
	});

return router;
}
