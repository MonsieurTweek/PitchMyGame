/**
 * EnemyManager
 * Manage Enemy entities
 **/
var EnemyManager = function() {
	this.entities = [];
	this.types = [];
	this.popDate = null;
	this.isPop = true;
	this.popType = null;

	this.init = function() {
		// Get different kinds of enemies
		for(name in EnemyConf) {
			this.types.push(name);
		}

		this.popDate = Date.now();
	}

	this.update = function() {
		this.createRandom();
		for(var iE = 0, c = this.entities.length; iE < c; iE++) {
			this.entities[iE].update();
		}

		this.garbage();
	}

	this.render = function() {
		for(var iE = 0, c = this.entities.length; iE < c; iE++) {
			this.entities[iE].render();
		}
	}

	this.garbage = function() {
		for(var iE = 0, cE = this.entities.length; iE < cE; iE++) {
			if(this.entities[iE].toGarbage == true) {
				this.entities.splice(iE, 1);
				cE--;
				log('*** GARBAGE ENEMY ***');
			}
		}
	}

	this.createRandom = function() {
		if(this.isPop == true) {
			this.popType = this.types.pickup();
			this.isPop = false;
		}

		var popDelay = EnemyConf[this.popType].popDelay;

		if(Date.now() > this.popDate + popDelay) {
			var cE = EnemyConf[this.popType].popNumber;
			for (var iE = 0; iE < cE; iE++) {
				this.createOne(this.popType);			
			};
			this.popDate = Date.now();
			this.isPop = true;
		}

	}

	this.createOne = function(type) {
		// Create a new enemy instance
		var enemy = new Enemy();
		// Initialize it
		enemy.init(type);
		// Add the instance to the entities array
		this.entities.push(enemy);
	}

};