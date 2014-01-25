package  
{
	import citrus.objects.Box2DPhysicsObject;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author 
	 */
	public class Dog 
	{
		public var type		:uint;
		public var x		:Number;
		public var y		:Number;
		public var hp		:int;
		public var maxHp	:int;

		
		public var editArt:Box2DPhysicsObject;
		public var playArt:Box2DPhysicsObject;
		
		public var inBattle:Boolean = false;

		public var previousNode	:Point;
		public var targetNode	:Point;
		
		public function Dog() 
		{
			
		}
		
	}

}