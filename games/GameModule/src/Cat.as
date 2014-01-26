package  
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.IState;
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class Cat 
	{
		public var type		:uint;		
		public var x		:Number;
		public var y		:Number;
		public var hp		:int;
		public var maxHp	:int;
		
		public var editArt:Box2DPhysicsObject;
		public var playArt:Box2DPhysicsObject;
		
		public var inBattle:Boolean = false;
		public var isActive:Boolean = true;
		public var isPlaced:Boolean = false;
		public var sensor:Sensor;
		
		public function Cat(type:uint) 
		{
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			playArt = new Box2DPhysicsObject("dog", {x:x, y:y} );
			playArt.view = "assets/battle_cat.swf";
			sensor = new Sensor("cat_sensor", {x:x, y:y, width:128, height:128});
			sensor.onBeginContact.add(onSensorCollide);
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
					state.add(battle);
					state.add(battle.catHealth);
					state.add(battle.dogHealth);
					BattleState(state).addBattleObject(battle);
				}
			}
			trace("Cat's Sensor has Collided with " + Box2DUtils.CollisionGetOther(sensor, contact));
		}
		
		private function goInBattle(dog:Dog):void 
		{
			
		}
		
		public function init():void
		{
			playArt.x = this.x;
			playArt.y = this.y;
			sensor.x = this.x;
			sensor.x = this.y;
		}
		
		public function update(timeDelta:Number):void
		{
			if (inBattle) playArt.visible = false;
				else if(isActive) playArt.visible = true;
				
			playArt.x = this.x;
			playArt.y = this.y;
			sensor.x = this.x;
			sensor.y = this.y;
		}
	}

}