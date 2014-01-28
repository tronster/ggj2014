package  
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.CitrusEngine;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
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
		public var movementSpeed:Number = 1.5;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:DogPhysicsObject;
		
		public var inBattle:Boolean = false;
		public var doDeath:Boolean = false;
		public var isActive:Boolean = true;
		public var reachedNode:Boolean = false;
		
		public var previousNode	:Node;
		public var targetNode	:Node;
		
		private var strType:String;
		private var frameNum:int;
		private var frameDur:Number;
		public var state:String;
		
		public function Dog(type:uint) 
		{
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			
			//playArt.view = "../embed/Dog1.swf";
			frameDur = 0;
			strType = "Dog" + type;
			
			frameNum = 1;
			state = Config.LEFT;
			playArt = new DogPhysicsObject(this, "dogs_playart", { x:x, y:y, width:90, height:90} );
			playArt.view = new Image(Resources.getAtlas(strType + state).getTexture(strType + state + "01"));		//easier to just put the '0' here
			//playArt.view = tempAnima;
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
			playArt.x = this.x;
			playArt.y = this.y;
		}
		
		public function update(timeDelta:Number):void
		{
			var distX:Number = targetNode.x - this.x;
			var distY:Number = targetNode.y - this.y;
			
			if (inBattle)
			{
				playArt.visible = false;
			}else {
				playArt.visible = true;
				
				if (isActive && !doDeath)
				{
					//calculate distance to move to next node
					if (distX > movementSpeed) 
					{
						distX = movementSpeed;
						state = Config.RIGHT;
						//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Right", true);
					}else if (distX < -movementSpeed) 
					{
						distX = -movementSpeed;
						state = Config.LEFT;
						//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Left", true);
					}
						
					//handle verticial movement
					if (distY > movementSpeed) 
					{
						distY = movementSpeed;
						state = Config.DOWN;
						//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Down", true);
					}else if (distY < -movementSpeed) 
					{
						distY = -movementSpeed;
						state = Config.UP;
						//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Up", true);
					}
					
					this.x += distX;
					this.y += distY;
					//raise flag if the dog has reached this node
					if (distX == 0 && distY == 0) reachedNode = true;					
				}else {
					state = Config.DEFEAT;
					Image(playArt.view).scaleX = 2;
					Image(playArt.view).scaleY = 2;
				}
			}
			
			handlePlayArtAnimation(timeDelta);
			//AnimationSequence(playArt.view).changeAnimation("Dog" + type + "Left");
			//var name:Vector.<String> = AnimationSequence(playArt.view).getAnimationNames();
			//trace(name[0], name.length, AnimationSequence(playArt.view).mcSequences[name[0]].currentFrame);
			//var mc:MovieClip = name.length, AnimationSequence(playArt.view).mcSequences[name[0]]
			
			playArt.x = this.x;
			playArt.y = this.y;
		}
		
		private function handlePlayArtAnimation(timeDelta:Number):void
		{
			frameDur += timeDelta;
			var img:Image = playArt.view as Image;
			var strFrameNum:String;
			
			if (frameDur >= Main.TARGET_FRAME_TIME)
			{
				frameNum++;
				strFrameNum = (frameNum < 10) ? "0" + frameNum.toString() : frameNum.toString();
				
				var texture:Texture = Resources.getAtlas(strType + state).getTexture(strType + state + strFrameNum);
				
				if (texture == null)
				{
					if (!doDeath)
					{
						frameNum = 1;
						strFrameNum = "01";
						texture = Resources.getAtlas(strType + state).getTexture(strType + state + strFrameNum);
					}else { 
						isActive = false;
						return;
					}
				}
				
				trace("Dog's Texture Info: ", texture.width, texture.height, texture.scale);
				img.texture = texture;
				frameDur = 0;
			}
		}
		
		public function setNode(node:Node):void
		{
			previousNode = targetNode;
			targetNode = node;
			reachedNode = false;
		}
	}

}