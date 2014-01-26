package 
{
	import citrus.core.Console;
	import citrus.core.starling.StarlingCitrusEngine;
	import drg.Keyboard;
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

			gameData = new GameData();

			var levelData:LevelData;
			
			//var tiles	:Array = [];
			var spawns	:Array = [];
			var path	:Vector.<Node>;
			
			spawns		= LevelMaker.makeSpawns( spawns, 1, 1, 1, 2, 1, 3 );
			path		= LevelMaker.makePath([ [0,2,1], [1,2,1], [2,2,1], [3,2,1], [4,2,1], [5,2,1], [6,2,1], [7,2,1] ]);
			levelData 	= LevelMaker.create( 5, 2, 0, path, spawns, "Our neighbor's dogs smell our sushi!" );
			
			var levels:Vector.<LevelData> = new Vector.<LevelData>();
			levels.push( levelData );
			
			gameData[ Config.GAMEDATA_LEVELS ] = levels;
		}
		
		override public function handleStarlingReady():void
		{
			Resources.initialize();
			
			// Remove default keyboard key actions and hook up our custom keyboard.
			_input.keyboard.destroy();
			_input.keyboard = new Keyboard("drgKeyboard");
		
			//this.state = new ShellState();
			this.state = new EditState();
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