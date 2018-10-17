var LocalStrategy		= require('passport-local').Strategy;
var GithubStrategy		= require('passport-github').Strategy;

var User				= require('../app/models/copycat/User');
var GithubProfile		= require('../app/models/copycat/GithubProfile');

var UserController		= require('../app/controllers/UserController');

module.exports = function(passport) {
	passport.serializeUser(function(user, done) {
		done(null, user.getId());
	});

	passport.deserializeUser(function(id, done) {
		var user = new User(id, null, function(err) {
			done(err, user);
		});
	});

	// === GITHUB LOGIN === //
	passport.use(new GithubStrategy({
		clientID		: process.env.GITHUB_CLIENT_ID,
		clientSecret	: process.env.GITHUB_CLIENT_SECRET,
		callbackURL		: process.env.GITHUB_CALLBACK
	},
	function(accessToken, refreshToken, profile, done) {
		User.getUserByGithubId(profile._json.id, null, function(err, user) {
			if(!err) {
				if(!user.exists()) {
console.log('HERE1');
					UserController.create(accessToken, profile._json, function(err, user) {
console.log(profile);
						return done(err, user);
					});
				} else {
					var gp = user.getOwnedGithubProfile();
					if(gp.getAccessToken() !== accessToken) {
						user.updateAccessToken(accessToken, function(err) {
							user.setLastLoginDate(new Date());
							user.update(function(err) {
								return done(err, user);
							});
						});
					} else {
						user.setLastLoginDate(new Date());
						user.update(function(err) {
							return done(err, user);
						});
					}
				}
			} else {
				return done(err, null);
			}
		});

	}));
};
