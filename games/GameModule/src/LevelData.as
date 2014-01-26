package  
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import starling.display.Image;
	public class LevelData 
	{
		//private var citrus	:CitrusSprite;
		public var citrusSpriteNum:int = 0;
		
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
		
		
		public function getCitrusObject():CitrusSprite
		{
			var c:CitrusSprite;
			
			switch(citrusSpriteNum)
			{
				case 0: 
					c = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_straight()) } );
					break;

				case 1: 
					c = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_low_curve()) } );
					break;
					
				case 2: 
					c = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_two_bend()) } );
					break;
					
				case 3: 
					c = new CitrusSprite("bg", { x:192, view:Image.fromBitmap(new Resources.level_backtrack()) } );
					break;
			}
			
			return c;
		}
		
		public function clone():LevelData
		{
			var ld:LevelData = new LevelData();
			
			for each( var node:Node in path )
				ld.path.push( node );
				
			for each( var spawn:Spawn in spawns)
				ld.spawns.push( spawn );
				
			for each( var tile:uint in tiles)
				ld.tiles.push( tile );
			
			ld.citrusSpriteNum = this.citrusSpriteNum;
				
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
			const STARTX	:int = 60;
			const STARTY	:int = 80;
			const GRIDX		:int = 2;	// # in grid.
			const GRIDSPACE	:int = 80;	 // spacing
			
			
			var xplacementConsts:Array = [];
			for (var i:int = 0; i < GRIDX; i++)
				xplacementConsts.push( STARTX + (i * GRIDSPACE) );
						
			var v    :Vector.<Cat> = new Vector.<Cat>();
			var total:int = 0;
			var cat  :Cat;
			for (i = 0; i < catType1; ++i ) 
			{
				cat = new Cat(1);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  STARTY + ( int(total / GRIDX) * GRIDSPACE );
				cat.initForEdit();
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType2; ++i ) 
			{
				cat = new Cat(2);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  STARTY + ( int(total / GRIDX) * GRIDSPACE );
				cat.initForEdit();
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType3; ++i ) 
			{
				cat = new Cat(3);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  STARTY + ( int(total / GRIDX) * GRIDSPACE );
				cat.initForEdit();
				v.push( cat );
				total++;
			}
			return v;
		}
		
	}

}
