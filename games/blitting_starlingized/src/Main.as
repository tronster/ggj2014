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
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			setUpStarling(true)
			// entry point
		}
		override public function handleStarlingReady():void
		{
			Resources.init();
			_input.keyboard.destroy();
			_input.keyboard = new Keyboard("drgKeyboard");
			
			this.addEventListener(GameStateEvent.STATE_CHANGE, onStateChange);
			//this.state = new BlittingGameState();
			this.state = new MenuState();
		}
		
		private function onStateChange(e:GameStateEvent):void 
		{
			trace("Main State Change");
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}