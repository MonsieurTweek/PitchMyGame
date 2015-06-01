<div id="konami">
	
	<div id="gameArea">
		<canvas id="gameCanvas" width="438" height="600"></canvas>

		<div id="gameover"></div>
	</div>

	<div id="header" class="disable-select">
	</div>
{literal}
	<script>

		/**
		 * Global vars
		 **/

		var canvas, // Canvas
			CTX, // 2D context
			run, // Game Loop
			WIDTH, // Game area Width
			HEIGHT, // Game area Height
			input, // Input instance
			game, // instance of Game
			tuto, // instance of Tuto
			achievement, //instance of Achievement
			currentGameObject, // instance of a GameObject
			IM, // Image Manager instance
			soundLoader, // Sound Loader instance
			isLoadedImages,
			deltaTime, //independance framerate
			TIME; 
			
		canvas = $('#gameCanvas');
		CTX = canvas.getContext('2d');

		isLoadedImages = false;
		
		deltaTime = Date.now();
		// Uniquement si le canvas doit faire la taille de l'écran !
		/*WIDTH = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
		HEIGHT = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;*/
		
		// Uniquement si le canvas a une taille fixe
		WIDTH = 438;
		HEIGHT = 600;

		// Title Screens
		active_bg = 'wait';
	</script>

	<script>
		/**
		 * Démarrage du jeu
		 **/
		startGame = function()
		{
			log('*** START GAME ***');
			currentGameObject.init();
			run();
		}

		/**
		 * Ecran d'attente du jeu (après chargement des données)
		 **/
		waitingGame = function() {
			// Waiting for press any key
			if (interval(deltaTime, 1)) {
				if (active_bg == 'clean') {
					CTX.drawImage(clean_bg,0,0);
					active_bg = 'wait';

				}
				else {
					CTX.drawImage(wait_bg,0,0);
					active_bg = 'clean';
				}
				deltaTime = +new Date();
			}
		}
		
		/**
		 * Redémarrage du jeu (eg. suite à un game over)
		 **/
		restartGame = function() {
			
		}

		/**
		 * Initialisation des sons
		 **/
		initSounds = function()
		{
			
		}
		
		/****************** GAME LOOP *******************/
		/**
		 * Boucle de jeu
		 * @param temps de jeu
		 **/
		run = function(_t) {
			TIME = _t;
			// Si le jeu est en attente d'un input joueur
			if (currentGameObject.waiting === true) {
				// Crée un écouteur sur les évènements clavier/souris
				input.listen();
				// Au déclenchement d'un input
				if (input.keyboard.keypressed || input.mouse.click) {
					// Bloque la saisie d'input
					input.mouse.click = false;

					// Déclence le jeu
					currentGameObject.init();
				}
				// Sinon
				else {
					// Laisse l'écran d'attente
					waitingGame();
				}
			}
			// Si le jeu est en cours
			else if(currentGameObject.stop === false) {
				// Met à jour les sprites
				IM.update();

				// Met à jour le controller principal du jeu
				currentGameObject.update();

				// Nettoire l'écouteur d'évènement clavier/souris
				input.mouse.click = false;
			}
			// Si le jeu doit être nettoyer (eg. pour redémarrer)
			else if(currentGameObject.cleared === true) {
				currentGameObject.clear();
			}
			// Rappel la boucle de jeu
			requestAnimationFrame(run);
		};
		/*************** ENDING GAME LOOP ***************/
		
		// INSTANCES
		input = new Input({
            target : $('#gameArea')
        });
		game = new Game();
		IM = new IIG.ImageManager();
	
		// PATH
		var path = { img : "img/", sound : "sound/" };
	
        // Ajout des sprites du jeu qui doivent être chargés
        for (x in PlayerConf.sprites) {
        	IM.add(PlayerConf.sprites[x].img);
        }
        for (x in EnemyConf) {
        	for (y in EnemyConf[x].sprites)
        		IM.add(EnemyConf[x].sprites[y].img);
        }

		currentGameObject = game;
		
		// Sprites loaded ! Lancement du jeu !
		IM.loadAll(function() {
			setTimeout(function() {
				startGame();
				isLoadedImages = true;
			}, 2000);
		});

		startGame();
	</script>
{/literal}
</body>
</html>