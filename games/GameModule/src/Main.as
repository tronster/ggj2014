package 
{
	import citrus.core.Console;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.CitrusSoundInstance;
	import drg.Keyboard;
	import starling.display.Image;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
    
	[SWF(frameRate="60")]
	public class Main extends StarlingCitrusEngine 
	{
		public static var STAGE_WIDTH:Number;
		public static var STAGE_HEIGHT:Number;
		
		public static var TARGET_FRAME_TIME:Number;		
		
		public function Main():void 
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align 	= StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			var ourConsole:Console = this.console;
			ourConsole.addCommand( "level", onFastSwitchLevel );
			
			STAGE_WIDTH 		= stage.stageWidth;
			STAGE_HEIGHT 		= stage.stageHeight;
			TARGET_FRAME_TIME 	= stage.frameRate / 1000;
			
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			Global.stage2d = stage;
		}
		
		override public function initialize():void
		{
			setUpStarling( Config.SHOW_FPS );
			
			// Offset the sounds (less gap in the looping sound); BUt cutting off EFX sounds though; see if it can only be put on music.
			//CitrusSoundInstance.startPositionOffset = 80;
			
			sound.addSound("editMusic", 		{ sound:"assets/editMusic.mp3",		permanent:true, volume:0.8 , loops:int.MAX_VALUE , group:CitrusSoundGroup.BGM } );	
			sound.addSound("battleMusic", 		{ sound:"assets/battleMusic.mp3",	permanent:true, volume:0.8 , loops:int.MAX_VALUE , group:CitrusSoundGroup.BGM } );	

			sound.addSound("buttonSfx", 		{ sound:"assets/buttonSfx.mp3" , 	group:CitrusSoundGroup.SFX } );
			sound.addSound("catDropSfx", 		{ sound:"assets/catDropSfx.mp3" , 	group:CitrusSoundGroup.SFX } );
			sound.addSound("catPickupSfx", 		{ sound:"assets/catPickupSfx.mp3", 	group:CitrusSoundGroup.SFX } );
			sound.addSound("fightingSfx", 		{ sound:"assets/fightingSfx.mp3",	group:CitrusSoundGroup.SFX, volume:0.5 } );
			sound.addSound("catsLoseSfx",	 	{ sound:"assets/catsLoseSfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("catVictorySfx", 	{ sound:"assets/catVictorySfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("dogDefeatSfx",	 	{ sound:"assets/dogDefeatSfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("dogVictorySfx",	 	{ sound:"assets/dogVictorySfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("dogWinsSfx",	 	{ sound:"assets/dogWinsSfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("fightingSfx",	 	{ sound:"assets/fightingSfx.mp3",	group:CitrusSoundGroup.SFX } );
			sound.addSound("goSfx",	 			{ sound:"assets/goSfx.mp3",			group:CitrusSoundGroup.SFX } );
			sound.addSound("walking",	 		{ sound:"assets/walking.mp3",		group:CitrusSoundGroup.SFX } );
				
			gameData = new GameData();
		}
		
		override public function handleStarlingReady():void
		{
			Resources.initialize();
			
			var width		: int = 7;	// TODO: read this from the config file.
			var height		: int = 5;

			var levels		: Vector.<LevelData> = new Vector.<LevelData>();
			var levelData	: LevelData;
			
			var cats		: Array = [];
			var spawns		: Array = [];
			var path		: Vector.<Node>;
			
			// Level 1
			cats 		= [1,0,0];
			spawns		= LevelMaker.makeSpawns( [], 1, 1 );
			path		= LevelMaker.makePath([ [0, 2, 1], [1, 2, 1], [2, 2, 1], [3, 2, 1], [4, 2, 1], [5, 2, 1], [6, 2, 1] ]);
			
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_STRAIGHT, cats, path, spawns, "Our neighbor's dogs smell our sushi!" );			
			//levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_straight()) } );
			levelData.citrusSpriteNum = 0;
			levels.push( levelData );

			// Level 2
			cats		= [1, 2, 0];
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 3, 1, 7 );
			path		= LevelMaker.makePath([ [0, 2, 1], [1, 2, 1], [2, 2, 1], [3, 2, 1], [4, 2, 1], [5, 2, 1], [6, 2, 1] ]);
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_STRAIGHT, cats, path, spawns, "Oh no, they're back with more!" );			
			levelData.citrusSpriteNum = 0;
			levels.push( levelData );

			// Level 3
			cats		= [1, 1, 1];
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 2, 6, 3, 11 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [3,3,1], [3,4,1], [4,4,1], [5,4,1], [6,4,1] ]);
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_ONEBEND, cats, path, spawns, "Even in puffy's yard the dogs have found us." );			
			levelData.citrusSpriteNum = 1;
			levels.push( levelData );
			
			// Level 4
			cats		= [2, 2, 2];
			spawns		= LevelMaker.makeSpawns( []		, 1, 1, 1, 5, 2, 9 );
			spawns		= LevelMaker.makeSpawns( spawns , 2, 15, 3, 18, 1, 22 );
			path		= LevelMaker.makePath([ [0,1,1], [1,1,1], [2,1,1], [2,2,1], [2,3,1], [3,3,1], [4,3,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_ONEBENDLONG, cats, path, spawns, "No matter where we go, the dogs follow." );			
			levelData.citrusSpriteNum = 2;
			levels.push( levelData );

			// Level 5
			cats		= [2, 2, 2];
			spawns		= LevelMaker.makeSpawns( []	  , 3, 1,  3, 5, 2, 10 );
			spawns		= LevelMaker.makeSpawns( spawns, 1, 15, 3, 20, 2, 5 );
			path		= LevelMaker.makePath([ [0,1,1], [1,1,1], [2,1,1], [2,2,1], [2,3,1], [3,3,1], [4,3,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_ONEBENDLONG, cats, path, spawns, "Keep fighting warrior cats!" );			
			levelData.citrusSpriteNum = 2;
			levels.push( levelData );

			// Level 6
			cats		= [3, 3, 3];
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 3, 1, 8 );
			spawns		= LevelMaker.makeSpawns( spawns, 2, 12, 2, 15, 3, 20 );
			spawns		= LevelMaker.makeSpawns( spawns, 3, 24, 3, 28, 3, 32 );
			//path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [4,2,1], [4,3,1], [4,2,1], [3,2,1], [2,2,1], [2,1,1], [2,0,1], [3,0,1], [4,0,1], [5,0,1], [6,0,1] ]);
			path		= LevelMaker.makePath([ [0,3,1], [1,3,1], [1,4,1], [4,4,1], [4,2,1], [2,2,1], [2,0,1], [6,0,1] ]);
			levelData 	= LevelMaker.create( Config.LEVEL_DATA_TWOBEND, cats, path, spawns, "Our last stand, Katseye!!!!!!" );			
			levelData.citrusSpriteNum = 3;
			levels.push( levelData );

			gameData[ Config.GAMEDATA_LEVELS ] = levels;			
			
			// Remove default keyboard key actions and hook up our custom keyboard.
			_input.keyboard.destroy();
			_input.keyboard = new Keyboard("drgKeyboard");
			
			this.state = new ShellState();
			//this.state = new EditState();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		// Switch levels
		private function onFastSwitchLevel( levelNum:int ):void
		{
			trace("Request to switch level to: " + levelNum );
		}
	}
	
}