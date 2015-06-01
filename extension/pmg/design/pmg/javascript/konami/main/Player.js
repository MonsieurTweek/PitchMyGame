/**
 * Player
 * Template of player entity
 **/
var Player = function() {

// CONFIGURATION ---
	this.conf = null;

	this.score = 0;
	this.combo = 1;

	this.sprite = undefined;
	this.sprites = [];

	this.gLife = null;
	this.gEnergy = null;

	this.currentProjectile = 'Laser';
	this.projectiles = [];
	this.projectilesEntities = [];

	this.fireDate = Date.now();
	this.refillDate = Date.now();
	this.stunDate = Date.now();
// --- END CONFIGURATION

// CORE ---
	this.init = function() {
		log('*** INIT PLAYER ***');
		this.conf = PlayerConf;

		for(property in this.conf) {
			this[property] = this.conf[property];
		}

		// Get different kinds of projectiles
		for(name in ProjectileConf) {
			this.projectiles.push(name);
		}

		// Init life gauge
		this.gLife = new Gauge();
		this.gLife.init('Life');
		// Init energy gaure
		this.gEnergy = new Gauge();
		this.gEnergy.init('Energy');

		// Init current values from max configuration
		this.life = this.lifeMax;
		this.energy = this.energyMax;
	}

	this.update = function() {
		// Actions
		this.doMove();
		this.doFire();
		this.doRefill();

		// Update projectilesEntities
		for(var iP = 0, cP = this.projectilesEntities.length; iP < cP; iP++) {
			this.projectilesEntities[iP].update();
		}

		// Update gauges
		this.gLife.update();
		this.gEnergy.update();

		// Animate
		this.animate();

		// Delete elements
		this.garbage();
	}

	this.animate = function() {

	}

	this.render = function() {
		if(typeof this.sprite !== "undefined") {
			// Render sprites in the appropriate direction
			IM.drawImage(CTX, this.sprite, this.x, this.y);
		}

		// Render projectilesEntities
		for(var iP = 0, cP = this.projectilesEntities.length; iP < cP; iP++) {
			this.projectilesEntities[iP].render();
		}

		// Render gauges
		this.gLife.render();
		this.gEnergy.render();

		// Render weapon
		// CTX.fillStyle = "#000";
		// CTX.font = "10px Arial";
		// CTX.textAlign = 'left';
		// CTX.fillText(this.currentProjectile, 10, 50);

		// Render score
		CTX.fillStyle = "rgba(255,255,255,"+(this.combo/10)+")";
		CTX.font = "30px Arial";
		CTX.textAlign = 'center';
		CTX.fillText(this.score, WIDTH/2, HEIGHT/2);

		if(this.hasDebug === true) {
			this.debug();
		}

		this.renderInvader();
	}

	this.garbage = function() {
		for(var iP = 0, cP = this.projectilesEntities.length; iP < cP; iP++) {
			if(this.projectilesEntities[iP].toGarbage == true) {
				this.projectilesEntities.splice(iP, 1);
				cP--;
				log('*** GARBAGE PROJECTILE ***');
			}
		}
	}
// --- END CORE

// ACTIONS --- 
	this.doMove = function() {
		deltaTime = ( Date.now() - deltaTime ) / 1000;
		var p = this;

		// gauche
		if (input.keyboard.left) {
			if (p.x - p.speed * deltaTime > 0 ) p.x -= p.speed * deltaTime;
		}

		// droite
		if (input.keyboard.right) {
			if (p.x + p.w + p.speed * deltaTime < WIDTH) p.x += p.speed * deltaTime;
		}

		deltaTime = Date.now();
	}

	this.doChangeProjectile = function(type) {
		if(this.projectiles.hasValue(type)) {
			this.currentProjectile = type;
		}
	}

	this.doFire = function() {
		if (input.keyboard.space && 
			Date.now() > this.fireDate + this.fireDelay &&
			this.energy > this.energyMax/10 ) 
		{
			var type = this.projectiles.pickup();
			var projectile = new Projectile();

			projectile.init(this.currentProjectile, this);
			this.projectilesEntities.push(projectile);

			this.fireDate = Date.now();

			if(this.energy - projectile.energy > 0) {
				this.energy -= projectile.energy;
				this.gEnergy.doResize(this.energy, this.energyMax);
			}
			else {
				this.energy = 0;
			}
		}
	}

	this.doRefill = function() {
		if(	Date.now() > this.refillDate + this.refillDelay &&
			Date.now() > this.stunDate + this.stunDelay &&
			this.energy < this.energyMax) 
		{
			this.energy ++;
			this.gEnergy.doResize(this.energy, this.energyMax);

			this.refillDate = Date.now();
		}
	}

	this.doHit = function(enemy) {

		this.combo = 1;

		// Protect life with energy
		if(this.energy > 0) {
			this.energy -= enemy.life;
			this.gEnergy.doResize(this.energy, this.energyMax);
		}
		// Decrement life
		else if(this.life > 0) {
			this.life --;
			this.gLife.doResize(this.life, this.lifeMax);
		}
		// Destroy player
		else {
			log('*** GAME OVER ***');
		}

		if(this.energy <= 0) {
			this.energy = 0;
			this.gEnergy.doResize(this.energy, this.energyMax);

			this.stunDate = Date.now();
		}
	}

	this.doScore = function(enemy) {
		this.combo ++;

		this.score += Math.round(enemy.life * this.combo / enemy.w * enemy.speed * 10);
	}
// --- END ACTIONS

// UTILS ---
	this.debug = function() {
		CTX.fillStyle = "rgba(0,0,0,.1)";
		CTX.fillRect(this.x, this.y, this.w, this.h);
	}

	this.renderInvader = function() {
		CTX.fillStyle = "#000";

		var s = 5;

		var l = []
		l[0] = [0,0,1,0,0,0,0,0,1,0,0];
		l[1] = [0,0,0,1,0,0,0,1,0,0,0];
		l[2] = [0,0,1,1,1,1,1,1,1,0,0];
		l[3] = [0,1,1,0,1,1,1,0,1,1,0];
		l[4] = [1,1,1,1,1,1,1,1,1,1,1];
		l[5] = [1,0,1,1,1,1,1,1,1,0,1];
		l[6] = [1,0,1,0,0,0,0,0,1,0,1];
		l[7] = [0,0,0,1,1,0,1,1,0,0,0];

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