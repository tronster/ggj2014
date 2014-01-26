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
		
		public var objectiveText:String = "not set";
		
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
			if ( ld.cloneCount > 1 )
				error("You just cloned a cloned levelData with text '" + objectiveText + "'");
			
			return ld;
		}
		
		/// Creates vector of cats based on #'s passed in.
		/// Initial position is in a grid.
		public function makeFreshCats() :Vector.<Cat>
		{
			const GRIDX		:int = 3;	// # in grid.
			const GRIDSPACE	:int = 50;	 // spacing
			
			
			var xplacementConsts:Array = [];
			for (var i:int = 0; i < GRIDX; i++)
				xplacementConsts.push( 5 + i * GRIDSPACE );
						
			var v    :Vector.<Cat> = new Vector.<Cat>();
			var total:int = 0;
			var cat  :Cat;
			for (i = 0; i < catType1; ++i ) 
			{
				cat = new Cat(1);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  (total / GRIDX) * GRIDSPACE;
				cat.init();
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType2; ++i ) 
			{
				cat = new Cat(2);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  (total/GRIDX) * GRIDSPACE;
				cat.init();
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType3; ++i ) 
			{
				cat = new Cat(3);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  (total/GRIDX) * GRIDSPACE;
				cat.init();
				v.push( cat );
				total++;
			}
			return v;
		}
		
	}

}
