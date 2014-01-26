package  
{
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.simple.Sensor;
	import citrus.physics.box2d.Box2D;
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
		private var numNodes:int;
		private var gameover:Boolean = false;
		
		private var tempCat:Cat;
		
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
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			box2D.gravity = new b2Vec2(0, 0);
			add(box2D);
			
			//levelInfo = LevelData(_ce.gameData).clone();
			levelData = new LevelData();
			
			//hard code spawns
			var tempSpawn:Spawn;
			for (var i:int = 0; i < 1; i++)
			{
				tempSpawn = new Spawn(1, (i + 1));	//time to spawn is 1 second intervals
				levelData.spawns.push(tempSpawn);
			}
			
			//hard code nodes
			var tempNode:Node = new Node();
			tempNode.x = 192;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = stage.stageWidth;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelData.path.push(tempNode);
			
			//get how many total nodes are in the path
			numNodes = levelData.path.length;
			
			dogs = new Vector.<Dog>();
			
			tempCat = new Cat();
			tempCat.x = Main.STAGE_WIDTH * .5;
			tempCat.y = Main.STAGE_HEIGHT * .5;
			tempCat.init();
			add(tempCat.playArt);
			add(tempCat.sensor);
			
			lifeTime = 0;
		}
		
		override public function update(timeDelta:Number):void
		{
			if (!gameover)
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
				
				for each(var dog:Dog in dogs)
				{
					dog.update(timeDelta);
					
					if (dog.reachedNode) setNextNode(dog);
				}
			}else {
				trace("You Lose");
				_ce.state = new EditState();
			}
			
			tempCat.update(timeDelta);
			
			lifeTime += timeDelta;
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