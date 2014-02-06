package  
{
	import adobe.utils.CustomActions;
	import Box2D.Collision.b2AABB;
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author 
	 */
	public class Cat 
	{
		public var type		:uint;		
		public var x		:Number;
		public var y		:Number;
		public var hp		:Number;
		public var maxHp	:Number;
		public var state:String;
		
		public var editArt:CatPhysicsObject;
		public var playArt:CatPhysicsObject;
		public var sensor:ExtendedBox2dSensor;
		
		public var inBattle:Boolean = false;
		public var isActive:Boolean = true;
		public var isPlaced:Boolean = false;
		
		private var id:uint = 0;
		private var strType:String;
		private var sequence:AnimationSequence;
		
		public function Cat(type:uint) 
		{
			id++;
			
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			strType = "Cat" + type;
			state = Config.READY;
			
			sequence = Resources.getViewWithMultipleAtlas([strType + Config.READY, strType + Config.LOSE]);
			sequence.onAnimationComplete.add(playArtAnimationComplete);
			
			editArt = new CatPhysicsObject(this, "editCat" + id, { x:x, y:y, width:60, height:60 } );
			editArt.view = Resources.getView("Cat" + type + "Idle");
			
			playArt = new CatPhysicsObject(this, "cat" + id, { x:x, y:y, width:50, height:50, view:sequence } );
			StarlingArt.setLoopAnimations([strType + Config.READY, strType + Config.LOSE]);
			
			sensor = new ExtendedBox2dSensor("cat_sensor" + id, {x:x, y:y, width:sequence.width * .75, height:sequence.height});
			sensor.onBeginContact.add(onSensorCollide);
			//playArt.view = new Image(Resources.getAtlas(strType + state).getTexture(strType + state + "01"));		//easier to just put the '0' here
		}
		
		public function stopAnimations():void
		{
			sequence.pauseAnimation( false );
		}
		
		public function initForEdit():void
		{
			editArt.x = this.x;
			editArt.y = this.y;
		}
		
		public function initForBattle():void
		{
			this.x = editArt.x;
			this.y = editArt.y;
			
			playArt.changeBox2d();
			sensor.changeBox2d();
			
			//playArt = new Box2DPhysicsObject("cat" + id, { x:x, y:y } );
			//playArt.view = new Image(Resources.getAtlas(strType + state).getTexture(strType + state + "01"));		//easier to just put the '0' here
			
			//sensor = new Sensor("cat_sensor", {x:x, y:y, width:75, height:90});
			//sensor.onBeginContact.add(onSensorCollide);
		}
		
		public function update(timeDelta:Number):void
		{
			if (inBattle) playArt.visible = false;
				else
				{
					playArt.visible = true;
					if (!isActive) state = Config.LOSE;
				}
			
			playArt.animation = strType + state;
			
			playArt.x = this.x;
			playArt.y = this.y;
			sensor.x = this.x;
			sensor.y = this.y;
			editArt.x = this.x;
			editArt.y = this.y;
			
			//keep the sequence centered on the physics object since the size of the animation may change at any given time
			sequence.x = -sequence.width * .5;
			sequence.y = -sequence.height * .5;
		}
		
		private function onSensorCollide(contact:b2Contact):void 
		{
			var other:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(sensor, contact);
			
			//check if the collision was with a dog's physics object
			if (other is DogPhysicsObject && !inBattle)
			{
				var battle:BattleObject = new BattleObject("battle", this, DogPhysicsObject(other).parent, { x:this.x, y:this.y } );
				
				//make sure the current state is a battle state so we can add a battle object to it
				var state:IState = CitrusEngine.getInstance().state;
				if ((state is BattleState)) 
				{
					CitrusEngine.getInstance().sound.playSound("fightingSfx");
					
					state.add(battle);
					state.add(battle.catHealth);
					state.add(battle.dogHealth);
					BattleState(state).addBattleObject(battle);
				}
			}
			//trace("Cat's Sensor has Collided with " + Box2DUtils.CollisionGetOther(sensor, contact));
		}
		
		private function playArtAnimationComplete(name:String):void 
		{
			
		}
	}

}