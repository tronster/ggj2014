package  
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Resources
	{	
		[Embed(source = "/../embed/titlebg.png")]													public static const titlebg:Class;
		[Embed(source = "/../embed/title.png")]														public static const title:Class;		
		
		[Embed(source="/../embed/DefaultSpritesheet.png")]											public static const AtlasTextureDefault:Class;
		[Embed(source="/../embed/DefaultSpritesheet.xml", mimeType="application/octet-stream")]		public static const AtlasXmlDefault:Class;
		
		[Embed(source="/../embed/asset_sheet.png")]													public static const AtlasTextureTemp:Class;
		[Embed(source="/../embed/asset_data.xml", mimeType="application/octet-stream")]				public static const AtlasXmlTemp:Class;
		
		[Embed(source="/../embed/main_font.png")]													public static const MainFontTexture:Class;
		[Embed(source="/../embed/main_font.fnt", mimeType="application/octet-stream")]				public static const MainFontData:Class;
		
		private static var atlases:Dictionary;
		
		
		
		
		//--------------------------------------------------------------------
		static public function initialize():void
		{
			//generate default atlas
			atlases 					= new Dictionary(false);
			var texture	:Texture		= makeTexture("AtlasTextureDefault");
			var xml		:XML 			= XML( new AtlasXmlDefault() );
			atlases["_default"]			= new TextureAtlas(texture, xml);
			
			//generate font atlas
			texture 					= makeTexture("MainFontTexture");
			xml 						= XML( new MainFontData() );
			atlases["_mainfont"]		= new TextureAtlas(texture, xml);
		}
		
		
		//--------------------------------------------------------------------\
		static public function getAtlas( name:String = "_default" ) :TextureAtlas
		{
			return atlases[ name ];
		}
		
		
		//--------------------------------------------------------------------
		/// Helper
		static private function makeTexture( embedName:String):Texture
		{
			return Texture.fromBitmap( new Resources[embedName]() );
		}	
	}
}