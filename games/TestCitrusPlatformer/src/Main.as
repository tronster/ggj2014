package 
{
	import citrus.core.starling.StarlingCitrusEngine;
	import flash.display.Loader;
	import flash.events.Event;
	import drg.Keyboard;
	import flash.net.URLRequest;
	
	
	[SWF(frameRate="60")]
	public class Main extends StarlingCitrusEngine 
	{
		private var loader:Loader;
		
		
		/// Step 1
		public function Main():void 
		{
			super();
			gameData = new Inventory();
			gameData.dataChanged.add( onInventoryChange );
		}
		
		
		/// Step 2: Callback from Citrus when its ready.
		override public function initialize():void
		{			
			setUpStarling(true);
		}
		
		
		/// Step 3: Display system is ready 
		override public function handleStarlingReady():void
		{
			Resources.initialize();
			
			// Remove default keyboard key actions and hook up our custom keyboard.
			_input.keyboard.destroy();
			_input.keyboard = new drg.Keyboard("drgKeyboard");
			
			state = new Shell();

			/// Load in background
			loader = new Loader;
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoad );
			loader.load( new URLRequest("assets/level1.swf") );
		}
		
		protected function onLoad( e:Event ):void
		{
			// TODO: Use citrus.utils.LevelManager			
			
			Global.level = new Level1( e.target.loader.content );
			loader.removeEventListener(Event.COMPLETE, onLoad);
			loader.unloadAndStop(true);
			
			gameData["sword"] = 321;
		}
		
		
		private function onInventoryChange( name:String, value:* ):void
		{
			trace("Yo, I just had a inventory change for '" + name + "' of value: " + value );
			trace("Proof in the pudding: " + gameData["sword"] );
		}
	}
	
}