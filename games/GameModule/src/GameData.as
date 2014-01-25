package  
{
	import citrus.utils.AGameData;

	
	public class GameData extends AGameData
	{		
		
		public function GameData() 
		{
			this[ Config.GAMEDATA_LEVELS ] 	 	= new Vector.<LevelData>();	
			this[ Config.CURRENT_LEVEL_NUM ]	= 1;
		}
		
	}

}