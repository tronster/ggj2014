package  
{
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
	import starling.display.Image;
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
		
		public var editArt:CatPhysicsObject;
		public var playArt:CatPhysicsObject;
		public var sensor:ExtendedBox2dSensor;
		
		public var inBattle:Boolean = false;
		public var isActive:Boolean = true;
		public var isPlaced:Boolean = false;
		
		private static var id:uint = 0;
		
		private var strType:String;
		private var frameNum:int;
		private var frameDur:Number;
		public var state:String;
		
		public function Cat(type:uint) 
		{
			id++;
			
			this.type = type;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			frameDur = 0;
			strType = "Cat" + type;
			frameNum = 1;
			state = Config.READY;
			
			sensor = new ExtendedBox2dSensor("cat_sensor" + id, {x:x, y:y, width:65, height:90});
			sensor.onBeginContact.add(onSensorCollide);
			
			editArt = new CatPhysicsObject(this, "editCat" + id, { x:x, y:y, width:60, height:60 } );
			editArt.view = Resources.getView("Cat" + type + "Idle");
			
			playArt = new CatPhysicsObject(this, "cat" + id, { x:x, y:y, width:50, height:50 } );
			playArt.view = new Image(Resources.getAtlas(strType + state).getTexture(strType + state + "01"));		//easier to just put the '0' here
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
					if (!isActive) state = Config.DEFEAT;
				}
			
			handlePlayArtAnimation(timeDelta);
			
			playArt.x = this.x;
			playArt.y = this.y;
			sensor.x = this.x;
			sensor.y = this.y;
			
			editArt.x = this.x;
			editArt.y = this.y;
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
					frameNum = 1;
					strFrameNum = "01";
					texture = Resources.getAtlas(strType + state).getTexture(strType + state + strFrameNum);
				}
				img.texture = texture;
				frameDur = 0;
			}
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
			trace("Cat's Sensor has Collided with " + Box2DUtils.CollisionGetOther(sensor, contact));
		}
	}

}