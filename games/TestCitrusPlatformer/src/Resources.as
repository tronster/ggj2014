package  
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Resources
	{	
		
		[Embed(source="/../embed/DefaultSpritesheet.png")]
		public static const AtlasTextureDefault:Class;
		
		[Embed(source="/../embed/DefaultSpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlDefault:Class;
		
		
		
		private static var atlases:Dictionary;

		
		
		static public function initialize():void
		{
			atlases 					= new Dictionary(false);
			var texture	:Texture		= makeTexture("AtlasTextureDefault");
			var xml		:XML 			= XML( new AtlasXmlDefault() );
			atlases["_default"]			= new TextureAtlas(texture, xml);
		}
		
		
		static public function getAtlas( name:String = "_default" ) :TextureAtlas
		{
			return atlases[ name ];
		}
		
		/// Helper
		static private function makeTexture( embedName:String):Texture
		{
			return Texture.fromBitmap( new Resources[embedName]() );
		}	
	}
}