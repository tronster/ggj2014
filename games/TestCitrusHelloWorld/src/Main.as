package 
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	public class Main extends StarlingCitrusEngine 
	{
		public function Main()
		{
			super();
	        setUpStarling(true);
		}
		
		/// Will callback when context 3D in starling is setup.
		override public function handleStarlingReady():void 
		{	
			state = new MenuState();
		}
	
	}
}