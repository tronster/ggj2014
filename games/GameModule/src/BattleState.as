package  
{
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	
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
		
		private var retryBtn:ButtonGame;
		private var quitBtn:ButtonGame;
		private var defeatImage:Image;
		private var victoryImage:Image;
		private var box2D:Box2D;
		
		
		/// CTOR
		public function BattleState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			box2D 			= new Box2D("box2Dbattle");
			box2D.visible 	= Config.SHOW_BOX2D;
			box2D.gravity 	= new b2Vec2(0, 0);
			add(box2D);
			
			levelData = _ce.gameData[ Config.CURRENT_LEVEL ].clone();
			
			var bg:CitrusSprite = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			add(bg);

			var levelbg	:Sprite = levelData.getViewBackground();
			var levelbgSprite:CitrusSprite = new CitrusSprite("levelbg", { view: levelbg } );
			levelbgSprite.x = 192;
			add( levelbgSprite );
			
			var sushi:CitrusSprite = new CitrusSprite("bg", { view:Resources.getView("Sushi") } );
			sushi.x = levelData.path[0].x - AnimationSequence(sushi.view).width * .5;
			sushi.y = levelData.path[0].y - AnimationSequence(sushi.view).height * .5;
			add(sushi);
			
			retryBtn = new ButtonGame( "", onRetryClicked );
			retryBtn.x = (Main.STAGE_WIDTH / 2) - (retryBtn.width + 50);
			retryBtn.y = Main.STAGE_HEIGHT * .65;

			quitBtn = new ButtonGame( "Quit", onQuitClicked );
			quitBtn.x = (Main.STAGE_WIDTH / 2) + 50;
			quitBtn.y = Main.STAGE_HEIGHT * .65;
			
			
			//defeatImage = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.defeat()) } );
			defeatImage = Image.fromBitmap(new Resources.defeat());
			defeatImage.x = (Main.STAGE_WIDTH - defeatImage.width) * .5;
			defeatImage.y = -defeatImage.height ;
			addChild(defeatImage);
			
			victoryImage = Image.fromBitmap(new Resources.victory());
			victoryImage.y = -victoryImage.height ;
			victoryImage.x = (Main.STAGE_WIDTH - victoryImage.width) * .5;
			addChild(victoryImage);
			
			cats = _ce.gameData[Config.ACTIVE_CATS];
			for (var k:int = 0; k < cats.length; k++)
			{
				var cat:Cat = cats[k];
				cat.initForBattle();
				add( cat.playArt );
				add( cat.sensor  );
			}		
			
			//get how many total nodes are in the path
			numNodes = levelData.path.length;
			
			dogs = new Vector.<Dog>();
			battles = new Vector.<BattleObject>();
			
			lifeTime = 0;
			
			_ce.sound.playSound("goSfx");
			_ce.sound.playSound("battleMusic");
		}
		
		override public function destroy():void
		{
			super.destroy();
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.removeEventListeners();
		}
		
		override public function update(timeDelta:Number):void
		{
			var i:int; 		//used for first degree loops
			var battle:BattleObject;

			super.update(timeDelta);
			
			if (!gameover && !win)
			{
				//check if it's time for a dog to be created
				if (levelData.spawns.length >= 1 && levelData.spawns[0].time <= lifeTime)
				{
					var dogInfo:Spawn = levelData.spawns.shift();
					var tempDog:Dog = new Dog(dogInfo.dogType);
					tempDog.targetNode = levelData.path[numNodes - 1];	//starting node is last node in the list
					tempDog.init();
					add(tempDog.playArt);
					dogs.push(tempDog);
				}
				
				for (i = dogs.length - 1; i >= 0; i--)
				{
					var dog:Dog = dogs[i];
					dog.update(timeDelta);
					
					if (dog.reachedNode) 
						setNextNode(dog);
					
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
				}
				
				for (i = battles.length - 1; i >= 0; i--)
				{
					battle = battles[i];
					battle.update(timeDelta);
					
					if (!battle.isBattling)
					{
						battle.dispose(this);
						battles.splice(i, 1);
					}
				}
				
				if (levelData.spawns.length == 0 && dogs.length == 0)
				{
					win = true;
					_ce.sound.stopAllPlayingSounds();
					_ce.sound.playSound("catVictorySfx");
					stopAllAnimations();
				}
			}
			else 
			{
				if (gameover) 
					handleGameover();
			
				if (win) 
					handleWin();			
			}
			
			lifeTime += timeDelta;
		}
		
		/**
		 * Stop all necessary animations, typically for end of game
		 */
		private function stopAllAnimations():void 
		{
			for each(var cat:Cat in cats) cat.stopAnimations(); 
			for each(var dog:Dog in dogs) dog.stopAnimations(); 
			for each(var battleObj:BattleObject in battles) battleObj.stopAnimations(); 
		}
		
		private function handleWin():void 
		{
			victoryImage.y += 10;
			
			if (victoryImage.y > 100) 
				victoryImage.y = 100;
			
			retryBtn.text = "Next Yard";
			addChild(retryBtn);
			addChild(quitBtn);
		}
		
		private function handleGameover():void 
		{
			defeatImage.y += 10;
			
			if (defeatImage.y > 100)
				defeatImage.y = 100;
			
			retryBtn.text = "Try again";
			addChild(retryBtn);
			addChild(quitBtn);
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
		
		private function onQuitClicked(e:starling.events.Event):void
		{
			// TODO: Game over text or animation state.
			_ce.state = new ShellState();
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
						_ce.sound.stopAllPlayingSounds("dogWinsSfx");
						_ce.sound.playSound("dogWinsSfx");
						stopAllAnimations();
					}else {
						node = levelData.path[i - 1];
						dog.setNode(node);
					}
				}
			}
		}		
	}

}