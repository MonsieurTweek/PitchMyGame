/**
 * Game
 * Manage game mecanics and managers
 **/
var Game = function() {
	// Game objects
	this.mEnemy = null;
	this.mPlayer = null;

	// Game state 
	this.waiting = null;
	this.stop = null;
	this.gameover = false;

	this.score = 0;

	this.init = function() {
		log('*** INIT GAME ***');
		this.mEnemy = new EnemyManager();
		this.mEnemy.init();
		this.mPlayer = new PlayerManager();
		this.mPlayer.init();

		this.stop = false;
		this.waiting = false;
	}

	this.update = function() {
		// Listen events from keyboard and mouse
		input.listen();
		
		this.mEnemy.update();
		this.mPlayer.update();

		this.render();

		this.getCollision();
	}

	this.render = function() {
		// Render background
		drawRect(CTX, 'rgba(248,110,3,.3)', 0, 0, WIDTH, HEIGHT);

		this.mEnemy.render();
		this.mPlayer.render();

		if(this.gameover == true) {
			CTX.font = "30px Arial";
			CTX.textAlign = 'center';
			CTX.fillStyle = "#000";

			CTX.fillText("GAME OVER", WIDTH/2, HEIGHT/4);

			CTX.font = "20px Arial";
			CTX.fillText("PRESS F5 TO RESTART", WIDTH/2, HEIGHT/4 + 30);

			CTX.fillText("SCORE : "+this.score, WIDTH/2, HEIGHT/2);
		}
	}

	this.currentPlayer = function() {
		return this.mPlayer.entities[0];
	}

	this.getCollision = function() {
		// Get vertical limit to players
		var limitY = PlayerConf.y + PlayerConf.h;

		// Enemies vs Players
		for(var iE = 0, cE = this.mEnemy.entities.length; iE < cE; iE++) {
			// Get alias to entity
			var enemy = this.mEnemy.entities[iE];
			// Test vertical proximity between enemy and players
			if(enemy.y < limitY) {
				// Test horizontal position between enemy and players
				for(var iP = 0, cP = this.mPlayer.entities.length; iP < cP; iP++) {
					var player = this.mPlayer.entities[iP];
					if(collide(enemy, player) == true) {
						// Impact on player
						player.doHit(enemy);
						// Destroy enemy
						enemy.toGarbage = true;
					}
				}
			}
		}

		// Players projectiles vs Enemies
		for(var iP = 0, cP = this.mPlayer.entities.length; iP < cP; iP++) {
			// Get alias to entity
			var player = this.mPlayer.entities[iP];
			for(var iPP = 0, cPP = player.projectilesEntities.length; iPP < cPP; iPP++) {
				var projectile = player.projectilesEntities[iPP];
				// Test horizontal position between enemy and players
				for(var iE = 0, cE = this.mEnemy.entities.length; iE < cE; iE++) {
					var enemy = this.mEnemy.entities[iE];
					if(collide(projectile, enemy) == true) {
						// Score
						player.doScore(enemy);
						// Destroy projectile
						projectile.toGarbage = true;
						// Destroy enemy
						enemy.toGarbage = true;
					}
				}
			}
		}

		var playerLeft = 0
		for(var iP = 0, cP = this.mPlayer.entities.length; iP < cP; iP++) {
			// Get alias to entity
			var player = this.mPlayer.entities[iP];
			if(player.life > 0) {
				playerLeft ++;
				break;
			}
		}

		if(playerLeft == 0) {
			this.gameOver();
		}
	}

	this.gameOver = function() {
		var currentPlayer = this.currentPlayer();

		if(typeof currentPlayer == "undefined") {
			return;
		}
		this.score = currentPlayer.score;

		for(var iP = 0, cP = this.mPlayer.entities.length; iP < cP; iP++) {
			// Get alias to entity
			var player = this.mPlayer.entities[iP];
			for(var iPP = 0, cPP = player.projectilesEntities.length; iPP < cPP; iPP++) {
				// Get alias to entity
				var projectile = player.projectilesEntities[iPP];
				// Destroy projectile
				projectile.toGarbage = true;
			}
			// Destroy player
			player.toGarbage = true;
		}

		this.gameover = true;
	}

};
