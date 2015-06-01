/**
 * Enemy
 * Template of enemy entity
 **/
var Enemy = function() {

// CONFIGURATION ---
	this.conf = null;

	this.sprite = undefined;
	this.sprites = [];
// --- END CONFIGURATION

// CORE ---
	this.init = function(typeOf) {
		log('*** INIT ENEMY : ' + typeOf + '***');
		this.conf = EnemyConf[typeOf];

		for(property in this.conf) {
			this[property] = this.conf[property];
		}

		this.x = this.getX();
	}

	this.update = function() {
		this.doMove();

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

		this.renderShip();
	}
// --- END CORE

// ACTIONS --- 
	this.doMove = function() {
		this.y -= this.speed;

		if(this.y < -this.h) {
			this.toGarbage = true;
		}
	}
// --- END ACTIONS
	
// UTILS ---
	this.debug = function() {
		CTX.fillStyle = "rgba(255,255,255,1)";
		CTX.fillRect(this.x, this.y, this.w, this.h);
	}

	this.renderShip = function() {
		CTX.fillStyle = "#FFF";

		var s = 5;

		var l = this.matrice;

		for(var iL = 0, cL = l.length; iL < cL; iL++) {
			var line = l[iL];
			for(var iC = 0, cC = line.length; iC < cC; iC++) {
				var col = line[iC];
				if(col == 1) {
					CTX.fillRect(this.x + (iC*s), this.y + (iL*s), s, s);
				}
			}
		}

	}
// --- END UTILS

};