var express = require('express');
var router = express.Router();

module.exports = function(passport) {

/**
 *	/api/v1/auth/github
 */
router.route('/github')
	.get(passport.authenticate('github', { scope : 'user:email,repo,write:repo_hook' }));

/**
 *	/api/v1/auth/github/callback
 */
router.route('/github/callback')
		.get(function (req, resp, next) {
			passport.authenticate('github', {
				successRedirect : '/dashboard/#/',
				failureRedirect : '/login',
				failureFlash : true
		})(req, resp, next);
	});

	return router;
}
