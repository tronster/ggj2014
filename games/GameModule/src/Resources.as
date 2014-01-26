package  
{
	import citrus.datastructures.PoolObject;
	import citrus.view.starlingview.AnimationSequence;
	import dragonBones.animation.Animation;
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Resources
	{	
		[Embed(source = "/../embed/BackgroundArtPlayState.png")]									public static const bg		:Class;
		[Embed(source = "/../embed/titlebg.png")]													public static const titlebg	:Class;
		[Embed(source = "/../embed/title.png")]														public static const title	:Class;		
	//	[Embed(source = "/../embed/BattleCloud.swf")]												public static const elMovie	:Class;		
	
	
		// Sheets
		
		[Embed(source = "/../embed/Cat1Idle.png")]													public static const Cat1IdleTexture		:Class;		
		[Embed(source = "/../embed/Cat1Idle.xml", 		mimeType="application/octet-stream")]		public static const Cat1Idle			:Class;		
		[Embed(source = "/../embed/Cat1Defeat.png")]												public static const Cat1DefeatTexture	:Class;		
		[Embed(source = "/../embed/Cat1Defeat.xml", 	mimeType="application/octet-stream")]		public static const Cat1Defeat			:Class;		
		[Embed(source = "/../embed/Cat1Victory.png")]												public static const Cat1VictoryTexture	:Class;		
		[Embed(source = "/../embed/Cat1Victory.xml", 	mimeType="application/octet-stream")]		public static const Cat1Victory			:Class;		
		[Embed(source = "/../embed/Cat1Ready.png")]													public static const Cat1ReadyTexture	:Class;		
		[Embed(source = "/../embed/Cat1Ready.xml", 		mimeType="application/octet-stream")]		public static const Cat1Ready			:Class;		
		[Embed(source = "/../embed/Cat1Lose.png")]													public static const Cat1LoseTexture		:Class;		
		[Embed(source = "/../embed/Cat1Lose.xml", 		mimeType="application/octet-stream")]		public static const Cat1Lose			:Class;		

		[Embed(source = "/../embed/Cat2Idle.png")]													public static const Cat2IdleTexture		:Class;		
		[Embed(source = "/../embed/Cat2Idle.xml", 		mimeType="application/octet-stream")]		public static const Cat2Idle			:Class;		
		[Embed(source = "/../embed/Cat2Defeat.png")]												public static const Cat2DefeatTexture	:Class;		
		[Embed(source = "/../embed/Cat2Defeat.xml", 	mimeType="application/octet-stream")]		public static const Cat2Defeat			:Class;		
		[Embed(source = "/../embed/Cat2Victory.png")]												public static const Cat2VictoryTexture	:Class;		
		[Embed(source = "/../embed/Cat2Victory.xml", 	mimeType="application/octet-stream")]		public static const Cat2Victory			:Class;		
		[Embed(source = "/../embed/Cat2Ready.png")]													public static const Cat2ReadyTexture	:Class;		
		[Embed(source = "/../embed/Cat2Ready.xml", 		mimeType="application/octet-stream")]		public static const Cat2Ready			:Class;		
		[Embed(source = "/../embed/Cat2Lose.png")]													public static const Cat2LoseTexture		:Class;		
		[Embed(source = "/../embed/Cat2Lose.xml", 		mimeType="application/octet-stream")]		public static const Cat2Lose			:Class;		

		[Embed(source = "/../embed/Cat3Idle.png")]													public static const Cat3IdleTexture		:Class;		
		[Embed(source = "/../embed/Cat3Idle.xml", 		mimeType="application/octet-stream")]		public static const Cat3Idle			:Class;		
		[Embed(source = "/../embed/Cat3Defeat.png")]												public static const Cat3DefeatTexture	:Class;		
		[Embed(source = "/../embed/Cat3Defeat.xml", 	mimeType="application/octet-stream")]		public static const Cat3Defeat			:Class;		
		[Embed(source = "/../embed/Cat3Victory.png")]												public static const Cat3VictoryTexture	:Class;		
		[Embed(source = "/../embed/Cat3Victory.xml", 	mimeType="application/octet-stream")]		public static const Cat3Victory			:Class;		
		[Embed(source = "/../embed/Cat3Ready.png")]													public static const Cat3ReadyTexture	:Class;		
		[Embed(source = "/../embed/Cat3Ready.xml", 		mimeType="application/octet-stream")]		public static const Cat3Ready			:Class;		
		[Embed(source = "/../embed/Cat3Lose.png")]													public static const Cat3LoseTexture		:Class;		
		[Embed(source = "/../embed/Cat3Lose.xml", 		mimeType = "application/octet-stream")]		public static const Cat3Lose			:Class;		
		
		
		[Embed(source = "/../embed/Dog1Defeat.png")]												public static const Dog1DefeatTexture	:Class;		
		[Embed(source = "/../embed/Dog1Defeat.xml", 	mimeType="application/octet-stream")]		public static const Dog1Defeat			:Class;		
		[Embed(source = "/../embed/Dog1Down.png")]													public static const Dog1DownTexture		:Class;		
		[Embed(source = "/../embed/Dog1Down.xml", 		mimeType="application/octet-stream")]		public static const Dog1Down			:Class;		
		[Embed(source = "/../embed/Dog1Left.png")]													public static const Dog1LeftTexture		:Class;		
		[Embed(source = "/../embed/Dog1Left.xml", 		mimeType="application/octet-stream")]		public static const Dog1Left			:Class;		
		[Embed(source = "/../embed/Dog1Right.png")]													public static const Dog1RightTexture	:Class;		
		[Embed(source = "/../embed/Dog1Right.xml", 		mimeType="application/octet-stream")]		public static const Dog1Right			:Class;		
		[Embed(source = "/../embed/Dog1Up.png")]													public static const Dog1UpTexture		:Class;		
		[Embed(source = "/../embed/Dog1Up.xml", 		mimeType="application/octet-stream")]		public static const Dog1Up				:Class;		
		[Embed(source = "/../embed/Dog1Victory.png")]												public static const Dog1VictoryTexture	:Class;		
		[Embed(source = "/../embed/Dog1Victory.xml", 	mimeType="application/octet-stream")]		public static const Dog1Victory			:Class;		
		
		[Embed(source = "/../embed/Dog2Defeat.png")]												public static const Dog2DefeatTexture	:Class;		
		[Embed(source = "/../embed/Dog2Defeat.xml", 	mimeType="application/octet-stream")]		public static const Dog2Defeat			:Class;		
		[Embed(source = "/../embed/Dog2Down.png")]													public static const Dog2DownTexture		:Class;		
		[Embed(source = "/../embed/Dog2Down.xml", 		mimeType="application/octet-stream")]		public static const Dog2Down			:Class;		
		[Embed(source = "/../embed/Dog2Left.png")]													public static const Dog2LeftTexture		:Class;		
		[Embed(source = "/../embed/Dog2Left.xml", 		mimeType="application/octet-stream")]		public static const Dog2Left			:Class;		
		[Embed(source = "/../embed/Dog2Right.png")]													public static const Dog2RightTexture	:Class;		
		[Embed(source = "/../embed/Dog2Right.xml", 		mimeType="application/octet-stream")]		public static const Dog2Right			:Class;		
		[Embed(source = "/../embed/Dog2Up.png")]													public static const Dog2UpTexture		:Class;		
		[Embed(source = "/../embed/Dog2Up.xml", 		mimeType="application/octet-stream")]		public static const Dog2Up				:Class;		
		[Embed(source = "/../embed/Dog2Victory.png")]												public static const Dog2VictoryTexture	:Class;		
		[Embed(source = "/../embed/Dog2Victory.xml", 	mimeType="application/octet-stream")]		public static const Dog2Victory			:Class;		
		
		[Embed(source = "/../embed/Dog3Defeat.png")]												public static const Dog3DefeatTexture	:Class;		
		[Embed(source = "/../embed/Dog3Defeat.xml", 	mimeType="application/octet-stream")]		public static const Dog3Defeat			:Class;		
		[Embed(source = "/../embed/Dog3Down.png")]													public static const Dog3DownTexture		:Class;		
		[Embed(source = "/../embed/Dog3Down.xml", 		mimeType="application/octet-stream")]		public static const Dog3Down			:Class;		
		[Embed(source = "/../embed/Dog3Left.png")]													public static const Dog3LeftTexture		:Class;		
		[Embed(source = "/../embed/Dog3Left.xml", 		mimeType="application/octet-stream")]		public static const Dog3Left			:Class;		
		[Embed(source = "/../embed/Dog3Right.png")]													public static const Dog3RightTexture	:Class;		
		[Embed(source = "/../embed/Dog3Right.xml", 		mimeType="application/octet-stream")]		public static const Dog3Right			:Class;		
		[Embed(source = "/../embed/Dog3Up.png")]													public static const Dog3UpTexture		:Class;		
		[Embed(source = "/../embed/Dog3Up.xml", 		mimeType="application/octet-stream")]		public static const Dog3Up				:Class;		
		[Embed(source = "/../embed/Dog3Victory.png")]												public static const Dog3VictoryTexture	:Class;		
		[Embed(source = "/../embed/Dog3Victory.xml", 	mimeType="application/octet-stream")]		public static const Dog3Victory			:Class;		
		
		
		
		[Embed(source = "/../embed/Battlecloud.png")]												public static const BattlecloudTexture	:Class;		
		[Embed(source = "/../embed/Battlecloud.xml", 	mimeType="application/octet-stream")]		public static const BattlecloudXml		:Class;		

		[Embed(source = "/../embed/hpbar.png")]														public static const hpbarTexture		:Class;		
		[Embed(source = "/../embed/hpbar.xml", 			mimeType="application/octet-stream")]		public static const hpbar				:Class;		
		
		
		
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

			makeAtlas( "Cat2Defeat", 	Cat2Defeat );
			makeAtlas( "Cat2Idle",  	Cat2Idle );
			makeAtlas( "Cat2Victory",  	Cat2Victory );
			makeAtlas( "Cat2Ready",  	Cat2Ready );
			makeAtlas( "Cat2Lose",  	Cat2Lose );

			makeAtlas( "Cat3Defeat", 	Cat3Defeat );
			makeAtlas( "Cat3Idle",  	Cat3Idle );
			makeAtlas( "Cat3Victory",  	Cat3Victory );
			makeAtlas( "Cat3Ready",  	Cat3Ready );
			makeAtlas( "Cat3Lose",  	Cat3Lose );
			
			makeAtlas( "Dog1Defeat",  	Dog1Defeat );
			makeAtlas( "Dog1Down",  	Dog1Down );
			makeAtlas( "Dog1Left",  	Dog1Left );
			makeAtlas( "Dog1Right",  	Dog1Right );
			makeAtlas( "Dog1Up", 	 	Dog1Up );
			makeAtlas( "Dog1Victory",  	Dog1Victory );
			
			makeAtlas( "Dog2Defeat",  	Dog2Defeat );
			makeAtlas( "Dog2Down",  	Dog2Down );
			makeAtlas( "Dog2Left",  	Dog2Left );
			makeAtlas( "Dog2Right",  	Dog2Right );
			makeAtlas( "Dog2Up", 	 	Dog2Up );
			makeAtlas( "Dog2Victory",  	Dog2Victory );
			
			makeAtlas( "Dog3Defeat",  	Dog3Defeat );
			makeAtlas( "Dog3Down",  	Dog3Down );
			makeAtlas( "Dog3Left",  	Dog3Left );
			makeAtlas( "Dog3Right",  	Dog3Right );
			makeAtlas( "Dog3Up", 	 	Dog3Up );
			makeAtlas( "Dog3Victory",  	Dog3Victory );
			
			makeAtlas( "Battlecloud", 	BattlecloudXml );
			makeAtlas( "hpbar", 		hpbar );
			
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
		
		static public function getViewWithMultipleAtlas(args:Array):AnimationSequence
		{
			var sa:AnimationSequence;
			
			if (args is Array)
			{
				sa = new AnimationSequence(getAtlas(args[0]), [args[0]], args[0], 30, true);
				
				for (var i:int = 1; i < args.length; i++)
				{
					sa.addTextureAtlasWithAnimations(getAtlas(args[i]), [args[i]]);
				}
			}else {
				error("Invalid argument type in getViewWithMultipleAtlas");
			}
			
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