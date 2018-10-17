var
  pkg =			require('./package.json'),
  async =		require('async'),
  beep =		require('beepbeep');
  browserify =	require('browserify'),
  del =			require('del'),
  gulp =		require('gulp'),
  coffeelint =	require('gulp-coffeelint'),
  concat =		require('gulp-concat'),
  env =			require('gulp-env'),
  html2js =		require('gulp-html2js'),
  insert =		require('gulp-insert'),
  jade =		require('gulp-jade'),
  livereload =	require('gulp-livereload'),
  minifyCss =	require('gulp-minify-css'),
  nodemon =		require('gulp-nodemon'),
  rename =		require('gulp-rename'),
  sass =		require('gulp-sass'),
  streamify =	require('gulp-streamify'),
  uglify =		require('gulp-uglify'),
  gutil =		require('gulp-util'),
  path =		require('path'),
  source =		require('vinyl-source-stream');

var products = {
  resources: {
	resources: {
	  './res/{fonts,html,img,sfx,js,css,dashboard}/**': './public/',
	  './bower_components/font-awesome/fonts/fontawesome-webfont.ttf': './public/fonts/',
	  './bower_components/font-awesome/fonts/fontawesome-webfont.svg': './public/fonts/',
	  './bower_components/font-awesome/fonts/fontawesome-webfont.woff': './public/fonts/',
	  './bower_components/font-awesome/fonts/fontawesome-webfont.woff2': './public/fonts/'
	},
	templates: {
		'./app/coffee/components/**/templates/*.jade': './public/js/'

	}
  },
  landing: {
	scss: {
		'./app/sass/landing.scss': './public/css/landing.css'
	},
	coffee: {
		'./app/coffee/landing.coffee': './public/js/landing.js'
	},
	deps: {
		"angular": "./bower_components/angular/angular.min.js",
		"angular-ui-router": "./bower_components/angular-ui-router/release/angular-ui-router.min.js",
		"angular-bootstrap": "./bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js",
		"angular-bootstrap-tpls": "./bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js",
		"bootstrap": "./bower_components/bootstrap-sass/assets/javascripts/bootstrap.min.js",
		"jquery": "./bower_components/jquery/dist/jquery.min.js"
	}
  },
  copyright: {
	scss: {
		'./app/sass/copyright.scss': './public/css/copyright.css'
	},
	coffee: {
		'./app/coffee/copyright.coffee': './public/js/copyright.js'
	},
	deps: {
		"angular": "./bower_components/angular/angular.js",
		"angular-ui-router": "./bower_components/angular-ui-router/release/angular-ui-router.js",
		"angular-bootstrap": "./bower_components/angular-bootstrap/ui-bootstrap.js",
		"angular-bootstrap-tpls": "./bower_components/angular-bootstrap/ui-bootstrap-tpls.js",
		"bootstrap": "./bower_components/bootstrap-sass/assets/javascripts/bootstrap.js",
		"jquery": "./bower_components/jquery/dist/jquery.js"
	}
  },
  dashboard: {
	scss: {
		'./app/sass/dashboard.scss': './public/css/dashboard.css'
	},
	coffee: {
		'./app/coffee/dashboard.coffee': './public/js/dashboard.js'
	},
	deps: {
		"modernizr": "./bower_components/modernizr/modernizr.custom.js",
		"jquery": "./bower_components/jquery/dist/jquery.js",
		"angular": "./bower_components/angular/angular.js",
		"angular-ui-router": "./bower_components/angular-ui-router/release/angular-ui-router.js",
		"angular-bootstrap-tpls": "./bower_components/angular-bootstrap/ui-bootstrap-tpls.js",
		"angular-route": "./bower_components/angular-route/angular-route.js",
		"angular-cookies": "./bower_components/angular-cookies/angular-cookies.js",
		"angular-messages": "./bower_components/angular-messages/angular-messages.js",
		"angular-animate": "./bower_components/angular-animate/angular-animate.js",
		"angular-touch": "./bower_components/angular-touch/angular-touch.js",
		"ngStorage": "./bower_components/ngstorage/ngStorage.js",
		"angular-ui-mask": "./bower_components/angular-ui-mask/dist/mask.js",
		"angular-ui-event": "./bower_components/angular-ui-event/dist/event.js",
		"angular-ui-validate": "./bower_components/angular-ui-validate/dist/validate.js",
		"angular-ui-indeterminate": "./bower_components/angular-ui-indeterminate/dist/indeterminate.js",
		"angular-ui-scrollpoint": "./bower_components/angular-ui-scrollpoint/dist/scrollpoint.js",
		"angular-ui-scroll": "./bower_components/angular-ui-scroll/dist/ui-scroll.js",
		"angular-ui-uploader": "./bower_components/angular-ui-uploader/dist/uploader.js",
		"angular-ui-utils": "./bower_components/angular-ui-utils/index.js",
		"angular-sanitize": "./bower_components/angular-sanitize/angular-sanitize.js",
		"angular-resource": "./bower_components/angular-resource/angular-resource.js",
		"angular-translate": "./bower_components/angular-translate/angular-translate.js",
		"angular-translate-loader-url": "./bower_components/angular-translate-loader-url/angular-translate-loader-url.js",
		"angular-translate-loader-static-files": "./bower_components/angular-translate-loader-static-files/angular-translate-loader-static-files.js",
		"angular-translate-storage-local": "./bower_components/angular-translate-storage-local/angular-translate-storage-local.js",
		"angular-translate-storage-cookie": "./bower_components/angular-translate-storage-cookie/angular-translate-storage-cookie.js",
		"ngTimeago": "./bower_components/ng-timeago/ngtimeago.js",
		"oclazyload": "./bower_components/oclazyload/dist/ocLazyLoad.js",
		"angular-loading-bar": "./bower_components/angular-loading-bar/build/loading-bar.js",
		"jquery.browser": "./bower_components/jquery.browser/dist/jquery.browser.js",
		"material-colors": "./bower_components/material-colors/dist/colors.js"
	}
  }
};

