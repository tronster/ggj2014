package  
{
	public class LevelData 
	{
		public var path		:Vector.<Node>;
		public var spawns	:Vector.<Spawn>; 
		public var tiles	:Vector.<uint>;
		
		public var catType1 :uint;
		public var catType2 :uint;
		public var catType3 :uint;
		
		public var objectiveText:String;
		
		public var cloneCount:int = 0;	// for debugging
		
		
		public function LevelData() 
		{	
			path 	= new Vector.<Node>();
			spawns 	= new Vector.<Spawn>();
			tiles	= new Vector.<uint>();
		}
		
		
		public function clone():LevelData
		{
			var ld:LevelData = new LevelData();
			
			for each( var node:Node in path )
				ld.path.push( path );
				
			for each( var spawn:Spawn in spawns)
				ld.spawns.push( spawn );
				
			for each( var tile:uint in tiles)
				ld.tiles.push( tile );
				
			ld.objectiveText= this.objectiveText;
			ld.cloneCount 	= this.cloneCount + 1;
				
			return ld;
		}
		
	}

}
