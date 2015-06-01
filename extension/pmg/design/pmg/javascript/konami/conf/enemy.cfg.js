/**
 * EnemyConf
 * Configuration for object Enemy
 **/
 var EnemyConf = {
 	'Fighter' : {
 		hasDebug : false,
 		x : null,
 		getX : function(){ 
 			var side = Math.round(rand(0, 1)); 
 			return (rand(25, WIDTH/4) * side) + (rand(WIDTH/4*3, WIDTH-25) * (1 - side));
 		},
		y : HEIGHT,
		w : 25,
		h : 25,
		speed : 1,
		life : 5,
		popNumber : 2,
		popDelay : 1500,
		matrice : [	[0,0,1,0,0],
					[0,1,1,1,0],
					[0,1,1,1,0],
					[1,1,1,1,1],
					[0,1,0,1,0]
				  ]
 	},
 	'Cruser' : {
 		hasDebug : false,
 		x : null,
 		getX : function(){ 
 			return rand(WIDTH/4, WIDTH/4*3);
 		},
		y : HEIGHT,
		w : 55,
		h : 30,
		speed : .5,
		life : 15,
		popNumber : 1,
		popDelay : 3000,
		matrice : [	[0,0,0,0,0,1,0,0,0,0,0],
					[0,0,0,0,1,1,1,0,0,0,0],
					[0,0,1,1,1,1,1,1,1,0,0],
					[0,1,1,1,1,1,1,1,1,1,0],
					[0,0,1,1,1,0,1,1,1,0,0],
					[0,0,0,1,0,0,0,1,0,0,0]
				  ]
 	}
 };