var browserify_helper = function (res, cb) {
	var b = browserify({debug: true})
		.transform('coffeeify')
		.add(res[0]);

		for(key in products[res[2]]['deps']) {
			if(key !== '__product__') {
				b.external(key);
			}
		}

	var stream = b.bundle()
		.on('error', function(e) {
			beep();
			gutil.log('\n\n')
			gutil.log('==================================='.red);
			gutil.log('Coffeescript Error'.underline.red);
			gutil.log(e.toString());
			gutil.log('===================================\n\n'.red);
			this.emit('end');
		})
		.pipe(source(path.basename(res[1])))
		.pipe(gulp.dest(path.dirname(res[1])))
		.pipe(streamify(uglify()))
		.pipe(rename({extname: '.min.js'}))
		.pipe(gulp.dest(path.dirname(res[1])));

	if (cb) {
		stream.on('end', cb);
	} else {
		return stream;
	}
};

var deps_helper = function (res, cb) {
	var b = browserify()
	.transform('browserify-shim');

	for(key in res) {
		if(key !== '__product__' && key !== 'angular-mocks') {
			b.require(res[key], {expose: key});
		}
	}

	var stream = b.bundle()
		.pipe(source(res['__product__'] + '.deps.js'))
		.pipe(gulp.dest('./public/js/'));
//		.pipe(streamify(uglify()))
//		.pipe(rename(res['__product__'] + '.deps.min.js'))
//		.pipe(gulp.dest('./public/js/'));

	if (cb) {
		stream.on('end', cb);
	} else {
		return stream;
	}
};

var get_product = function (product, fn) {
	var array = new Array();
	for(k in products) {
		for(key in products[k]) {
			if(product === 'deps' && key === 'deps') {
				products[k][key]['__product__'] = k;
				array.push(products[k][key]);
			} else if(key === product) {
				for(f in products[k][key]) {
					var tmp = new Array();
					tmp.push(f);
					tmp.push(products[k][key][f]);
					tmp.push(k);
					array.push(tmp);
				}
			}
		}
	}
	return array.map(fn);
};

gulp.task('clean', function (cb) {
	del(['./public/*'], cb);
});

