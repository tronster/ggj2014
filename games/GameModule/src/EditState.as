package  
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	
	public class EditState extends StarlingState
	{
		public var bg			:CitrusSprite;
		public var goButton		:Button;
		public var levelData	:LevelData;
		
		
		public function EditState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			bg = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			add(bg);

			var goButton:Button =  new Button(
				Resources.getAtlas().getTexture("button"),
				"Go",
				Resources.getAtlas().getTexture("button hover"));

			goButton.x = 0;
			goButton.y = stage.stageHeight - 100;
			goButton.addEventListener(Event.TRIGGERED, onGoButtonTriggered);
			addChild( goButton );			
			
			getCurrentLevelData();
		}
		
		
		private function onGoButtonTriggered( e:Event ):void
		{
			_ce.state = new BattleState();			
		}
		
		
		
		public function getCurrentLevelData()
		{
			var levelNum:int = _ce.gameData[Config.CURRENT_LEVEL_NUM];
			if ( levelNum == 1 )
			{
				error("Invalid level number, using 1 instead of " + levelNum);
				levelNum = 1;
			}
			
			levelData = _ce.gameData[ Config.GAMEDATA_LEVELS ][levelNum];			
		}
	}

}