package  
{
	import aze.motion.eaze;
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.simple.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	
	public class BattleState extends StarlingState
	{
		public var startTime:uint;
		
		public var levelbg		:CitrusSprite;

		private var lifeTime:Number;
		private var levelData:LevelData;
		private var dogs:Vector.<Dog>;
		private var cats:Vector.<Cat>;
		private var battles:Vector.<BattleObject>;
		private var numNodes:int;
		private var gameover:Boolean = false;
		private var win:Boolean = false;
		
		private var retryBtn:Button;
		private var defeatImage:Image;
		private var victoryImage:Image;
		
		public function BattleState() 
		{
			super();
			trace("Battle State Constructed");
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			box2D.gravity = new b2Vec2(0, 0);
			add(box2D);
			
			levelData = _ce.gameData[ Config.CURRENT_LEVEL ].clone();
			
			var bg:CitrusSprite = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			add(bg);
			
			//var bgPath:CitrusSprite = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.level_straight()) } );
			//bgPath.x = Main.STAGE_WIDTH - Image(bgPath.view).width;
			//add(bgPath);
			levelbg = levelData.getCitrusObject()
			add( levelbg );
			
			var sushi:CitrusSprite = new CitrusSprite("bg", { view:Resources.getView("Sushi") } );
			sushi.x = levelData.path[0].x - AnimationSequence(sushi.view).width * .5;
			sushi.y = levelData.path[0].y - AnimationSequence(sushi.view).height * .5;
			add(sushi);
			
			retryBtn = new Button(Texture.fromBitmap(new Resources.retryButton()));
			retryBtn.x = (Main.STAGE_WIDTH - retryBtn.width) * .5;
			retryBtn.y = Main.STAGE_HEIGHT * .65;
			addEventListener(Event.TRIGGERED, onRetryClicked);
			
			//defeatImage = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.defeat()) } );
			defeatImage = Image.fromBitmap(new Resources.defeat());
			defeatImage.x = 150;
			defeatImage.y = -defeatImage.height ;
			addChild(defeatImage);
			
			victoryImage = Image.fromBitmap(new Resources.victory());
			victoryImage.y = -victoryImage.height ;
			victoryImage.x = 150;
			addChild(victoryImage);
			
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
			
			//levelData = _ce.gameData[ Config.CURRENT_LEVEL ].clone();			
			
			//get how many total nodes are in the path
			numNodes = levelData.path.length;
			
			dogs = new Vector.<Dog>();
			battles = new Vector.<BattleObject>();

			
			lifeTime = 0;
			
			_ce.sound.playSound("battleMusic");
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
				
				if (levelData.spawns.length == 0 && dogs.length == 0) 
					win = true;
			}
			else 
			{
				if (gameover) 
					handleGameover();
			
				if (win) 
					handleWin();
			
				for (i = battles.length - 1; i >= 0; i--)
				{
					var battle:BattleObject = battles[i];
					battle.stopAnimation();
				}
			}
				
			//tempCat.update(timeDelta);
			
			lifeTime += timeDelta;
		}
		
		private function handleWin():void 
		{
			eaze(victoryImage).to( .5, { y:100 } );
			
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
			if ( win )
			{
				var levelNum:int = _ce.gameData[Config.CURRENT_LEVEL_NUM];
				levelNum++;
				_ce.gameData[Config.CURRENT_LEVEL_NUM] = levelNum;
			}
			
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
		
		override public function destroy():void
		{
			remove(levelbg);			
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.removeEventListeners();
		}
		
	}

}