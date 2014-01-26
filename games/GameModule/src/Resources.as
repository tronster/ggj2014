package  
{
	import citrus.datastructures.PoolObject;
	import citrus.view.starlingview.AnimationSequence;
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Resources
	{	
		[Embed(source = "/../embed/bg.png")]														public static const bg		:Class;
		[Embed(source = "/../embed/titlebg.png")]													public static const titlebg	:Class;
		[Embed(source = "/../embed/title.png")]														public static const title	:Class;		
	//	[Embed(source = "/../embed/BattleCloud.swf")]												public static const elMovie	:Class;		
	
	
		// Sheets
		
		[Embed(source = "/../embed/Cat1Idle.png")]													public static const Cat1IdleTexture		:Class;		
		[Embed(source = "/../embed/Cat1Idle.xml", 		mimeType="application/octet-stream")]		public static const Cat1Idle			:Class;		
		[Embed(source = "/../embed/Cat1Defeat.png")]												public static const Cat1DefeatTexture	:Class;		
		[Embed(source = "/../embed/Cat1Defeat.xml", 		mimeType="application/octet-stream")]		public static const Cat1Defeat			:Class;		
		[Embed(source = "/../embed/Cat1Victory.png")]												public static const Cat1VictoryTexture	:Class;		
		[Embed(source = "/../embed/Cat1Victory.xml", 	mimeType="application/octet-stream")]		public static const Cat1Victory			:Class;		
		[Embed(source = "/../embed/Cat1Ready.png")]													public static const Cat1ReadyTexture	:Class;		
		[Embed(source = "/../embed/Cat1Ready.xml", 		mimeType="application/octet-stream")]		public static const Cat1Ready			:Class;		
		[Embed(source = "/../embed/Cat1Lose.png")]													public static const Cat1LoseTexture		:Class;		
		[Embed(source = "/../embed/Cat1Lose.xml", 		mimeType="application/octet-stream")]		public static const Cat1Lose			:Class;		

		
		[Embed(source = "/../embed/Dog1Defeat.png")]												public static const Dog1DefeatTexture	:Class;		
		[Embed(source = "/../embed/Dog1Defeat.xml", 		mimeType="application/octet-stream")]		public static const Dog1Defeat			:Class;		
		[Embed(source = "/../embed/Dog1Down.png")]													public static const Dog1DownTexture		:Class;		
		[Embed(source = "/../embed/Dog1Down.xml", 		mimeType="application/octet-stream")]		public static const Dog1Down			:Class;		
		[Embed(source = "/../embed/Dog1Left.png")]													public static const Dog1LeftTexture		:Class;		
		[Embed(source = "/../embed/Dog1Left.xml", 		mimeType="application/octet-stream")]		public static const Dog1Left			:Class;		
		[Embed(source = "/../embed/Dog1Right.png")]													public static const Dog1RightTexture	:Class;		
		[Embed(source = "/../embed/Dog1Right.xml", 		mimeType="application/octet-stream")]		public static const Dog1Right			:Class;		
		[Embed(source = "/../embed/Dog1Up.png")]													public static const Dog1UpTexture		:Class;		
		[Embed(source = "/../embed/Dog1Up.xml", 			mimeType="application/octet-stream")]		public static const Dog1Up				:Class;		
		[Embed(source = "/../embed/Dog1Victory.png")]												public static const Dog1VictoryTexture	:Class;		
		[Embed(source = "/../embed/Dog1Victory.xml", 	mimeType="application/octet-stream")]		public static const Dog1Victory			:Class;		
		
		
		
		[Embed(source = "/../embed/Battlecloud.png")]												public static const BattleCloudTexture	:Class;		
		[Embed(source = "/../embed/Battlecloud.xml", mimeType="application/octet-stream")]			public static const BattleCloudXml		:Class;		

		[Embed(source = "/../embed/hpbar.png")]														public static const HPBarTexture		:Class;		
		[Embed(source = "/../embed/hpbar.xml", 		mimeType="application/octet-stream")]			public static const HPBar				:Class;		
		
		
		
		[Embed(source="/../embed/DefaultSpritesheet.png")]											public static const AtlasTextureDefault:Class;
		[Embed(source="/../embed/DefaultSpritesheet.xml", mimeType="application/octet-stream")]		public static const AtlasXmlDefault:Class;
		
		[Embed(source="/../embed/asset_sheet.png")]													public static const AtlasTextureTemp:Class;
		[Embed(source="/../embed/asset_data.xml", mimeType="application/octet-stream")]				public static const AtlasXmlTemp:Class;
		
		[Embed(source="/../embed/main_font.png")]													public static const MainFontTexture:Class;
		[Embed(source="/../embed/main_font.fnt", mimeType="application/octet-stream")]				public static const MainFontData:Class;
		
		
		private static var atlases	:Dictionary;
		private static var pool		:PoolObject;
		
		
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

			/*??TRON remove
			texture						= makeTexture("BattleCloudTexture");
			xml							= XML( new BattleCloudXml() );
			atlases["battlecloud"]		= new TextureAtlas(texture, xml );
			*/
			
			texture						= makeTexture("AtlasTextureTemp");
			xml							= XML( new AtlasXmlTemp() );
			atlases["temp_sheet"]		= new TextureAtlas(texture, xml );			
						
			makeAtlas( "Cat1Defeat", 	Cat1Defeat );
			makeAtlas( "Cat1Idle",  	Cat1Idle );
			makeAtlas( "Cat1Victory",  	Cat1Victory );
			makeAtlas( "Cat1Ready",  	Cat1Ready );
			makeAtlas( "Cat1Lose",  	Cat1Lose );

			makeAtlas( "Dog1Defeat",  	Dog1Defeat );
			makeAtlas( "Dog1Down",  	Dog1Down );
			makeAtlas( "Dog1Left",  	Dog1Left );
			makeAtlas( "Dog1Right",  	Dog1Right );
			makeAtlas( "Dog1Up", 	 	Dog1Up );
			makeAtlas( "Dog1Victory",  	Dog1Victory );
			
			makeAtlas( "BattleCloud", 	BattleCloudXml );
			makeAtlas( "HPBar", 		HPBar );
			
		}
	
		//--------------------------------------------------------------------
		static public function getAtlas( name:String = "_default" ) :TextureAtlas
		{
			return atlases[ name ];
		}
	
		//--------------------------------------------------------------------
		// atlasName	name of the atlas is same as texture minus "Texture"
		// xml			the resource class containing the XML
		static private function makeAtlas( atlasName:String, cls:Class):void
		{
			var texture :Texture 	= Texture.fromBitmap( new Resources[atlasName+"Texture"]() );
			var xml		:XML		= XML( new cls() );
			atlases[ atlasName ]	= new TextureAtlas( texture, xml );
		}			
		
		// name Cat1Victory
		static public function getView( name:String, loop:Boolean = true ) :AnimationSequence
		{
			var sa:AnimationSequence = new AnimationSequence( Resources.getAtlas( name ), [name], name, 30, loop );
			return sa;
		}
		
		//--------------------------------------------------------------------
		/// Helper
		static private function makeTexture( embedName:String):Texture
		{
			return Texture.fromBitmap( new Resources[embedName]() );
		}	
	}
}