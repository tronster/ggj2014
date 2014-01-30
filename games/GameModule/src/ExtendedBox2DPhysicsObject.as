package  
{
	import citrus.objects.Box2DPhysicsObject;
	import citrus.physics.box2d.Box2D;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class ExtendedBox2DPhysicsObject extends Box2DPhysicsObject
	{
		
		/**
		 * Creates a Box2DPhysicsObject that has some additional functionality
		 * @param	name
		 * @param	params
		 */
		public function ExtendedBox2DPhysicsObject(name:String, params:Object=null) 
		{
			super(name, params);
		}
		
		/**
		 * Changes this Physics Object Box2d reference to the engine's current Box2d reference
		 */
		public function changeBox2d():void
		{
			this._box2D = _ce.state.getFirstObjectByType(Box2D) as Box2D;
		}
		
	}

}