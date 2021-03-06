package  
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import starling.display.Image;
	
	
	
	public class Cat 
	{
		public var type		:uint;		
		public var x		:Number;
		public var y		:Number;
		public var prevX:Number;
		public var prevY:Number;
		public var lastGoodX:Number;
		public var lastGoodY:Number;
		public var hp		:Number;
		public var maxHp	:Number;
		public var state	:String;
		
		public var editArt	:CatPhysicsObject;
		public var playArt	:CatPhysicsObject;
		public var sensor	:ExtendedBox2dSensor;
		
		public var inBattle:Boolean = false;
		public var isActive:Boolean = true;
		public var isPlaced:Boolean = false;
		
		private var strType		:String;
		private var contacts	:int;
		private var sequence	:AnimationSequence;

		
		static private var _nextId	:uint = 0;
		private var _id				:uint = 0;
		public function get id()	:uint { return _id; }
		
		
		
		/// CTOR
		public function Cat(type:uint) 
		{
			_id = ++_nextId;
			
			this.type = type;
			contacts = 0;
			x = 0;
			y = 0;
			maxHp = Config.MAX_HP_DOG_1;
			hp = maxHp;
			
			strType = "Cat" + type;
			state = Config.READY;
			
			sequence = Resources.getViewWithMultipleAtlas([strType + Config.READY, strType + Config.LOSE]);
			sequence.onAnimationComplete.add(playArtAnimationComplete);
			
			editArt = new CatPhysicsObject( this, "editCat" + id, { x:x, y:y, width:60, height:60 } );
			editArt.view = Resources.getView("Cat" + type + "Idle");
			
			playArt = new CatPhysicsObject(this, "cat" + id, { x:x, y:y, width:50, height:50, view:sequence } );
			StarlingArt.setLoopAnimations([strType + Config.READY, strType + Config.LOSE]);			
		}
		
		public function toString():String
		{
			return "cat{id:" + _id + ", type:" + type + ", hp:"  + hp + ", contacts: " + contacts + "}";
		}
		
		public function stopAnimations():void
		{
			sequence.pauseAnimation( false );
		}
		
		
		public function initForEdit():void	
		{
			editArt.x = this.x;
			editArt.y = this.y;
			
			if ( sensor )
			{
				sensor.destroy();
				sensor = null;
			}
			sensor = new ExtendedBox2dSensor(
				"cat_sensor" + id, 
				{
					x:x, 
					y:y, 
					width:sequence.width * .75, 
					height:sequence.height * 0.5
				}
			);
			sensor.changeBox2d();
			sensor.onBeginContact.removeAll();
			sensor.onBeginContact.add( onSensorCollideEdit );

			editArt.beginContactCallEnabled = true;
			editArt.endContactCallEnabled	= true;
		}
		
		
		public function handleBeginContact( contact:b2Contact ):void
		{
			if ( isEditing )
			{				
				trace("BeginContact contact: " + contact );
				++contacts;
				
				if (contacts == 2)
				{
					lastGoodX = prevX;
					lastGoodY = prevY;
				}
			}
		}
		
		public function handleEndContact( contact:b2Contact ):void
		{
			if ( isEditing )
			{
				trace("  EndContact contact: " + contact );
				--contacts;
				
				assert(contacts >= 0, "More end contacts than begin contacts for cat: " + this );
				if (contacts < 0 ) 
					contacts = 0;
			}
		}
		
		public function get isColliding():Boolean
		{
			// Kluge: Set to one, as each cat has a sensor which will kick off an initial begin contact.
			return contacts > 1;
		}
		
		public function initForBattle():void
		{
			this.x = editArt.x;
			this.y = editArt.y;
			
			playArt.changeBox2d();
		
			if ( sensor )
			{
				sensor.destroy();
				sensor = null;
			}
			sensor = new ExtendedBox2dSensor("cat_sensor" + id, { x:x, y:y, width:sequence.width * .75, height:sequence.height } );
			sensor.changeBox2d();
			sensor.onBeginContact.removeAll();
			sensor.onBeginContact.add( onSensorCollideBattle );			
			
			editArt.beginContactCallEnabled = false;
			editArt.endContactCallEnabled	= false;
		}
		
		
		private function onSensorCollideEdit( contact:b2Contact ):void 
		{
			var other:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(sensor, contact);
			trace("onSensorCollideEdit: " + other );
		}
				
		
		public function update(timeDelta:Number):void
		{
			if ( isEditing ) 
				updateEdit();
			else
				updatePlay();
		}
		
		
		private function get isEditing():Boolean
		{
			var state:IState = CitrusEngine.getInstance().state;
			return !( state is BattleState );
		}
		
		
		private function updateEdit() :void 
		{	
			if ( !isColliding )
			{
				lastGoodX = prevX;
				lastGoodY = prevY;
				
				prevX = editArt.x;
				prevY = editArt.y;
			}
			
			editArt.x = sensor.x = this.x;
			editArt.y = sensor.y = this.y;
		}
		
		private function updatePlay() :void
		{
			if (inBattle) 
			{
				playArt.visible = false;
			}
			else
			{
				playArt.visible = true;
				if (!isActive) 
					state = Config.LOSE;
			}
			
			playArt.animation 	= strType + state;
			playArt.x 			= sensor.x	= this.x;
			playArt.y 			= sensor.y	= this.y;
			
			// keep the sequence centered on the physics object since the size of the animation may change at any given time
			sequence.x = -sequence.width * .5;
			sequence.y = -sequence.height * .5;
		}
		
		
		private function onSensorCollideBattle(contact:b2Contact):void 
		{
			var other:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(sensor, contact);
			
			//check if the collision was with a dog's physics object
			if (other is DogPhysicsObject && !inBattle)
			{
				var battle:BattleObject = new BattleObject("battle", this, DogPhysicsObject(other).parent, { x:this.x, y:this.y } );
				
				//make sure the current state is a battle state so we can add a battle object to it
				var state:IState = CitrusEngine.getInstance().state;
				if ( state is BattleState ) 
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
		
		public function set alpha( amount:Number ):void 
		{
			var img:AnimationSequence 	= (editArt.view as AnimationSequence);
			img.alpha 					= amount;
			img				= (playArt.view as AnimationSequence);
			img.alpha 		= amount;
		}
	}

}