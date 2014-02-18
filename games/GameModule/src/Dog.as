package  
{
	import citrus.core.CitrusEngine;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	
	/**
	 * ...
	 * @author 
	 */
	public class Dog 
	{		
		public var type			:uint;
		public var x			:Number;
		public var y			:Number;
		public var hp			:Number;
		public var maxHp		:Number;
		public var movementSpeed:Number = 1.8;
		
		public var editArt		:Box2DPhysicsObject;
		public var playArt		:DogPhysicsObject;
		
		public var inBattle		:Boolean = false;
		public var doDeath		:Boolean = false;
		public var isActive		:Boolean = true;
		public var reachedNode	:Boolean = false;
		
		public var previousNode	:Node;
		public var targetNode	:Node;
		
		private var strType		:String;
		private var state		:String;
		private var sequence		:AnimationSequence;
		
		
		
		/// CTOR
		/// @param type is 1,2, or 3 (paper, rock, sissors)
		public function Dog(type:uint) 
		{
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			
			//playArt.view = "../embed/Dog1.swf";
			strType = "Dog" + type;
			state = Config.LEFT;
			
			//set up playArt's view
			sequence = Resources.getViewWithMultipleAtlas([	
				strType + Config.LEFT, 
				strType + Config.RIGHT, 
				strType + Config.UP,
				strType + Config.DOWN, 
				strType + Config.DEFEAT
				], 24);
			sequence.onAnimationComplete.add(playArtAnimationComplete);
			
			//set up playArt
			playArt = new DogPhysicsObject(this, "dogs_playart", { x:x, y:y, width:90, height:90 } );
			playArt.view = sequence;
			
			var names:Vector.<String> = AnimationSequence(playArt.view).getAnimationNames();
			for each(var str:String in names)
			{
				trace("Animation Name: " + str);
			}
			
			//output all looping animations in within Starling Art, this should be global across the entire game
			StarlingArt.setLoopAnimations([strType + Config.LEFT, strType + Config.RIGHT, strType + Config.UP, strType + Config.DOWN]);
			for each(var obj:Object in StarlingArt.loopAnimation)
			{
				trace("StarlingArt Loops: " + obj);
			}
			
			//playArt.view = new Image(Resources.getAtlas(strType + state).getTexture(strType + state + "01"));		//easier to just put the '0' here
			//playArt.view = tempAnima;
		}
		
		public function destroy():void
		{
			var state:BattleState = CitrusEngine.getInstance().state as BattleState;
			
			state.remove(playArt);
		}
		
		public function stopAnimations():void
		{
			sequence.pauseAnimation( false );
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
					//and determine state based on direction
					if (distX > movementSpeed) 
					{
						distX = movementSpeed;
						state = Config.RIGHT;
					}else if (distX < -movementSpeed) 
					{
						distX = -movementSpeed;
						state = Config.LEFT;
					}
						
					//handle verticial movement
					if (distY > movementSpeed) 
					{
						distY = movementSpeed;
						state = Config.DOWN;
					}else if (distY < -movementSpeed) 
					{
						distY = -movementSpeed;
						state = Config.UP;
					}
					
					this.x += distX;
					this.y += distY;
					//raise flag if the dog has reached this node
					if (distX == 0 && distY == 0) reachedNode = true;					
				}else {
					if (state != Config.DEFEAT)
					{
						state = Config.DEFEAT;
						this.y -= 50;
						this.x += 10;
					}
					
				}
			}
			
			playArt.animation = strType + state;
			playArt.x = this.x;
			playArt.y = this.y;
			//keep the sequence centered on the physics object since the size of the animation may change at any given time
			sequence.x = -sequence.width * .5;
			sequence.y = -sequence.height * .5;
		}
		
		private function playArtAnimationComplete(name:String):void 
		{
			//if the anaimation that has completed is the defeat animation, the dog should no longer be active
			if (name == strType + Config.DEFEAT)
			{
				isActive = false;
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