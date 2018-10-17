var express = require('express');
var router = express.Router();
var spawnSync = require('child_process').spawnSync;
var spawn = require('child_process').spawn;

var RepoController = require('../../../controllers/RepoController');

var Repository = require('../../../models/copycat/Repository');
var Copyright = require('../../../models/copycat/Copyright');
var CopyrightSender = require('../../../models/copycat/CopyrightSender');

// This Set is a list of sha's currently being processed to prevent
// Multiple copyright submissions in case an account has multiple webhooks
var current_repos = new Set();

module.exports = function(gfs) {

/**
 *	/api/v1/repo
 */
router.route('/')
	.post(function(req, resp, next) {
		// console.log(req);
		// Make sure that request comes from github and is not the webhook "ping test"
		// Github will do a "ping test" by sending a zen attribute, so this should be null
		if(typeof(req.body.zen) === 'undefined') {
			if(!current_repos.has(req.body.after)) {
				current_repos.add(req.body.after);
				Copyright.getCopyrightByAfterSha(req.body.after, '_id', function(err, c) {
					if(!err) {
						if(!c.exists()) {
							Repository.getRepositoryByRepoId(req.body.repository.id, null, function(err, repository) {
								if(!err) {
									if(repository.exists()) {

										var repodir = __dirname + '/../../../../../repos/' + repository.getId() + '/' + repository.getRepoName() + '.git';
										spawnSync('git', ['fetch'], { cwd: repodir });
										spawnSync('git', ['symbolic-ref', 'HEAD', req.body.ref], { cwd: repodir });
										var msg = spawnSync('git', ['log', '-1', '--pretty=%B'], { cwd: repodir, encoding : 'utf8' }).stdout;
console.log('HAS MESSAGE OF: ' + msg);
										if(msg.indexOf('#copyright') > -1) {
											var zip = spawn('git', ['archive', '--format', 'zip', req.body.after], { cwd: repodir }).stdout;
											var ws = gfs.createWriteStream({
												filename: repository.getRepoName() + '_' + req.body.after + '.zip',
												content_type: 'application/zip',
												mode: 'w'
											});
											zip.pipe(ws);
											ws.on('close', function(file) {
												var copyright = new Copyright();
												copyright.setRef(req.body.ref);
												copyright.setBeforeSha(req.body.before);
												copyright.setAfterSha(req.body.after);
												copyright.setStatus(Copyright.StatusType.TRIGGERED);
												copyright.setFileObjectId(file._id.toString());
												copyright.setFileName(file.filename);
												copyright.setFileContentType(file.contentType);
												copyright.setFileLength(file.length);
												copyright.setFileChunkSize(file.chunkSize);
												copyright.setFileUploadDate(file.uploadDate);
												copyright.setFileMd5(file.md5);

												var sender = new CopyrightSender();
												sender.setLogin(req.body.sender.login);
												sender.setProfileId(req.body.sender.id);
												copyright.setOwnedCopyrightSender(sender);

												copyright.insert(function(err) {
													if(!err) {
														copyright.atomic(false);
														copyright.setTriggeringRepository(repository, function(err) {
															current_repos.delete(req.body.after);
															if(!err) {
																repository.getMonitoringUsers('email full_name', function(err, monitoring_users) {
																	if(!err) {
																		RepoController.sendEmail(copyright, monitoring_users, function(err) {
																			if(!err) {
																				resp.json({success:true, msg: 'Created Copyright'});
																			} else {
																				resp.json({success:false, msg: 'Error Sending Emails', error : err});
																			}
																		});
																	} else {
																		resp.json({success:false, msg: 'Error Getting Monitoring Users', error : err});
																	}
																});
															} else {
																resp.json({success:false, msg: 'Error Setting Triggering Repository', error : err});
															}
														});
													} else {
														resp.json({success:false, msg: 'Error Inserting Repository', error : err});
													}
												});
											});
										} else {
											resp.json({success:true, msg: 'Not a Copyright Event'});
										}
									} else {
										// TODO: Remove Webhook
										resp.json({success:true, msg: 'Repository Does Not Exist'});
									}
								} else {
									resp.json({success:false, msg: 'Error Retrieving Repository', error : err});
								}
							});
						}
					} else {
						resp.json({success:false, msg: 'Error Getting Copyright by After SHA', error : err});
					}
				});
			} else {
				resp.json({success:false, msg: 'Already Working this SHA: ' + req.body.after});
			}
		} else {
			resp.json({success:true, msg: 'Successfully Received Ping Webhook'});
		}
	});

	return router;
}
