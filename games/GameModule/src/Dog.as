package  
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.CitrusEngine;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
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
		public var hp		:Number;
		public var maxHp	:Number;
		public var movementSpeed:Number = 3;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:DogPhysicsObject;
		
		public var inBattle:Boolean = false;
		public var isActive:Boolean = true;
		public var reachedNode:Boolean = false;
		
		public var previousNode	:Node;
		public var targetNode	:Node;
		
		public function Dog(type:uint) 
		{
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			playArt = new DogPhysicsObject(this, "dogs_playart", { x:x, y:y, width:128, height:128} );
			//playArt.view = "../embed/Dog1.swf";
			
			var tempAnima:AnimationSequence =  Resources.getViewWithMultipleAtlas(["Dog" + type + "Left", 
																					"Dog" + type + "Right", 
																					"Dog" + type + "Up", 
																					"Dog" + type + "Down"]);
			playArt.view = tempAnima;
		}
		
		public function destroy():void
		{
			var state:BattleState = CitrusEngine.getInstance().state as BattleState;
			
			state.remove(playArt);
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
			}else if(isActive){
				//calculate distance to move to next node
				if (distX > movementSpeed) 
				{
					distX = movementSpeed;
					AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Right", true);
					//CitrusEngine.getInstance().state.remove(playArt);
					//playArt.view = Resources.getView("Dog" + this.type + "Right");
				}else if (distX < -movementSpeed) 
				{
					distX = -movementSpeed;
					AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Left", true);
					//CitrusEngine.getInstance().state.remove(playArt);
					//playArt.view = Resources.getView("Dog" + this.type + "Left");
				}
					
				//handle verticial movement
				if (distY > movementSpeed) 
				{
					distY = movementSpeed;
					AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Down", true);
					//CitrusEngine.getInstance().state.remove(playArt);
					//playArt.view = Resources.getView("Dog" + this.type + "Down");
				}else if (distY < -movementSpeed) 
				{
					distY = -movementSpeed;
					AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Up", true);
					//CitrusEngine.getInstance().state.remove(playArt);
					//playArt.view = Resources.getView("Dog" + this.type + "Up");
				}
				
				this.x += distX;
				this.y += distY;
				//raise flag if the dog has reached this node
				if (distX == 0 && distY == 0) reachedNode = true;
				
				playArt.visible = true;
			}
			
			//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Left");
			var name:Vector.<String> = AnimationSequence(playArt.view).getAnimationNames();
			trace(name[0], name.length, AnimationSequence(playArt.view).mcSequences[name[0]].currentFrame);
				
			playArt.x = this.x;
			playArt.y = this.y;
		}
		
		public function setNode(node:Node):void
		{
			previousNode = targetNode;
			targetNode = node;
			reachedNode = false;
		}
	}

}