package  
{
	import adobe.utils.CustomActions;
	import aze.motion.EazeTween;
	import aze.motion.eaze;
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.ICitrusArt;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class EditState extends StarlingState
	{
		public var bg			:CitrusSprite;
		public var bgGrass		:CitrusSprite;
		public var goButton		:Button;
		public var levelData	:LevelData;
		public var testObj		:Box2DPhysicsObject;
		public var cats			:Vector.<Cat>;
		
		
		public var sa:AnimationSequence;
		
		
		/// CTOR
		public function EditState() 
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			box2D.visible = false;
			box2D.gravity = new b2Vec2(0, 0);
			add( box2D );
			
			
			bg = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			add( bg );

			bgGrass = new CitrusSprite("bgGrass", { x:192, view:Image.fromBitmap(new Resources.bgGrass()) } );
			add( bgGrass );
		
			
			goButton = new Button(
				Resources.getAtlas().getTexture("button"),
				"Go",
				Resources.getAtlas().getTexture("button hover"));

			goButton.x = 0;
			goButton.y = stage.stageHeight - 100;
			goButton.addEventListener(Event.TRIGGERED, onGoButtonTriggered);
			addChild( goButton );
			
			//var sa:AnimationSequence = new AnimationSequence( Resources.getAtlas("Cat1Victory"), ["Cat1Victory"], "Cat1Victory", 30, true );
			var testObj:Box2DPhysicsObject = new Box2DPhysicsObject("enemy", { x:500, y:500, view:Resources.getView("Cat1Victory") } );
			add(testObj);
						
			getCurrentLevelData();
			
			for each( var cat:Cat in cats )
			{
				add( cat.playArt );
				add( cat.sensor );				
			}
			
		}
		
		
		private function onGoButtonTriggered( e:Event ):void
		{
			goButton.removeEventListener(Event.TRIGGERED, onGoButtonTriggered);
			// TRON: This crashes after a few state returns, looks like added physics objects aren't being cleaned up.
			//	_ce.futureState = new BattleState();
			//	eaze(this).to( 1.5, {alpha:0});
			
			_ce.gameData[Config.ACTIVE_CATS] 	= cats;
			_ce.gameData[Config.CURRENT_LEVEL]	= levelData;
			
			_ce.state = new BattleState();
		}
		
		
		/// Shawn you may want this.
		public function getCurrentLevelData():void
		{
			var levelNum:int = _ce.gameData[Config.CURRENT_LEVEL_NUM];
			if ( levelNum < 1 )
			{
				error("Invalid level number, using 1 instead of " + levelNum);
				levelNum = 1;
			}
			
			levelData	= ( _ce.gameData[ Config.GAMEDATA_LEVELS ][levelNum - 1] ); // .clone();
			cats 		= levelData.makeFreshCats();
		}
		
	}

}