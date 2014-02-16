package  
{
	import flash.events.Event;
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import aze.motion.eaze;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	
	
	public class ShellState extends StarlingState
	{
		public var title		:CitrusSprite;
		public var background	:CitrusSprite;
		
		/// CTOR
		public function ShellState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			background = new CitrusSprite("background", { view:Image.fromBitmap(new Resources.titlebg()), parallaxX:1.0 } );
			add( background );

			title = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.title()) } );
			title.x = 150; 
			add( title );
			eaze(title).to( 1.1, {y:200 });
			
			var startBtn:Button =  new Button(
				Resources.getAtlas().getTexture("button"),
				"",
				Resources.getAtlas().getTexture("button hover"));

			startBtn.x = 750;
			startBtn.y = 550;
			startBtn.text = "Start";
			startBtn.addEventListener(starling.events.Event.TRIGGERED, onButtonTriggered);
			addChild( startBtn );	
		}
		
		
		public function onButtonTriggered(e:starling.events.Event):void 
		{
			_ce.sound.playSound("buttonSfx");
			resetGame();
			_ce.state = new EditState();
		}
		
		public function resetGame():void
		{
			_ce.gameData[Config.CURRENT_LEVEL_NUM] 	= Config.START_ON_LEVEL;
			_ce.gameData[Config.CURRENT_LEVEL] 		= null;
		}
	}

}