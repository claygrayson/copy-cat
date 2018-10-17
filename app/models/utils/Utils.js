Function.prototype.rapidModelObjectInheritsFrom = function(parent) {
	if(parent.constructor == Function) {
		this.prototype = Object.create(parent.prototype);
		this.prototype.constructor = this;
		this.prototype.parent = parent.prototype;
	}
	for (var key in parent) {
		if ({}.hasOwnProperty.call(parent, key)) {
			this[key] = parent[key];
		}
	}
	return this;
}