/**
 * PlayerManager
 * Manage player entities
 **/
var PlayerManager = function() {
	this.entities = [];

	this.init = function() {
		this.createOne();
	}

	this.update = function() {
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
				log('*** GARBAGE PLAYER ***');
			}
		}
	}

	this.createOne = function() {
		// Create a new player instance
		var player = new Player();
		// Initialize it
		player.init();
		// Add the instance to the entities array
		this.entities.push(player);
	}

	this.deleteOne = function(instance) {
		// Delete an instance of player
		for(var iE = 0, c = this.entities.length; iE < c; iE++) {
			if(this.entities[iE] === instance) {
				this.entities.remove(iE);
				c--;
			}
		}
	}

};