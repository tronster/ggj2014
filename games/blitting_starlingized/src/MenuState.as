package  
{
	import citrus.core.starling.StarlingState;
	import starling.display.Image;
	import starling.display.Sprite;
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
		
		[Embed(source = "../lib/fonts/OCRAEXT.ttf", fontName='MainFont', advancedAntiAliasing="true", mimeType="application/x-font", embedAsCFF="false")]
		private var genericFont:Class;
		
		private var imgFont:BitmapFont;
		private var someText:TextField;
		
		public function MenuState() 
		{
			imgFont = new BitmapFont(Texture.fromBitmap(new fontSheet()), XML(new fontData()));
			TextField.registerBitmapFont(imgFont);
			trace("Main Font: " + imgFont.name);
			
			var img:Image = imgFont.getChar(81).createImage();
			img.x = 300;
			img.y = 300;
			//img.smoothing = true;
			//addChild(img);
			
			var s:Sprite = imgFont.createSprite(100, 25, "QWOMX6", 24);
			s.x = 200;
			s.y = 200;
			//addChild(s);
			
			someText = new TextField(100, 25, "QWOMX", "mycustomfont", 24);
			someText.color = 0x00ffff;
			someText.x = 400;
			someText.y = 300;
			addChild(someText);
		}
		
	}

}