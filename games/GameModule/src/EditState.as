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
	import flash.events.MouseEvent;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class EditState extends StarlingState
	{
		public var levelbg		:CitrusSprite;
		public var bg			:CitrusSprite;
		public var bgGrass		:CitrusSprite;
		public var sidescroll	:CitrusSprite;
		public var commander	:Box2DPhysicsObject;
		public var goButton		:Button;
		public var levelData	:LevelData;
		public var cats			:Vector.<Cat>;
		public var draggedCat	:Cat;
		
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
			
			getCurrentLevelData();
			
			levelbg = levelData.getCitrusObject()
			add( levelbg );

			/*
			bgGrass = new CitrusSprite("bgGrass", { x:192, view:Image.fromBitmap(new Resources.bg()) } );
			add( bgGrass );
			*/
			sidescroll = new CitrusSprite("sidescroll", { x:0, y:0, view:Image.fromBitmap(new Resources.sidescroll()) } );
			add( sidescroll );
		
			
			goButton = new Button(
				Resources.getAtlas().getTexture("button"),
				"Go",
				Resources.getAtlas().getTexture("button hover"));
			goButton.x = 0;
			goButton.y = stage.stageHeight - 100;
			goButton.useHandCursor = true;
			goButton.addEventListener(Event.TRIGGERED, onGoButtonTriggered);
			addChild( goButton );
			
			var commander:Box2DPhysicsObject = new Box2DPhysicsObject("CommanderCatCute", { x:170, y:490, view:Resources.getView("CommanderCatCute") } );
			add(commander);
			
			
			// Place on the stage
			for each( var cat:Cat in cats )
			{
				add( cat.editArt );
				//add( cat.sensor );
				
				//cat.editArt.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			
			_ce.sound.playSound("editMusic");
			
			stage.touchable = true;
			stage.addEventListener( TouchEvent.TOUCH, onTouch );
		}
		
		private function onTouch( e:TouchEvent ):void
		{
			var touch:Touch = e.getTouch( stage );
			if (touch == null )
				return;
				
			switch( touch.phase )
			{
				case TouchPhase.BEGAN:
					var targetCat:Cat = null;
					var cat:Cat;
					for (var i:int = 0; i < cats.length; ++i )
					{	
						cat = cats[i];
						var hw:int = (cat.editArt.width / 2); //half width
						var hh:int = (cat.editArt.height / 2); //half height						
						if (touch.globalX > cat.editArt.x - hw && touch.globalX < cat.editArt.x + hw)
						{
							if (touch.globalY > cat.editArt.y - hh && touch.globalY < cat.editArt.y + hh )
							{
								targetCat = cat;
								_ce.sound.playSound("catPickupSfx");
								break;
							}
						}
					}
					draggedCat = targetCat;
					if ( draggedCat != null )	// ??TRON debug
						trace("Picking up  : " + draggedCat.editArt.ID );
					else
						trace("No cat to picjk up!");
					break;
					
				case TouchPhase.ENDED:
					_ce.sound.playSound("catDropSfx");
					if ( draggedCat != null )	// ??TRON debug
						trace("Putting down: " + draggedCat.editArt.ID );
					draggedCat = null;
					break;
				
				case TouchPhase.MOVED:
					if ( draggedCat != null )	// ??TRON debug
						trace("dragging    : " + draggedCat.editArt.ID );
						
					if ( draggedCat != null )
					{
						draggedCat.editArt.x = touch.globalX;
						draggedCat.editArt.y = touch.globalY;
					}
					break;
			}			
		}
		
		
		
		private function onGoButtonTriggered( e:Event ):void
		{
			goButton.removeEventListener(Event.TRIGGERED, onGoButtonTriggered);
			// TRON: This crashes after a few state returns, looks like added physics objects aren't being cleaned up.
			//	_ce.futureState = new BattleState();
			//	eaze(this).to( 1.5, {alpha:0});
			
			/*for each( var cat:Cat in cats )
			{
				remove(cat.sensor);
			}*/
			
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
		

		override public function destroy():void
		{
			remove(levelbg);
			
			//_ce.sound.crossFade();
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.removeEventListeners();
		}
		
	}

}