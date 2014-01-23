package  
{
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class Resources 
	{
		//import font resources
		[Embed(source="../lib/myGlyphs.fnt", mimeType="application/octet-stream")]		//particle informatiion in XML formate
		private static const fontData:Class;
		[Embed(source="../lib/myGlyphs.png")]			
		private static const fontSheet:Class;
		public static var imgFont:BitmapFont;
		
		[Embed(source = "../lib/fonts/OCRAEXT.ttf", fontName='MainFont', advancedAntiAliasing="true", mimeType="application/x-font", embedAsCFF="false")]
		private static const genericFont:Class;
		
		// embed your graphics
		[Embed(source = '../lib/hero_idle.png')]
		public static var _heroIdleClass:Class;
		[Embed(source = '../lib/hero_walk.png')]
		public static var _heroWalkClass:Class;
		[Embed(source = '../lib/hero_jump.png')]
		public static var _heroJumpClass:Class;
		[Embed(source = '../lib/bg_hills.png')]
		public static var _hillsClass:Class;
		
		//import spritesheet
		[Embed(source = "../lib/asset_sheet.png")]
		private static const assetSheet:Class;
		[Embed(source="../lib/asset_sheet_data.xml", mimeType="application/octet-stream")]
		private static const assetSheetData:Class;
		
		//import particle resources
		[Embed(source="../lib/particles/particle.pex", mimeType="application/octet-stream")]		//particle informatiion in XML format
		public static var particlePEX:Class;
		[Embed(source="../lib/particles/texture.png")]			
		public static var particleTexture:Class;
		
		public static var assetAtlas:TextureAtlas;
		
		public static  function init():void
		{
			//load texture atlas
			var assetTexture:Texture = Texture.fromBitmap(new assetSheet());
			var assetData:XML = XML(new assetSheetData());
			assetAtlas = new TextureAtlas(assetTexture, assetData);
			
			imgFont = new BitmapFont(Texture.fromBitmap(new fontSheet()), XML(new fontData()));
			TextField.registerBitmapFont(imgFont);
		}
		
	}

}