package  
{
	/**
	 * ...
	 * @author 
	 */
	public class LevelMaker 
	{
		
		public function LevelMaker() 
		{
			
		}

		static function create( cat1:uint, cat2:uint=0, cat3:uint=0 ):LevelData
		{
			var ld:LevelData = new LevelData();
			ld.catType1 = cat1;
			ld.catType2 = cat2;
			ld.catType3 = cat3;
			ld.objectiveText = "Stop all the dogs from taking our sushi!";
			return ld;
		}
		
		
	}

}