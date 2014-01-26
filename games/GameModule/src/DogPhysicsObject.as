package  
{
	import citrus.objects.Box2DPhysicsObject;
	
	/**
	 * ...
	 * @author ...
	 */
	public class DogPhysicsObject extends Box2DPhysicsObject
	{
		public var parent:Dog;
		
		public function DogPhysicsObject(parent:Dog, name:String, params:Object = null) 
		{
			this.parent = parent;
			super(name, params);
		}
	}

}