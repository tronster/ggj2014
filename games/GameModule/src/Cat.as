package  
{
	import citrus.core.CitrusObject;
	import citrus.objects.Box2DPhysicsObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class Cat 
	{
		public var type		:uint;		
		public var x		:Number;
		public var y		:Number;
		public var hp		:int;
		public var maxHp	:int;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:Box2DPhysicsObject;
		
		public var inBattle:Boolean = false;
		public var isPlaced:Boolean = false;
		
		
		public function Cat() 
		{
			
		}
		
	}

}