package  
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import feathers.controls.Button;
	import feathers.text.BitmapFontTextFormat;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class MenuState extends StarlingState
	{		
		private var someText:TextField;
		
		public function MenuState() 
		{			
			var img:Image = Resources.imgFont.getChar(81).createImage();
			img.x = 300;
			img.y = 300;
			addChild(img);
			
			var s:Sprite = Resources.imgFont.createSprite(100, 25, "QWOMX6", 24);
			s.x = 200;
			s.y = 200;
			addChild(s);
			
			someText = new TextField(100, 25, "QWOMX", "mycustomfont", 24);
			someText.color = 0x00ffff;
			someText.x = 400;
			someText.y = 300;
			addChild(someText);
			
			var font:BitmapFontTextFormat = new BitmapFontTextFormat(Resources.imgFont);
			var startBtn:Button = new Button();
			startBtn.defaultLabelProperties.textFormat = font;
			startBtn.label = "QWOMX";
			startBtn.x = 100;
			startBtn.y = 100;
			startBtn.defaultSkin = new Image(Resources.assetAtlas.getTexture("start_game_idle_button"));
			startBtn.hoverSkin = new Image(Resources.assetAtlas.getTexture("start_game_over_button"));
			startBtn.downSkin = new Image(Resources.assetAtlas.getTexture("start_game_down_button"));
			//startBtn.defaultIcon =  new Image(assetAtlas.getTexture("damageup"));
			//startBtn.iconPosition = Button.ICON_POSITION_RIGHT_BASELINE;
			addChild(startBtn);
			startBtn.addEventListener(Event.TRIGGERED, onButtonTriggered);
			trace(startBtn.hasEventListener(Event.TRIGGERED));
			this.addEventListener(GameStateEvent.STATE_CHANGE, onStateChange);
		}
		
		private function onButtonTriggered(e:Event):void
		{
			trace("Button Clicked!");
			//_ce.state = new BlittingGameState();
			dispatchEvent(new GameStateEvent(GameStateEvent.STATE_CHANGE, {id:"play"}, false));
		}
		
		private function onStateChange(e:GameStateEvent):void 
		{
			trace("MenuState Change");
		}
	}

}