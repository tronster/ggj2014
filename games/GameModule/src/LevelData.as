package  
{
	public class LevelData 
	{
		public var path		:Vector.<Node>;
		public var spawns	:Vector.<Spawn>; 
		
		public var catType1 :uint;
		public var catType2 :uint;
		public var catType3 :uint;
		
		public var objectiveText:String;
		
		
		public function LevelData() 
		{	
			path = new Vector.<Node>();
			spawns = new Vector.<Spawn>();
		}
		
		
		public function clone():LevelData
		{
			var ld:LevelData = new LevelData();
			
			for each( var node:Node in path )
				ld.path.push( path );
				
			for each( var spawn:Spawn in spawns)
				ld.spawns.push( spawn );
				
			return ld;
		}
		
	}

}
