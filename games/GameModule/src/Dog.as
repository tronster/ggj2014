package  
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
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
		public var movementSpeed:Number;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:Box2DPhysicsObject;
		
		public var inBattle:Boolean = false;
		
		public var previousNode	:Node;
		public var targetNode	:Node;
		
		public function Dog(type:uint) 
		{
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			playArt = new Box2DPhysicsObject("dog", { x:x, y:y, view:"assets/battle_dog.swf" } );
		}
		
		public function init():void
		{
			this.x = targetNode.x;
			this.y = targetNode.y;
		}
		
		public function update(timeDelta:Number):void
		{
			var distX:Number = this.x - targetNode.x;
			var distY:Number = this.y - targetNode.y;
			
			playArt.x = this.x;
			playArt.y = this.y;
		}
	}

}