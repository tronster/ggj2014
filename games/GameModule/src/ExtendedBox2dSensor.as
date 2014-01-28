package  
{
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class ExtendedBox2dSensor extends Sensor
	{
		
		public function ExtendedBox2dSensor(name:String, params:Object=null) 
		{
			super(name, params);
		}
		
		public function changeBox2d():void
		{
			this._box2D = _ce.state.getFirstObjectByType(Box2D) as Box2D;
		}
		
	}

}