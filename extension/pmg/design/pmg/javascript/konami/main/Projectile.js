/**
 * Projectile
 * Template of projectile entity
 **/
var Projectile = function() {
// CONFIGURATION ---
	this.conf = null;

	this.sprite = undefined;
	this.sprites = [];

	this.life = 1;
	this.toGarbage = false;
// --- END CONFIGURATION

// CORE ---
	this.init = function(typeOf, source) {
		log('*** INIT PROJECTILE : ' + typeOf + '***');
		this.conf = ProjectileConf[typeOf];

		for(property in this.conf) {
			this[property] = this.conf[property];
		}

		this.x = source.x + source.w/2 - this.w/2;
		this.y = source.y + source.h/2;
	}

	this.update = function() {
		// Actions
		this.doMove();
		
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
	this.doMove = function() {
		var p = this;

		// Rectiligne movement 
		p.y += p.speed;

		if(p.y > HEIGHT) {
			p.toGarbage = true;
		}
	}

// --- END ACTIONS

// UTILS ---
	this.debug = function() {
		CTX.fillStyle = "rgba(0,0,0,.5)";
		CTX.fillRect(this.x, this.y, this.w, this.h);
	}
// --- END UTILS
}