package  
{
	import citrus.core.starling.StarlingState;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ShellState extends StarlingState
	{
		
		public function ShellState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var startBtn:Button =  new Button(
				Resources.getAtlas().getTexture("button"),
				"",
				Resources.getAtlas().getTexture("button hover"));

			startBtn.x = (stage.stageWidth * .5) - (startBtn.width * .5);
			startBtn.y = (stage.stageHeight * .75 );
			startBtn.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(startBtn);
		}
		
		public function onButtonTriggered(e:Event):void 
		{
			trace("Start Game!");
			_ce.state = new EditState();
		}
	}

}