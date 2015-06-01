/**
 * Functions.js
 **/

if (!window.requestAnimationFrame) {
	window.requestAnimationFrame = (function() {
		return window.webkitRequestAnimationFrame ||
				window.mozRequestAnimationFrame ||
				window.oRequestAnimationFrame ||
				window.msRequestAnimationFrame ||
				function (callback, elements) {
					window.setTimeout(callback, 1000/40);
				}
	})();
}

// console.log shortcut
function log(message) {
	return console.log(message);
}

// console.warn shortcut
function warn(message) {
	return console.warn(message);
}

// querySelectorAll shortcut
function $(selector) {
	var qsa = document.querySelectorAll(selector);
	return (qsa.length === 1 ? qsa[0] : qsa);
}

// Print something in the HTML
function debug(message) {
	var debug = document.querySelector('#debug');
	if (!debug) {
		debug = document.createElement('div');
		debug.setAttribute('id', 'debug');
		document.body.appendChild( debug );
	}

	debug.innerText = message;
}

// Compute a random value between 'a' and 'b'
function rand(a, b) {
	return a + Math.random() * (b - a);
}

// Détermine la distance entre 2 points
function distance(a, b){
	var distance = Math.sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y));
	return distance;
}

// Detect collision between two objects 'a' and 'b'
// Assuming both 'a' and 'b' have x/y/w/h properties
function collide(a, b) {
	if (a == undefined || b == undefined)
		return false;

	if(typeof a.w === "undefined" || typeof a.h === "undefined" || typeof b.w === "undefined" || typeof b.h === "undefined")
		return false;

	return !(b.x >= a.x + a.w // Trop à droite
			|| b.x + b.w <= a.x // Trop à gauche
			|| b.y >= a.y + a.h // Trop en bas
			|| b.y + b.h <= a.y) // Trop en haut
}

// Pickup a random value into an Array
Array.prototype.pickup = Array.prototype.pickup || function() {
	return this[ Math.floor(Math.random()*this.length) ];
}

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

Array.prototype.hasValue = function(needle) {
    var length = this.length;
    for(var i = 0; i < length; i++) {
        if(this[i] == needle) return true;
    }
    return false;
}

// Teste si un interval est passé
function interval(time, interval) {
	return (+new Date() - time) / 1000 > interval;
}

/* Graphics */
// Draw rectangle
function drawRect(context,color,x,y,width,height) {
	context.fillStyle = color;
	context.fillRect(x, y, width, height);
}

function lineDistance( point1, point2 ) {
  var xs = 0;
  var ys = 0;
 
  xs = point2.x - point1.x;
  xs = xs * xs;
 
  ys = point2.y - point1.y;
  ys = ys * ys;
 
  return Math.sqrt( xs + ys );
}

function getIMName(src) {
	return src.split('.')[0];
}
