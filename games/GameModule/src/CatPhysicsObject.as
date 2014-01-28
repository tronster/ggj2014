package  
{
	import adobe.utils.CustomActions;
	import citrus.core.IState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.physics.box2d.Box2D;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CatPhysicsObject extends ExtendedBox2DPhysicsObject
	{
		public var parent:Cat;
		
		public function CatPhysicsObject(parent:Cat, name:String, params:Object = null) 
		{
			this.parent = parent;
			super(name, params);
		}
	}

}