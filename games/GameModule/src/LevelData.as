package  
{
	import citrus.core.CitrusEngine;
	import citrus.objects.CitrusSprite;
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	public class LevelData 
	{
		public var width	:uint;  // in tiles
		public var height	:uint;	// in tiles

		public var catType1 :uint;
		public var catType2 :uint;
		public var catType3 :uint;

		public var citrusSpriteNum:int = 0;	// DEPRECATED: background
		
		public var path		:Vector.<Node>;
		public var spawns	:Vector.<Spawn>; 
		public var tiles	:Array2d;
		
		
		public var objectiveText:String = "not set";

		private var cloneCount	:int = 0;	// for debugging
		
		
		/// CTOR
		public function LevelData( width:int, height:int ) 
		{	
			this.width	= width;
			this.height	= height;
			
			path 	= new Vector.<Node>();
			spawns 	= new Vector.<Spawn>();
			tiles	= new Array2d( width, height );
		}
		
		/// Duplicate this level data
		public function clone():LevelData
		{
			var ld:LevelData = new LevelData( this.width, this.height );
			
			for each( var node:Node in path )
				ld.path.push( node );
				
			for each( var spawn:Spawn in spawns)
				ld.spawns.push( spawn );
				
			ld.tiles = tiles.clone();
			
			ld.citrusSpriteNum = this.citrusSpriteNum;
				
			ld.objectiveText= this.objectiveText;
			ld.cloneCount 	= this.cloneCount + 1;
			if ( ld.cloneCount > 1 )
				error("You just cloned a cloned levelData with text '" + objectiveText + "'");
			
			return ld;
		}
		
		
		/// Creates vector of cats based on #'s passed in.
		/// Initial position is in a grid.
		public function getCatsAsVector() :Vector.<Cat>
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
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType2; ++i ) 
			{
				cat = new Cat(2);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  STARTY + ( int(total / GRIDX) * GRIDSPACE );
				v.push( cat );
				total++;
			}
			
			for (i = 0; i < catType3; ++i ) 
			{
				cat = new Cat(3);
				cat.x = xplacementConsts[ total % GRIDX];
				cat.y =  STARTY + ( int(total / GRIDX) * GRIDSPACE );
				v.push( cat );
				total++;
			}
			return v;
		}
		
		
		/// Obtain graphical representation of level
		public function getViewBackground():Sprite
		{
			var container:Sprite = new Sprite();
			container.name = "bgContainer";
			
			var img:Image;
			
			for (var y:int = 0; y < height; ++y )
			{
				for (var x:int = 0; x < width; ++x )
				{
					img = makeTileImageFromXY(x,y);
					container.addChild( img );
					img.x = x * img.width;
					img.y = y * img.height;
				}
			}
			
			return container;
		}
		
		private function makeTileImageFromXY( x:int, y:int ):Image
		{
			var img:Image;

			var tileType:int = tiles.at(x, y);
			switch( tileType )
			{
				default:
				case Config.TILE_NONE:
					img = Image.fromBitmap( new Resources.tile_grass() );
					break;
					
				case Config.TILE_PATH_STRAIGHT:
					img = Image.fromBitmap( new Resources.tile_path_straight() );
					break;
					
				case Config.TILE_PATH_VSTRAIGHT:
					img = Image.fromBitmap( new Resources.tile_path_vstraight() );
					break;
					
				case Config.TILE_PATH_TOP_RIGHT:
					img = Image.fromBitmap( new Resources.tile_path_top_right() );			
					break;
					
				case Config.TILE_PATH_BOTTOM_RIGHT:
					img = Image.fromBitmap( new Resources.tile_path_bottom_right() );			
					break;
					
				case Config.TILE_PATH_TOP_LEFT:
					img = Image.fromBitmap( new Resources.tile_path_top_left() );			
					break;
					
				case Config.TILE_PATH_BOTTOM_LEFT:
					img = Image.fromBitmap( new Resources.tile_path_bottom_left() );			
					break;
			
				case Config.TILE_SUSHI:
					// TODO: Add
					img = Image.fromBitmap( new Resources.tile_path_straight() );
					break;
			}
			
			img.name = makeTileNameFromXY(x, y);
			
			return img;
		}

		
		/// Helper
		private function makeTileNameFromXY( x:int, y:int ):String
		{
			return "tile" + String(x) + "-" + String(y);
		}
		
		
		
		
	}

}
