package  
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
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
		public var movementSpeed:Number = 3;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:DogPhysicsObject;
		
		public var inBattle:Boolean = false;
		public var reachedNode:Boolean = false;
		
		public var previousNode	:Node;
		public var targetNode	:Node;
		
		public function Dog(type:uint) 
		{
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			playArt = new DogPhysicsObject(this, "dogs_playart", { x:x, y:y, width:128, height:128} );
			//playArt.view = "../embed/Dog1.swf";
			playArt.view = "assets/battle_dog.swf";
		}
		
		public function init():void
		{
			this.x = targetNode.x;
			this.y = targetNode.y;			
		}
		
		public function update(timeDelta:Number):void
		{
			var distX:Number = targetNode.x - this.x;
			var distY:Number = targetNode.y - this.y;
			
			if (inBattle)
			{
				playArt.visible = false;
			}else {
				//calculate distance to move to next node
				if (distX > movementSpeed) distX = movementSpeed;
					else if (distX < -movementSpeed) distX = -movementSpeed;
					
				if (distY > movementSpeed) distY = movementSpeed;
					else if (distY < -movementSpeed) distY = -movementSpeed;
				
				this.x += distX;
				this.y += distY;
				//raise flag if the dog has reached this node
				if (distX == 0 && distY == 0) reachedNode = true;
				
				playArt.visible = true;
			}				
				
			playArt.x = this.x;
			playArt.y = this.y;
		}
		
		public function setNode(node:Node)
		{
			previousNode = targetNode;
			targetNode = node;
			reachedNode = false;
		}
	}

}