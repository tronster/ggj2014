package  
{
	import citrus.core.starling.StarlingState;
	import starling.display.Button;
	import starling.events.Event;


	public class Shell extends StarlingState
	{
		private var startBtn:Button;
		
		public function Shell() 
		{
			super();
		}

		override public function initialize():void 
		{
			super.initialize();
			
			startBtn= new Button( Resources.getAtlas().getTexture("gameOver_mainButton"));
			startBtn.x = (stage.stageWidth / 2) 	- (startBtn.width / 2);
			startBtn.y = (stage.stageHeight / 2)	- (startBtn.height / 2);
			startBtn.addEventListener(Event.TRIGGERED, onStartClick );
			this.addChild( startBtn );	
		}
		
		public function onStartClick( e:Event ):void
		{
			if ( Global.level != null )
				_ce.state = Global.level;
			
		}
	}

}