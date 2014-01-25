package  
{
	import citrus.core.starling.StarlingState;
	import feathers.controls.Button;
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
			
			//var startBtn:Button =  new Button(Resources.getAtlas().getTexture("startButton"));
			var startBtn:Button =  new Button();
			startBtn.label = "BLAH";
			startBtn.defaultSkin = new Image(Resources.getAtlas().getTexture("startButton"));
			startBtn.hoverSkin = new Image(Resources.getAtlas().getTexture("welcome_aboutButton"));
			startBtn.downSkin = new Image(Resources.getAtlas().getTexture("pauseButton"));
			startBtn.x = (stage.stageWidth * .5) - (startBtn.width * .5);
			startBtn.y = (stage.stageHeight - startBtn.height) * .5;
			startBtn.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(startBtn);
			trace((stage.stageWidth * .5), (startBtn.width * .5), startBtn.x);
		}
		
		public function onButtonTriggered(e:Event):void 
		{
			trace("Start Game!");
			_ce.state = new EditState();
		}
	}

}