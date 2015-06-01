/**
 * Gauge
 * Template of gauge entity
 **/
var Gauge = function() {

// CONFIGURATION ---
	this.conf = null;

	this.sprite = undefined;
	this.sprites = [];

// --- END CONFIGURATION

// CORE ---
	this.init = function(typeOf) {
		log('*** INIT GAUGE : ' + typeOf + '***');
		this.conf = GaugeConf[typeOf];

		for(property in this.conf) {
			this[property] = this.conf[property];
		}
	}

	this.update = function() {
		// Animate
		this.animate();
	}

	this.animate = function() {
	}

	this.render = function() {
		if(typeof this.sprite !== "undefined") {
			// Render sprites in the appropriate direction
			IM.drawImage(CTX, this.sprite, this.x, this.y);
		}

		if(this.hasDebug === true) {
			this.debug();
		}
	}
// --- END CORE

// ACTIONS --- 
	this.doResize = function(value, max) {
		this.w = 100 * value / max;
	}
// --- END ACTIONS

// UTILS ---
	this.debug = function() {
		CTX.fillStyle = this.color;
		CTX.fillRect(this.x, this.y, this.w, this.h);
	}
// --- END UTILS

};