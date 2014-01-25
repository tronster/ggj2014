package  
{
	import citrus.core.starling.StarlingState;
	import starling.events.Event;

	
	public class BattleState extends StarlingState
	{
		public var startTime:uint;
		
		private var levelInfo:LevelData;
		
		public function BattleState() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			trace("Battle State Constructed");
		}
		
		private function onAddedToStage(e:Event):void 
		{
			trace("BattleState added to stage");
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.initialize();
		}
		
		override public function initialize():void
		{
			//levelInfo = LevelData(_ce.gameData).clone();
			levelInfo = new LevelData();
			
			//hard code spawns
			var tempSpawn:Spawn;
			for (var i:int = 0; i < 10; i++)
			{
				tempSpawn = new Spawn(1, (i + 1) * 1000);	//time to spawn is 1 second intervals
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
			for (i = 0; i < 2; i++)
			{
				
			}
		}
	}

}