//Generates both full and minified css files.  Source comments get stripped from minified.
gulp.task('sass', function (cb) {
	async.parallel(get_product('scss', function (scss) {
		return function(done) {
			gulp.src(scss[0])
			.pipe(sass({sourceComments: 'map'}))
			.pipe(rename(path.basename(scss[1])))
			.pipe(gulp.dest(path.dirname(scss[1])))
			.pipe(minifyCss())
			.pipe(rename({extname: '.min.css'}))
			.pipe(gulp.dest(path.dirname(scss[1])))
			.on('end', done);
		}
	}), cb);
});

//TODO: separate build artifacts, templates.js is only an intermediate...
gulp.task('templates', function (cb) {
	async.parallel(get_product('templates', function (tpl) {
		return function (done) {
			gulp.src([tpl[0]])
			.pipe(jade({
				locals: {}
			}))
			.on('error', function(e) {
				beep();
				gutil.log('\n\n')
				gutil.log('==================================='.red);
				gutil.log('Jade Error'.underline.red);
				gutil.log(e.toString());
				gutil.log('===================================\n\n'.red);
			})
			.pipe(html2js({
				outputModuleName: 'copycat.templates',
				base: './public/js/',
				// This rename function is for angular-foundation templates
				rename : function (modulePath) {
					var moduleName = modulePath.replace('../../app/coffee/components/', '');
					return moduleName;
				}
			}))
			.pipe(concat('templates.js'))
			.pipe(insert.prepend("var angular = require('angular');"))
			.pipe(gulp.dest(tpl[1]))
			.on('end', done);
		};
	}), cb);
});

gulp.task('coffeeify', ['templates'], function (cb) {
	async.parallel(get_product('coffee', function (res) {
		return function (done) {
			browserify_helper(res, done);
		}
	}), function () {
		del('./public/js/templates.js', cb);
	});
});

gulp.task('deps', function (cb) {
	async.parallel(get_product('deps', function (res) {
		return function (done) {
			deps_helper(res, done);
		}
	}), cb);
});

gulp.task('resources', function (cb) {
	var streams = get_product('resources', function (res) {
		return function (done) {
			gulp.src(res[0])
			.pipe(gulp.dest(res[1]))
			.on('end', done);
		}
	});
	async.parallel(streams, cb);
});

gulp.task('watch', function () {
	gulp.watch('./app/sass/**/*.{scss,sass}', ['sass']);
	gulp.watch('./app/coffee/components/**/templates/*.jade', ['templates', 'coffeeify']);
	gulp.watch('./app/coffee/**/*.coffee', ['coffeelint', 'coffeeify']);
	gulp.watch('./res/{fonts,html,img,sfx,js,css,dashboard}/**', ['resources']);
});

gulp.task('develop', ['sass', 'templates', 'coffeeify', 'deps', 'resources'], function () {
	env({
		vars: {
			ENV: "dev",
			HOST: "https://ossys.ngrok.io",
			PORT: "3000",
			SESSION_SECRET: "499d4452121ee94743fd5d0be61faff554039021",
			STRIPE_KEY: "sk_test_bZ6XYkPGHOqmeiHXTA4RNghN",
			GMAIL_PASSWORD: "dmcqlakntbpbikne",
			GITHUB_CLIENT_ID: "b5a08367c2d31a46200b",
			GITHUB_CLIENT_SECRET: "32171e1924e9cdd0f5d1ae667ceec4b988e38377",
			GITHUB_CALLBACK: "https://ossys.ngrok.io/api/v1/auth/github/callback",
			MAILCHIMP_API_KEY: "94fff90578b7e4a96aad8a1f8477ed66-us13",
			MAILCHIMP_LIST_URL: "/3.0/lists/e27542d1b3/members",
			MAILCHIMP_AUTOMATION_URL: ""
		}
	});
	livereload.listen();
	nodemon({
		script: 'app.js',
		ext: 'js coffee jade'
	}).on('restart', function() {
		setTimeout(function () {
			livereload.changed(__dirname);
		}, 500);
	});
});

gulp.task('coffeelint', function (cb) {
	return gulp.src('./app/coffee/**/*.coffee')
		.pipe(coffeelint())
		.pipe(coffeelint.reporter());
});

gulp.task('default', ['build', 'develop', 'watch']);
gulp.task('scss', ['sass']);
gulp.task('build', ['sass', 'templates', 'coffeeify', 'deps', 'resources']);
