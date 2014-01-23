package  
{
	import citrus.core.starling.StarlingState;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class MenuState extends StarlingState
	{
		//import font resources
		[Embed(source="../lib/myGlyphs.fnt", mimeType="application/octet-stream")]		//particle informatiion in XML formate
		private var fontData:Class;
		[Embed(source="../lib/myGlyphs.png")]			
		private var fontSheet:Class;
		
		[Embed(source="../lib/fonts/image_font.fnt", mimeType="application/octet-stream")]		//particle informatiion in XML formate
		private var customFontData:Class;
		[Embed(source="../lib/fonts/image_font.png")]			
		private var customFontSheet:Class;
		
		[Embed(source = "../lib/fonts/OCRAEXT.ttf", fontName='MainFont', advancedAntiAliasing="true", mimeType="application/x-font", embedAsCFF="false")]
		private var genericFont:Class;
		
		private var countVal:int = 0;
		private var imgFont:BitmapFont;
		private var someText:TextField;
		private var genericText:TextField;
		
		
		public function MenuState() 
		{
			imgFont = new BitmapFont(Texture.fromBitmap(new fontSheet()), XML(new fontData()));
			TextField.registerBitmapFont(imgFont);
			trace("Main Font: " + imgFont.name);
			
			/* Creates a Starling Image of the character specified 
			 * var img:Image = imgFont.getChar(81).createImage();
			img.x = 300;
			img.y = 300;
			img.smoothing = true;
			addChild(img);*/
			
			/* Creates a Straling Sprite that contains seperate bitmaps for each character passed in the constructor
			 * var s:Sprite = imgFont.createSprite(100, 25, "QWOMX6", 24);
			s.x = 200;
			s.y = 200;
			addChild(s);*/
			
			someText = new TextField(300, 100, "QWOMX", imgFont.name,  24, 0xffffff);	//color must be '0xffffff' to use the BitmapFont's colors
			someText.x = 400;
			someText.y = 300;
			//someText.border = true;
			addChild(someText);
			
			genericText = new TextField(200, 100, "Shawn's Embedded Custom Font", "MainFont", 24, 0x00ffff, true);
			genericText.x = 200;
			genericText.y = 200;
			//genericText.border = true;
			addChild(genericText);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:EnterFrameEvent):void 
		{
			countVal++;
			someText.text = countVal.toString();
		}
	}

}