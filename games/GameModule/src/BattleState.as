package  
{
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.physics.box2d.Box2D;
	import starling.events.Event;

	
	public class BattleState extends StarlingState
	{
		public var startTime:uint;
		
		private var lifeTime:Number;
		private var levelInfo:LevelData;
		private var dogs:Vector.<Dog>;
		private var numNodes:int;
		
		public function BattleState() 
		{
			super();
			trace("Battle State Constructed");
		}
		
		
		override public function initialize():void
		{
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = true;
			box2D.gravity = new b2Vec2(0, 0);
			add(box2D);
			
			//levelInfo = LevelData(_ce.gameData).clone();
			levelInfo = new LevelData();
			
			//hard code spawns
			var tempSpawn:Spawn;
			for (var i:int = 0; i < 10; i++)
			{
				tempSpawn = new Spawn(1, (i + 1));	//time to spawn is 1 second intervals
				levelInfo.spawns.push(tempSpawn);
			}
			
			//hard code nodes
			var tempNode:Node = new Node();
			tempNode.x = 192;
			tempNode.y = stage.stageHeight * .5;
			tempNode.gfxType = 1;
			levelInfo.path.push(tempNode);
			
			tempNode = new Node();
			tempNode.x = stage.stageWidth;
			tempNode.y = stage.stageWidth * .5;
			tempNode.gfxType = 1;
			levelInfo.path.push(tempNode);
			
			//get how many total nodes are in the path
			numNodes = levelInfo.path.length;
			
			dogs = new Vector.<Dog>();
			
			lifeTime = 0;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			//check if a dog needs to be created
			if (levelInfo.spawns.length >= 1 && levelInfo.spawns[0].time <= lifeTime)
			{
				var dogInfo:Spawn = levelInfo.spawns.shift();
				var tempDog:Dog = new Dog(dogInfo.dogType);
				tempDog.targetNode = levelInfo.path[numNodes - 1];
				add(tempDog.playArt);
				tempDog.init();
				dogs.push(tempDog);
				
				trace("Dog created at: " + lifeTime);
			}
			
			for each(var dog:Dog in dogs)
			{
				dog.update(timeDelta);
			}
			
			lifeTime += timeDelta;
		}
	}

}