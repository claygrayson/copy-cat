module.exports = function (app, passport, gfs) {
	app.use('/', require('./landing')());
	app.use('/dashboard', require('./dashboard')());
	app.use('/copyright', require('./copyright')());

/** API v1 **/
	if(process.env.ENV === 'dev' || process.env.ENV === 'test') {
		app.use('/api/v1/utils', require('./api/v1/utils')());
	}
	app.use('/api/v1/auth', require('./api/v1/auth')(passport));
	app.use('/api/v1/user', require('./api/v1/user')());
	app.use('/api/v1/repo', require('./api/v1/repo')(gfs));
	app.use('/api/v1/copyright', require('./api/v1/copyright')(gfs));
	app.use('/api/v1/admin', require('./api/v1/admin')());
	app.use('/api/v1/stripe', require('./api/v1/stripe')());
};