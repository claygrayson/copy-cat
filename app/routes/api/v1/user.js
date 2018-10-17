var express = require('express');
var crypto = require('crypto');
var router = express.Router();
var spawnSync = require('child_process').spawnSync;

var User = require('../../../models/copycat/User');
var Repository = require('../../../models/copycat/Repository');

var GithubController = require('../../../controllers/GithubController');

module.exports = function() {

/**
 *	/api/v1/user/copyrights
 */
router.route('/copyrights')
	.get(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			user.getActiveCopyrights(function(err, docs) {
				if(!err) {
					resp.json({success:true, msg: 'Successfully Retrieved Repositories', copyrights : docs});
				} else {
					resp.json({success:false, msg: 'Error Retrieving Active Copyrights', error : err});
				}
			});
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

/**
 *	/api/v1/user/organizations
 */
router.route('/dashboard')
	.get(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var ret = new Array();
			var user = req.user;
			if(user.exists()) {
				var gp = user.getOwnedGithubProfile();
				var gc = new GithubController(gp.getAccessToken());
				gc.getRepos(gp.getLogin(), function(err, repos) {
					var ret = new Array();

					var repo_ids = new Array();
					for(var i=0; i<repos.length; i++) {
						repo_ids.push(repos[i].id);
					}

					ret.push({
						id: 0,
						name: 'My Repositories',
						num_repos: repos.length,
						avatar_url: repos[0].owner.avatar_url,
						repo_ids: repo_ids
					});
					gc.getOrganizations(function(err, data) {
						if(!err) {
							for(var i=0; i<data.length; i++) {
								ret.push({
									id: data[i].id,
									name: data[i].login,
									num_repos: 0,
									avatar_url: data[i].avatar_url
								});
							}

							if(ret.length === 1) {
								getRepoStats(ret);
							} else {
								var cnt = 0;
								for(var i=1; i<ret.length; i++) {
									gc.getOrgRepos(ret[i].name, function(err, data) {
										if(!err) {
											if(data.length > 0) {
												for(var j=1; j<ret.length; j++) {
													var repoids = new Array();
													for(var k=0; k<data.length; k++) {
														if(ret[j].name === data[k].owner.login) {
															repoids.push(data[k].id + ' ' + data[k].name);
															ret[j].num_repos++;
														}
													}
													ret[j].repo_ids = repo_ids;
												}
											}
											if(++cnt === ret.length - 1) {
												getRepoStats(ret);
											}
										} else {
											resp.json({success:false, msg: 'Error Retrieving Repos for Organization: ' + ret[i].name, error : err});
										}
									});
								}
							}

							function getRepoStats(ret) {
								user.getRepoStats(ret, function(err, stats) {
									console.log(ret);
									if(!err) {
										resp.json({success:true, msg: 'Successfully Retrieved Repositories', data : stats});
									} else {
										resp.json({success:false, msg: 'Error Retrieving Monitored Repositories', error : err});
									}
								});
							}
						} else {
							resp.json({success:false, msg: 'Error Retrieving Organizations', error : err});
						}
					});

				});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

/**
 *	/api/v1/user/repos
 */
router.route('/repos')
	.get(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var ret = {};
			var user = req.user;
			if(user.exists()) {
				var gp = user.getOwnedGithubProfile();
				var gc = new GithubController(gp.getAccessToken());
				gc.getRepos(gp.getLogin(), function(err, repos) {
					ret['personal'] = new Array();
					for(var i=0; i<repos.length; i++) {
						ret['personal'].push({
							id: repos[i].id,
							name: repos[i].name,
							private: repos[i].private,
							description: repos[i].description,
							owner: {
								id: repos[i].owner.id,
								login: repos[i].owner.login,
								type: repos[i].owner.type
							}
						});
					}
					gc.getOrganizations(function(err, data) {
						if(!err) {
							ret['orgs'] = new Array();
							for(var i=0; i<data.length; i++) {
								ret['orgs'].push({login:data[i].login});
							}

							if(ret['orgs'].length === 0) {
								getMonitoredRepositories();
							} else {
								var cnt = 0;
								for(var i=0; i<ret['orgs'].length; i++) {
									gc.getOrgRepos(ret['orgs'][i].login, function(err, data) {
										if(!err) {
											if(data.length > 0) {
												for(var j=0; j<ret['orgs'].length; j++) {
													if(ret['orgs'][j].login === data[0].owner.login) {
														ret['orgs'][j].repos = new Array();
														for(var k=0; k<data.length; k++) {
															ret['orgs'][j].repos.push({
																id: data[k].id,
																name: data[k].name,
																private: data[k].private,
																description: data[k].description,
																owner: {
																	id: data[k].owner.id,
																	login: data[k].owner.login,
																	type: data[k].owner.type
																}
															});
														}
													}
												}
											}
											if(++cnt === ret['orgs'].length) {
												getMonitoredRepositories();
											}
										} else {
											resp.json({success:false, msg: 'Error Retrieving Repos for Organization: ' + o.login, error : err});
										}
									});
								}
							}

							function getMonitoredRepositories() {
								user.getMonitoredRepositories('-_id repo_id', function(err, monitored_repositories) {
									if(!err) {
										// Determine which personal repository is being monitored and attach appropriate flag
										if(ret.personal.length > 0) {
											for(var i=0; i<ret.personal.length; i++) {
												ret.personal[i].monitored = false;
												for(var j=0; j<monitored_repositories.length; j++) {
													if(ret.personal[i].id === monitored_repositories[j].repo_id) {
														ret.personal[i].monitored = true;
													}
												}
											}
										}
										// Determine which organization repository is being monitored and attach appropriate flag
										for(var i=0; i<ret.orgs.length; i++) {
											if(typeof(ret.orgs[i].repos) !== 'undefined') {
												for(var j=0; j<ret.orgs[i].repos.length; j++) {
													ret.orgs[i].repos[j].monitored = false;
													for(var k=0; k<monitored_repositories.length; k++) {
														if(ret.orgs[i].repos[j].id === monitored_repositories[k].repo_id) {
															ret.orgs[i].repos[j].monitored = true;
														}
													}
												}
											}
										}
										resp.json({success:true, msg: 'Successfully Retrieved Repositories', data : ret, user: req.user.obj()});
									} else {
										resp.json({success:false, msg: 'Error Retrieving Monitored Repositories', error : err});
									}
								});
							}
						} else {
							resp.json({success:false, msg: 'Error Retrieving Organizations', error : err});
						}
					});

				});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

/**
 *	/api/v1/user/monitor/:owner/:name
 * 1) Check if repo is already in the database
 * 2) If it does not exist, create Repository entry in database
 * 3) If the repo does not have a Webhook ID, create Webhook
 * 3) If it exists, add the user as a monitor of the repo
 * 4) Create a Repository object in the database
 * 5) Create a directory for the repository in the "repos" folder
 * 6) Create a mirror clone of the repository in the repo folder
 */
router.route('/monitor')
	.post(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			var create = false;
			if(user.exists()) {
				Repository.getRepositoryByRepoId(req.body.repo_id, null, function(err, repository) {
					if(!repository.exists()) {
						create = true;
						var secret = crypto.randomBytes(64).toString('hex');

						var repo = new Repository();
						repo.setRepoId(req.body.repo_id);
						repo.setRepoName(req.body.name);
						repo.setOwnerLogin(req.body.owner);
						repo.setWebhookSecret(secret);
						repo.insert(function(err) {
							if(!err) {
								monitor(repo);
							} else {
								resp.json({success:false, msg: 'Error Creating Repository in Database', error : err});
							}
						});
					} else {
						monitor(repository);
					}
				});

				function monitor(repo) {
					console.log('monitor(): ' + repo.getWebhookId());
					if(typeof(repo.getWebhookId()) === 'undefined' || repo.getWebhookId() === null || repo.getWebhookId() === 0) {
						var gp = user.getOwnedGithubProfile();
						var gc = new GithubController(gp.getAccessToken());
						gc.createWebhook(req.body.owner, req.body.name, {
							name : 'web',
							events: ['push','release'],
							active: true,
							config : {
								url: process.env.HOST + '/api/v1/repo',
								content_type: 'json',
								secret: repo.getWebhookSecret(),
								insecure_ssl: 0
							}
						}, function(err, data) {
							console.log(data);
							if(!err && data) {
								repo.setWebhookId(data.id);
								finalize(repo, gp);
							} else {
								resp.json({success:false, msg: 'Error Creating Webhook', error: err});
							}
						});
					} else {
						finalize(repo, gp);
					}
				}

				function finalize(repo, gp) {
					repo.atomic(false);
					repo.addMonitoringUser(user, function(err) {
						if(!err) {
							if(create) {
								var repodir = __dirname + '/../../../../../repos/' + repo.getId();
								spawnSync('mkdir', ['-p', repodir], { cwd: __dirname });
								spawnSync('git', ['clone', '--mirror', 'https://' + gp.getLogin() + ':' + gp.getAccessToken() + '@github.com/' + repo.getOwnerLogin() + '/' + repo.getRepoName()], { cwd: repodir });
							}
							resp.json({success:true, msg: 'Webhook Successfully Created'});
						} else {
							resp.json({success:false, msg: 'Error Adding Monitoring User to Repository', error : err});
						}
					});
				}
			} else {
				resp.json({success:false, msg: 'User Does Not Exist'});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

router.route('/unmonitor')
	.post(function (req, resp, next) {
		if(req.isAuthenticated()) {
			var user = req.user;
			if(user.exists()) {
				var gp = user.getOwnedGithubProfile();
				var gc = new GithubController(gp.getAccessToken());

				Repository.getRepositoryByRepoId(req.body.repo_id, null, function(err, repository) {
					if(repository.exists()) {
						var users = new Array();
						users.push(user);
						repository.removeMonitoringUsers(users, function(err) {
							if(!err) {
								repository.getNumberOfMonitoringUsers(function(err, num_monitoring_users) {
									if(num_monitoring_users == 0) {
										gc.deleteWebhook(req.body.owner, req.body.name, repository.getWebhookId(), function(err, data) {
											if(!err) {
												repository.setWebhookId(0);
												repository.update(function(err) {
													if(!err) {
														resp.json({success:true, msg: 'Webhook Successfully Unmonitored'});
													} else {
														resp.json({success:false, msg: 'Error Nullifying Webhook Id', error : err});
													}
												});
											} else {
												resp.json({success:false, msg: 'Error Removing Webhook', error : err});
											}
										});
									} else {
										resp.json({success:true, msg: 'Webhook Successfully Unmonitored'});
									}
								});
							} else {
								resp.json({success:false, msg: 'Error Removing Monitoring Users', error : err});
							}
						});
					} else {
						resp.json({success:true, msg: 'Repository does not exist'});
					}
				});
			} else {
				resp.json({success:false, msg: 'User Does Not Exist'});
			}
		} else {
			resp.json(401, {success:false, msg:'Not Authorized'});
		}
	});

	return router;
}
