package  
{
	/**
	 * Pathing node
	 */
	public class Node 
	{
		public var x:Number = -1;
		public var y:Number = -1;
	
		/// CTOR
		public function Node( x:Number = -1, y:Number = -1 ):void
		{
			this.set(x, y);
		}
		
		public function toString():String
		{
			return String(x) + "," + String(y);
		}
		
		public function set( x:Number, y:Number ):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function isSet():Boolean
		{
			return x != -1 && y != -1;
		}
	}

}