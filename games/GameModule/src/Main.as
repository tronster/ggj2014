package 
{
	import citrus.core.starling.StarlingCitrusEngine;
	import drg.Keyboard;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Shawn
	 */
	public class Main extends StarlingCitrusEngine 
	{
		
		public function Main():void 
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		override public function initialize():void
		{
			setUpStarling(true);
		}
		
		override public  function handleStarlingReady():void
		{
			Resources.initialize();
			
			// Remove default keyboard key actions and hook up our custom keyboard.
			_input.keyboard.destroy();
			_input.keyboard = new Keyboard("drgKeyboard");
			
			state = new Shell();
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}