package  
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	/**
	 * ...
	 * @author 
	 */
	public class LevelMaker 
	{
		

		static public function create( cat1:uint, cat2:uint, cat3:uint, tiles:Array, spawns:Array ):LevelData
		{
			var ld:LevelData 	= new LevelData();
			ld.catType1 		= cat1;
			ld.catType2 		= cat2;
			ld.catType3 		= cat3;
			ld.objectiveText 	= "Stop all the dogs from taking our sushi!";
			
			var i:int = 0;
			for (i = 0; i < tiles.length; i++ )		ld.tiles.push( tiles[i] );
			for (i = 0; i < spawns.length; i++ )	ld.spawns.push( spawns[i] );
			
			return ld;
		}
		
		
		/// Add up to 3 spawns at a time to an existing collection.
		static public function addSpawns( spawns:Array, type1:int, time1:int, type2:int = -1, time2:int = -1, type3:int = -1, time3:int = -1 ):Array
		{
			if ( spawns == null ) spawns = [];
			spawns.push( new Spawn( type1, time1 ));
			
			if ( type2 != -1 && time2 != -1 )
				spawns.push( new Spawn( type2, time2 ));
			
			if ( type3 != -1 && time3 != -1 )
				spawns.push( new Spawn( type3, time3 ));			
			
			return spawns;
		}
		
		
		static public function getView( ld:LevelData ):DisplayObjectContainer
		{
			//var cs:CitrusSprite
			var doc:DisplayObjectContainer = new DisplayObjectContainer();
			
			const WIDTH		:uint = 7;	// last column is off-screen
			const HEIGHT	:uint = 5;
			var tileType	:int = 0;
			
			for (var y:int = 0; y < HEIGHT; ++y )
			{
				for (var x:int = 0; x < WIDTH; ++x )
				{
					tileType = ld.tiles[ (y * WIDTH) + x ];
					switch( tileType )
					{
						case Config.TILE_NONE:
//							img = 
							break;
					}
				}
			}
			
			var cs:CitrusSprite;
			cs = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			doc.addChild( cs.view );
			
			return doc;
		}
		

		
	}

}