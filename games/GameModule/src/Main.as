package 
{
	import citrus.core.Console;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.objects.CitrusSprite;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.CitrusSoundInstance;
	import drg.Keyboard;
	import starling.display.Image;
//	import flash.desktop.NativeApplication;
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
			STAGE_WIDTH = stage.stageWidth;
			STAGE_HEIGHT = stage.stageHeight;
			TARGET_FRAME_TIME = stage.frameRate / 1000;
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		override public function initialize():void
		{
			setUpStarling(true);
			
			//offset the sounds (less gap in the looping sound)
			CitrusSoundInstance.startPositionOffset = 80;
			
			sound.addSound("editMusic", 		{ sound:"assets/editMusic.mp3",		permanent:true, volume:0.8 , loops:int.MAX_VALUE , group:CitrusSoundGroup.BGM } );	
			sound.addSound("battleMusic", 		{ sound:"assets/battleMusic.mp3",	permanent:true, volume:0.8 , loops:int.MAX_VALUE , group:CitrusSoundGroup.BGM } );	
			gameData = new GameData();
		}
		
		override public function handleStarlingReady():void
		{
			Resources.initialize();
			

			var levels		:Vector.<LevelData> = new Vector.<LevelData>();
			var levelData	:LevelData;
			
			var spawns	:Array = [];
			var path	:Vector.<Node>;

			// Level 1
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Our neighbor's dogs smell our sushi!" );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_straight()) } );
			levels.push( levelData );

			// Level 2
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Oh no, they're back with more!" );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_straight()) } );
			levels.push( levelData );

			// Level 3
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [3,3,1], [3,4,1], [4,4,1], [5,4,1], [6,4,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Even in puffy's yard the dogs have found us." );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_low_curve()) } );
			levels.push( levelData );

			// Level 4
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [3,3,1], [3,4,1], [4,4,1], [5,4,1], [6,4,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Who let these dogs out?" );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_low_curve()) } );
			levels.push( levelData );
			
			// Level 5
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,1,1], [1,1,1], [2,1,1], [2,2,1], [2,3,1], [3,3,1], [4,3,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "No matter where we go, the dogs follow." );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_two_bend()) } );
			levels.push( levelData );

			// Level 6
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,3,1], [1,3,1], [1,4,1], [2,4,1], [3,4,1], [3,3,1], [4,3,1], [4,2,1], [5,2,1], [6,2,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Keep fighting warrior cats!" );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_backtrack()) } );
			levels.push( levelData );

			// Level 7
			spawns		= LevelMaker.makeSpawns( [], 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [4,2,1], [4,3,1], [4,2,1], [3,2,1], [2,2,1], [2,1,1], [2,0,1], [3,0,1], [4,0,1], [5,0,1], [6,0,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Our last stand, Katseye!!!!!!" );			
			levelData.citrus = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_backtrack()) } );
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