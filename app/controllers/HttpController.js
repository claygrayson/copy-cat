var https = require('https');

function HttpController(host, port, default_headers) {
	if (!(this instanceof HttpController)) {
		throw new TypeError("HttpController constructor cannot be called as a function.");
	}

	this.host = host;
	this.port = port;
	this.default_headers = default_headers;
}

module.exports = HttpController;

HttpController.prototype.request = function(method, path, params, data, return_code, content_type, accept_type, cb, pipe) {
	var m = '';
	switch(method) {
		case HttpController.MethodType.GET:
			m = 'GET';
			break;
		case HttpController.MethodType.POST:
			m = 'POST';
			break;
		case HttpController.MethodType.DELETE:
			m = 'DELETE';
			break;
		default:
			m = 'GET';
			break;
	}
	var headers = {};
	switch(accept_type) {
		case HttpController.AcceptType.JSON:
			headers['Accept'] = 'application/json';
			break;
		case HttpController.AcceptType.PDF:
			headers['Accept'] = 'application/pdf';
			break;
		default:
			headers['Accept'] = 'application/json';
			break;
	}
	switch(content_type) {
		case HttpController.ContentType.JSON:
			headers['Content-Type'] = 'application/json';
			break;
		case HttpController.ContentType.X_WWW_FORM_URLENCODED:
			headers['Content-Type'] = 'application/x-www-form-urlencoded';
			break;
		case HttpController.ContentType.MULTIPART_FORM_DATA:
			headers['Content-Type'] = '';
			break;
		case HttpController.ContentType.HTML:
			headers['Content-Type'] = '';
			break;
		default:
			headers['Content-Type'] = 'application/x-www-form-urlencoded';
			break;
	}
	var p = '';
	if(params !== null) {
		p += '?';
		var cnt = 0;
		Object.keys(params).forEach(function(key) {
			if(cnt > 0) {
				p += '&'
			}
			d += encodeURIComponent(key) + '=' + encodeURIComponent(params[key]);
			cnt++;
		});
	}
	var d = null;
	if(data !== null && method === HttpController.MethodType.POST && content_type === HttpController.ContentType.JSON) {
		d = JSON.stringify(data);
	} else if(data !== null && method === HttpController.MethodType.POST) {
		d = '';
		var cnt = 0;
		Object.keys(data).forEach(function(key) {
			if(cnt > 0) {
				d += '&'
			}
			d += encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
			cnt++;
		});
	} else if(data !== null && method === HttpController.MethodType.GET) {
		if(p === '') {
			p += '?';
		}
		var cnt = 0;
		Object.keys(data).forEach(function(key) {
			if(cnt > 0) {
				p += '&'
			}
			p += encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
			cnt++;
		});
	}
	if(d !== null && method === HttpController.MethodType.POST) {
		headers['Content-Length'] = Buffer.byteLength(d);
	}
	var _this = this;
	Object.keys(this.default_headers).forEach(function(key) {
		headers[key] = _this.default_headers[key];
	});
	console.log('HOST: ');
	console.log(this.host);
	console.log('PATH: ');
	console.log(path);
	console.log('HEADERS: ');
	console.log(headers);
	console.log('METHOD: ');
	console.log(m);
	var req = https.request({
		hostname: this.host,
		port: this.port,
		path: path + p,
		method: m,
		headers: headers
	}, function(res) {
		var body = '';
		if(typeof(pipe) === 'undefined' || !pipe) {
			res.setEncoding('utf8');
		}
		res.on('data', function (chunk) {
			if(typeof(pipe) !== 'undefined' && pipe) {
				pipe.write(chunk);
			} else {
				body += chunk;
			}
		});
		res.on('end', function (b) {
			console.log(body);
			if(res.statusCode != return_code) {
				cb({message:'Did not receive ' + return_code + ' status, instead received: ' + res.statusCode, status: res.statusCode}, null);
			} else {
				if(body !== '') {
					if(accept_type === HttpController.AcceptType.JSON) {
						cb(null, JSON.parse(body));
					} else {
						cb(null, body);
					}
				} else {
					cb(null, null);
				}
			}
		});
	});
	req.on('error', function(err) {
		cb(err, null);
	});
	if(d !== null) {
		req.write(d);
	}
	// console.log(req);
	req.end();
};

HttpController.MethodType = Object.freeze({
	GET : 0,
	POST : 1,
	DELETE : 2
});

HttpController.AcceptType = Object.freeze({
	JSON : 0,
	PDF : 1
});

HttpController.ContentType = Object.freeze({
	JSON : 0,
	X_WWW_FORM_URLENCODED : 1,
	MULTIPART_FORM_DATA: 2,
	HTML: 3
});