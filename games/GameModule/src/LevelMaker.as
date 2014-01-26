package  
{
	import citrus.objects.CitrusSprite;
	import starling.display.DisplayObjectContainer;

	/**
	 * ...
	 * @author 
	 */
	public class LevelMaker 
	{
		
		public function LevelMaker() 
		{
			
		}

		static function create( cat1:uint, cat2:uint=0, cat3:uint=0, tiles:Array ):LevelData
		{
			var ld:LevelData = new LevelData();
			ld.catType1 = cat1;
			ld.catType2 = cat2;
			ld.catType3 = cat3;
			ld.objectiveText = "Stop all the dogs from taking our sushi!";
			
			return ld;
		}
		
		
		static function getView( ld:LevelData ):DisplayObjectContainer
		{
			//var cs:CitrusSprite
			var doc:DisplayObjectContainer = new DisplayObjectContainer();
			
			const WIDTH		:uint = 7;	// last column is off-screen
			const HEIGHT	:uint = 5;
			
			for (var y:int = 0; y < HEIGHT; ++y )
			{
				
			}
			
			
			return doc;
		}
		

		
	}

}