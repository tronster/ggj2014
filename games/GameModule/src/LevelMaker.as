package  
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import starling.display.Image;


	
	public class LevelMaker 
	{	
		static public function foo():void
		{
		}
				
		static public function create( rawLevelData:Array, cats:Array, path2:Vector.<Node>, spawns:Array, txt:String = "" ):LevelData
		{			
			const HEADER_LENGTH:int = 5;
			
			assert( rawLevelData.length > HEADER_LENGTH, "Invalid level data sent to LevelMaker!" );
			
			var width	:int = rawLevelData[0];
			var height	:int = rawLevelData[1];
			var startx	:int = rawLevelData[2];
			var starty	:int = rawLevelData[3];
			var tileSize:int = rawLevelData[4];
			
			var ld:LevelData 	= new LevelData(width, height);
			ld.catType1 		= valueOrZero( cats[0] );
			ld.catType2 		= valueOrZero( cats[1] );
			ld.catType3 		= valueOrZero( cats[2] );
			ld.objectiveText 	= (txt.length > 0) ? txt : "Stop our neighbor's dogs from taking our sushi!";
			//ld.path				= path;
			
			// Copy 1d array into 2d structure
			var x:int;
			var y:int;
			var value:uint;
			var endNode:Node = new Node( -1, -1 );
			for (y = 0; y < height; ++y )
			{
				for (x = 0; x < width; ++x)
				{
					value = rawLevelData[ HEADER_LENGTH + (x + (y * width)) ];
					ld.tiles.put( x, y, value ); 
					
					// Ending tile?  Note where it's at
					if ( value == Config.TILE_SUSHI )
					{
						endNode.set( x, y );
					}
				}
			}
			
			assert( endNode.isSet(), "No end node was found in level data!" );
						
			// Find path in 2d structure, starting from the end goal working back to the start...
			
			// Track visisted tiles
			var visited:Array2d = new Array2d( width, height );
			visited.fill( false );
			
			var currentNode	:Node 			= endNode;
			var tile		:int			= 0;
			var path		:Vector.<Node> 	= new Vector.<Node>();
			var isBuilding	:Boolean 		= true;

			while ( isBuilding )
			{
				path.push( currentNode );
				visited.put( currentNode.x, currentNode.y, true );
				
				tile = ld.tiles.at(currentNode.x, currentNode.y);
				
				switch( tile )
				{
					default:
						assert( false, "Unknown tile type found in building level nodes, value: " + tile );
						isBuilding = false;
						break;
						
					case Config.TILE_NONE:
						assert( false, "Starting tile wasn't found in making level nodes." );
						isBuilding = false;
						break;
						
					case Config.TILE_PATH_STRAIGHT:
						if ( visited.at( currentNode.x - 1, currentNode.y ) )
							currentNode = new Node( currentNode.x + 1, currentNode.y );
						else
							currentNode = new Node( currentNode.x - 1, currentNode.y );
						break;
						
					case Config.TILE_PATH_VSTRAIGHT:
						if ( visited.at( currentNode.x, currentNode.y + 1 ) )
							currentNode = new Node( currentNode.x, currentNode.y - 1 )
						else
							currentNode = new Node( currentNode.x, currentNode.y + 1 )						
						break;
						
					case Config.TILE_PATH_TOP_RIGHT:
						if ( visited.at( currentNode.x, currentNode.y - 1 ) )
							currentNode = new Node( currentNode.x + 1 , currentNode.y );
						else
							currentNode = new Node( currentNode.x, currentNode.y - 1 );
						break;
						
					case Config.TILE_PATH_BOTTOM_RIGHT:
						if ( visited.at( currentNode.x + 1, currentNode.y ) )
							currentNode = new Node( currentNode.x, currentNode.y + 1);
						else
							currentNode = new Node( currentNode.x + 1, currentNode.y );
						break;
						
					case Config.TILE_PATH_TOP_LEFT:
						if ( visited.at( currentNode.x, currentNode.y - 1) )
							currentNode = new Node( currentNode.x - 1, currentNode.y );
						else
							currentNode = new Node( currentNode.x, currentNode.y - 1 );
						break;
						
					case Config.TILE_PATH_BOTTOM_LEFT:
						if ( visited.at( currentNode.x - 1, currentNode.y ) )
							currentNode = new Node( currentNode.x, currentNode.y + 1 );
						else 
							currentNode = new Node( currentNode.x - 1, currentNode.y );
						break;
					
					case Config.TILE_DOG_START:
						isBuilding = false;
						currentNode = null;
						break;
						
					case Config.TILE_SUSHI:
						currentNode = new Node( currentNode.x + 1, currentNode.y );
						break;
						
				}
				
				if ( currentNode )
				{
					// Mark nodes we already visisted.
					assert( !visited.at( currentNode.x, currentNode.y ), "Already visisted tile " + currentNode.x + ", " + currentNode.y + " when build nodes.");
				}
				else
				{
					assert( !isBuilding, "NULL current node but still building node path! Wat?" );
				}
				
			} // END for nodes
			
			
			var i:int = 0;
			
			// Nodes in path list are in grid coordiantes, need to put them
			// into screen space coordinates...
			for ( i = 0; i < path.length; ++i )
			{
				path[i].x = startx + (tileSize/2) + ( path[i].x * tileSize );
				path[i].y = starty + (tileSize/2) + ( path[i].y * tileSize );
			}			
			ld.path = path;
			
			for (i = 0; i < spawns.length; i++ )
				ld.spawns.push( spawns[i] );
			
			return ld;
		}
		
		
		/// Helper
		static private function valueOrZero( val:* ):int
		{
			if ( val == null ) return 0;
			else return int(val);
		}
		
		
		/// Add up to 3 spawns at a time to an existing collection.
		static public function makeSpawns( spawns:Array, type1:int, time1:int, type2:int = -1, time2:int = -1, type3:int = -1, time3:int = -1 ):Array
		{
			if ( spawns == null ) spawns = [];
			spawns.push( new Spawn( type1, time1 ));
			
			if ( type2 != -1 && time2 != -1 )
				spawns.push( new Spawn( type2, time2 ));
			
			if ( type3 != -1 && time3 != -1 )
				spawns.push( new Spawn( type3, time3 ));			
			
			return spawns;
		}
		
		/// array of triple arrays
		/// first node is end point, work to end of screen
		static public function makePath( arr:Array ) :Vector.<Node>
		{
			const START_X	:uint = 192;
			const START_Y	:uint = 0;
			const TILE_SIZE	:uint = 128;
			
			var path:Vector.<Node> = new Vector.<Node>();
			var node:Node;
			
			for (var i:int = 0; i < arr.length; ++i)
			{
				if (arr[i].length != 3 )
				{
					error("makePath has an invalid path node, need 3 data go " + arr[i].length );
					continue;
				}
				
				var x:Number 	= arr[i][0];
				var y:Number 	= arr[i][1];
				var t:uint 		= arr[i][2];
				
				node = new Node();
				node.x 		= START_X + (TILE_SIZE/2) + (x * TILE_SIZE);
				node.y 		= START_Y + (TILE_SIZE/2) + (y * TILE_SIZE);
				
				path.push( node );
			}
			return path;
		}
		
		
		static private function tileName(x:int, y:int):String
		{
			return "tile" + String(x) + "-" + String(y);
		}
		
		static private function tileParams( cls:Class ):Object
		{
			return { view:Image.fromBitmap( new cls() ) } ;
		}
		
	}

}