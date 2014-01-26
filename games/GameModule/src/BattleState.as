package  
{
	import aze.motion.eaze;
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.simple.Sensor;
	import citrus.physics.box2d.Box2D;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class BattleState extends StarlingState
	{
		public var startTime:uint;
		
		private var lifeTime:Number;
		private var levelData:LevelData;
		private var dogs:Vector.<Dog>;
		private var cats:Vector.<Cat>;
		private var battles:Vector.<BattleObject>;
		private var numNodes:int;
		private var gameover:Boolean = false;
		private var win:Boolean = false;
		
		private var retryBtn:Button;
		private var defeatImage:CitrusSprite;
		private var victoryImage:CitrusSprite;
		
		public function BattleState() 
		{
			super();
			trace("Battle State Constructed");
		}
		
		
		override public function initialize():void
		{
			super.initialize();
			
			var bg:CitrusSprite = new CitrusSprite("bg");
			bg.view = Texture.fromBitmap(new Resources.bg());
			add(bg);
			
			var bgGrass:CitrusSprite = new CitrusSprite("bgGrass", { x:192, view:Image.fromBitmap(new Resources.bg()) } );
			add( bgGrass );
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			box2D.gravity = new b2Vec2(0, 0);
			add(box2D);
			
<<<<<<< HEAD
			retryBtn = new Button(Resources.getAtlas("temp_sheet").getTexture("replay_idle_button"));
			retryBtn.x = 480;
			retryBtn.y = 500;
			addEventListener(Event.TRIGGERED, onRetryClicked);
			
			defeatImage = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.defeat()) } );
			defeatImage.x = 150; 
			
			victoryImage = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.defeat()) } );
			victoryImage.x = 150;
			
=======
			/* ??TRON remove:
			//levelInfo = LevelData(_ce.gameData).clone();
>>>>>>> 9b61a21ec6d6c495e53bc996c0b4aec96e61bbaf
			levelData = new LevelData();
			
			//hard code spawns
			var tempSpawn:Spawn;
			for (var i:int = 0; i < 1; i++)
			{
				tempSpawn = new Spawn(1, (i + 1));	//time to spawn is 1 second intervals
				levelData.spawns.push(tempSpawn);
<<<<<<< HEAD
			}
			//levelData = _ce.gameData[ Config.CURRENT_LEVEL ].clone();
			
			cats = _ce.gameData[Config.ACTIVE_CATS];
			//cats = new Vector.<Cat>();
			for (var k:int = 0; k < cats.length; k++)
			{
				//var cat:Cat = new Cat(1);
				var cat:Cat = cats[k];
				//cat.x = Math.random() * (Main.STAGE_WIDTH - 192) + 192;
				//cat.y = Math.random() * (Main.STAGE_HEIGHT);
				cat.initForBattle();
				add(cat.playArt);
				add(cat.sensor);
			}
			
=======
			}*/
			levelData = _ce.gameData[ Config.CURRENT_LEVEL ].clone();
>>>>>>> 9b61a21ec6d6c495e53bc996c0b4aec96e61bbaf
			
			/*
			//hard code nodes
			var tempNode:Node = new Node();
			tempNode.x = 192;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = 250;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = 250;
			tempNode.y = stage.stageHeight * .1;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = stage.stageWidth * .75;
			tempNode.y = stage.stageHeight * .1;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = stage.stageWidth * .75;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			//start node
			tempNode = new Node();
			tempNode.x = stage.stageWidth;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			*/
			
			
			//get how many total nodes are in the path
			numNodes = levelData.path.length;
			
			dogs = new Vector.<Dog>();
			battles = new Vector.<BattleObject>();
			
			/*tempCat = new Cat(1);
			tempCat.x = Main.STAGE_WIDTH * .5;
			tempCat.y = Main.STAGE_HEIGHT * .5;
			tempCat.init();
			add(tempCat.playArt);
			add(tempCat.sensor);*/
			
			lifeTime = 0;
		}
		
		override public function update(timeDelta:Number):void
		{
			var i:int; 		//used for first degree loops
			
			if (!gameover && !win)
			{
				super.update(timeDelta);
			
				//check if it's time for a dog to be created
				if (levelData.spawns.length >= 1 && levelData.spawns[0].time <= lifeTime)
				{
					var dogInfo:Spawn = levelData.spawns.shift();
					var tempDog:Dog = new Dog(dogInfo.dogType);
					tempDog.targetNode = levelData.path[numNodes - 1];	//last node in the list
					tempDog.init();
					add(tempDog.playArt);
					dogs.push(tempDog);
				}
				
				for (i = dogs.length - 1; i >= 0; i--)
				{
					var dog:Dog = dogs[i];
					dog.update(timeDelta);
					
					if (dog.reachedNode) setNextNode(dog);
					
					if (!dog.isActive) 
					{
						dog.destroy();
						dogs.splice(i, 1);
					}
				}
				for (i = cats.length - 1; i >= 0; i--)
				{
					var cat:Cat = cats[i];
					cat.update(timeDelta);
					if(i == 0) trace(cat.x, cat.y, cat.playArt.x, cat.playArt.y, cat.playArt.visible);
				}
				
				for (i = battles.length - 1; i >= 0; i--)
				{
					var battle:BattleObject = battles[i];
					battle.update(timeDelta);
					
					if (!battle.isBattling)
					{
						battle.dispose(this);
						battles.splice(i, 1);
					}
				}
			}else {
				if (gameover) handleGameover();
				
				if (win) handleWin();
			}
			
			//tempCat.update(timeDelta);
			
			lifeTime += timeDelta;
		}
		
		private function handleWin():void 
		{
			eaze(victoryImage).to( 1.1, { y:100 } );
			
			addChild(retryBtn);
			trace("You Lose");
		}
		
		private function handleGameover():void 
		{
			eaze(defeatImage).to( 1.1, { y:100 } );
			
			addChild(retryBtn);
			trace("You Lose");
		}
		
		private function onRetryClicked(e:Event):void 
		{
			_ce.state = new EditState();
		}
		
		public function addBattleObject(battle:BattleObject):void 
		{
			battles.push(battle);
		}
		
		private function setNextNode(dog:Dog):void 
		{
			for (var i:int = 0; i < levelData.path.length; i++)
			{			
				var node:Node = levelData.path[i];
				if (dog.targetNode == node)
				{
					if (i == 0) 
					{
						gameover = true;
					}else {
						node = levelData.path[i - 1];
						dog.setNode(node);
					}
				}
			}
		}
	}

}