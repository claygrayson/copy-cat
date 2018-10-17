var https				= require('https');
var crypto				= require('crypto');
var stripe				= require('stripe')(process.env.STRIPE_KEY);

var GithubController	= require('./GithubController');
var EmailController		= require('./EmailController');

var Utils = require('../models/utils/Utils');
var User = require('../models/copycat/User');
var GithubProfile = require('../models/copycat/GithubProfile');
var UserProfile = require('../models/copycat/UserProfile');

function UserController() {

}

UserController.create = function(accessToken, profile, cb) {
	stripe.customers.create({
		email: profile.email,
		metadata: {
			app: 'copy-cat.io'
		}
	}, function(err, customer) {
		if(!err) {

			var user = new User();
			user.setGithubId(profile.id);
			user.setStripeId(customer.id);
			user.setSignUpDate(new Date());
			user.setLastLoginDate(new Date());

			var gp = new GithubProfile();
			gp.setAccessToken(accessToken);
			gp.setLogin(profile.login);
			gp.setCompany(profile.company);
			gp.setLocation(profile.location);
			gp.setHireable(profile.hireable);
			gp.setBio(profile.bio);

			if(typeof(profile.email) !== 'undefined' && profile.email !== null) {
				gp.setEmail(profile.email)
			}

			user.setOwnedGithubProfile(gp);
			user.insert(function(err) {
				console.log('INSERTED');
				console.log(err);
				if (!err) {
					if(typeof(process.env.MAILCHIMP_API_KEY) !== 'undefined' && process.env.MAILCHIMP_API_KEY !== '' &&
						typeof(process.env.MAILCHIMP_LIST_URL) !== 'undefined' && process.env.MAILCHIMP_LIST_URL !== '' &&
						typeof(process.env.MAILCHIMP_AUTOMATION_URL) !== 'undefined' && process.env.MAILCHIMP_AUTOMATION_URL !== '') {
						var post_data = {
							"email_address": user.getEmail(),
							"status": "subscribed",
							"merge_fields": {
								"FULLNAME": profile.name
							}
						};
						var headers = {
							'Content-Type': 'application/json',
							'Accept': 'application/json',
							'Content-Length': Buffer.byteLength(JSON.stringify(post_data))
						};
						var r = https.request({
							hostname: 'us11.api.mailchimp.com',
							port: 443,
							path: process.env.MAILCHIMP_LIST_URL,
							method: 'POST',
							headers: headers,
							auth: 'copycat:' + process.env.MAILCHIMP_API_KEY
						}, function(res) {
							var body = '';
							res.setEncoding('utf8');
							res.on('data', function (chunk) {
								body += chunk;
							});
							res.on('end', function (b) {
								post_data = {
									email_address: email
								};
								var headers = {
									'Content-Type': 'application/json',
									'Accept': 'application/json',
									'Content-Length': Buffer.byteLength(JSON.stringify(post_data))
								};
								var r = https.request({
									hostname: 'us11.api.mailchimp.com',
									port: 443,
									path: '/3.0' + process.env.MAILCHIMP_AUTOMATION_URL,
									method: 'POST',
									headers: headers,
									auth: 'copycat:' + process.env.MAILCHIMP_API_KEY
								}, function(res) {
									var body = '';
									res.setEncoding('utf8');
									res.on('data', function (chunk) {
										body += chunk;
									});
									res.on('end', function (b) {
										if(res.statusCode == '204') {
											cb(null, user);
										} else {
											cb(null, user);
										}
									});
								});
								r.on('error', function(err) {
									cb(err, null);
								});
								r.write(JSON.stringify(post_data));
								r.end();
							});
						});
						r.on('error', function(err) {
							cb(err, null);
						});
						r.write(JSON.stringify(post_data));
						r.end();
					} else {
						cb(null, user);
					}
				} else {
					stripe.customers.del(customer.id, function(err, confirmation) {
						if(!err) {
							cb(err, null);
						} else {
							cb(err, null);
						}
					});
				}
			});
		} else {
			cb(err, null);
		}
	});
}

module.exports = UserController;
