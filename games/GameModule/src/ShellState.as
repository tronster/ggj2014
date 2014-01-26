package  
{
	import aze.motion.eaze;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ShellState extends StarlingState
	{
		public var title		:CitrusSprite;
		public var background	:CitrusSprite;
		
		
		public function ShellState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			background = new CitrusSprite("background", { view:Image.fromBitmap(new Resources.titlebg()), parallaxX:1.0 } );
			//background.view.pivotX = background.x = background.view.width/2;
			//background.view.pivotY = background.y = background.view.height / 2;
			//background.y += 250;
			//background.view.scaleX =background.view.scaleY = 2;
			add( background );

			title = new CitrusSprite("title", { view:Image.fromBitmap(new Resources.title()) } );
			title.x = 150; 
			add( title );
			eaze(title).to( 1.1, {y:100 });
			
			var startBtn:Button =  new Button(
				Resources.getAtlas().getTexture("button"),
				"",
				Resources.getAtlas().getTexture("button hover"));

			startBtn.x = (stage.stageWidth * .5) - (startBtn.width * .5);
			startBtn.y = (stage.stageHeight * .75 );
			startBtn.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild( startBtn );
		}
		
		public function onButtonTriggered(e:Event):void 
		{
			resetGame();
			_ce.state = new EditState();
		}
		
		public function resetGame():void
		{
			_ce.gameData[Config.CURRENT_LEVEL_NUM] 	= 1;
			_ce.gameData[Config.CURRENT_LEVEL] 		= null;
		}
	}

}