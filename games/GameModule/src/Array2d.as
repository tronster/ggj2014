package
{
	/**
	 * 2D array implemented by single vector of objects,
	 * 
	 * @example	var arr:Array2d = new Array2d( 2, 3);
	 * 			arr.fill( 0 );
	 *			arr.put(0, 2, "foo");
	 *			arr.put(1, 0, new Bar() );
	 *			trace( arr.at(0, 2) as String );
	 */	
	final public class Array2d
	{
		private var dimx	: int;
		private var dimy	: int;
		private var data	: Vector.< Object >;
		
		public function get width()		:int { return dimx; }
		public function get height()	:int { return dimy; }
		
		/**
		 * CTOR
		 * @param	dimX
		 * @param	dimY
		 */
		public function Array2d( dimX:int, dimY:int  ) 
		{
			this.dimx = dimX;
			this.dimy = dimY;

			allocate();
		}
		
		private function allocate():void {
			data = new Vector.< Object >( dimx * dimy );
		}
		
		public function fill( what:* ) :void {
			for ( var i:int, len:int = dimx * dimy; i < len; ++i )
				data[i] = what;
		}
		
		public function put(x:int, y:int, what:* ):void {
			data[ (y * dimx) + x ] = what;
		}
		
		public function at(x:int, y:int):* {
			return data[ (y * dimx) + x ];
		}
		
		// Duplicate (node objects are not deep copied, references are what are duped)
		public function clone():Array2d
		{
			var dup:Array2d = new Array2d( dimx, dimy );
			for ( var i:int, len:int = dimx * dimy; i < len; ++i )
				dup.data[i] = data[i];
			return dup;
		}
	}

}