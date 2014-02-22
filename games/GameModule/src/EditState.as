package  
{
	import Box2D.Common.Math.b2Vec2;
	import citrus.core.starling.StarlingState;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	import citrus.view.starlingview.AnimationSequence;
	import com.tronster.video.*;
	import flash.events.Event;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	
	public class EditState extends StarlingState
	{
		public var bg			:CitrusSprite;
		public var bgGrass		:CitrusSprite;
		public var sidescroll	:CitrusSprite;
		public var commander	:Box2DPhysicsObject;
		public var goButton		:Button;
		public var levelData	:LevelData;
		public var cats			:Vector.<Cat>;
		public var draggedCat	:Cat;
		private var vs			:VideoStream;
				
		private var sa			:AnimationSequence;
		private var box2D		:Box2D;
		private var videoIsPlaying :Boolean;
		
		
		/// CTOR
		public function EditState() 
		{
			super();
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			//_ce.sound.crossFade();
			_ce.sound.stopAllPlayingSounds();
			_ce.sound.removeEventListeners();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			videoIsPlaying  = false;
			
			box2D 			= new Box2D("box2Dedit");
			box2D.visible 	= Config.SHOW_BOX2D;
			box2D.gravity 	= new b2Vec2(0, 0);
			add( box2D );
			
			bg = new CitrusSprite("bg", { view:Image.fromBitmap(new Resources.bg()) } );
			add( bg );
			
			getCurrentLevelData();

			// Draw the background; wrap it up in a native Citrus Sprite because 
			// Citrus hates us and doesn't play nicely interleaving graphics with
			// native Starling.
			var levelbg	:Sprite = levelData.getViewBackground();
			var levelbgSprite:CitrusSprite = new CitrusSprite("levelbg", { view: levelbg } );
			levelbgSprite.x = 192;
			add( levelbgSprite );
			
			sidescroll = new CitrusSprite("sidescroll", { x:0, y:0, view:Image.fromBitmap(new Resources.sidescroll()) } );
			add( sidescroll );
		
			
			goButton = new Button(
				Resources.getAtlas().getTexture("button"),
				"Go",
				Resources.getAtlas().getTexture("button hover"));
			goButton.x = 0;
			goButton.y = stage.stageHeight - 100;
			goButton.useHandCursor = true;
			goButton.addEventListener( starling.events.Event.TRIGGERED, onGoButtonTriggered);
			addChild( goButton );
			
			var commander:Box2DPhysicsObject = new Box2DPhysicsObject("CommanderCatCute", { x:170, y:490, view:Resources.getView("CommanderCatCute") } );
			add(commander);
			
			
			// Place on the stage
			for each( var cat:Cat in cats )
			{
				cat.initForEdit();
				add( cat.editArt );
				add( cat.sensor  );
			}
			
			
			var tf:TextField = new TextField(300, 200, levelData.objectiveText, "Verdana", 14, 0xffffffff );
			tf.x = 0;
			tf.y = 315;
			addChild( tf );
			
			_ce.sound.playSound("editMusic");
			
			stage.touchable = true;
			stage.addEventListener( TouchEvent.TOUCH, onTouch );
		}
		
		
		
		override public function update(timeDelta:Number):void
		{
			super.update( timeDelta );
			
			for each( var cat:Cat in cats )
				cat.update(timeDelta);
		}
		
		
		private function onTouch( e:TouchEvent ):void
		{
			var touch:Touch = e.getTouch( stage );
			if (touch == null )
				return;
			
				
			switch( touch.phase )
			{
				case TouchPhase.BEGAN:
					
					// Shortcut to quit video if click/touch during play.
					if ( videoIsPlaying )
					{
						switchToBattleState();
						return;
					}
					
					var targetCat:Cat = null;
					var cat:Cat;
					for (var i:int = 0; i < cats.length; ++i )
					{	
						cat = cats[i];
						var hw:int = (cat.editArt.width / 2); //half width
						var hh:int = (cat.editArt.height / 2); //half height						
						if (touch.globalX > cat.x - hw && touch.globalX < cat.x + hw)
						{
							if (touch.globalY > cat.y - hh && touch.globalY < cat.y + hh )
							{
								targetCat = cat;
								_ce.sound.playSound("catPickupSfx");
								break;
							}
						}
					}
					draggedCat = targetCat;
					if ( Config.SHOW_LOG_DRAGDROP )
					{
						if ( draggedCat != null )	// ??TRON debug
							trace("Picking up  : " + draggedCat.editArt.ID );
						else
							trace("No cat to picjk up!");
					}
					break;
					
				case TouchPhase.ENDED:
					_ce.sound.playSound("catDropSfx");
					if ( Config.SHOW_LOG_DRAGDROP )
					{
						if ( draggedCat != null )	// ??TRON debug
						{
							trace("Putting down: " + draggedCat.editArt.ID + "  coord: " +
								draggedCat.x, draggedCat.y, draggedCat.editArt.x, draggedCat.editArt.y);
						}
					}
					draggedCat = null;
					break;
				
				case TouchPhase.MOVED:
					if ( Config.SHOW_LOG_DRAGDROP )
					{
						if ( draggedCat != null )	// ??TRON debug
							trace("dragging    : " + draggedCat.editArt.ID );
					}
						
					if ( draggedCat != null )
					{
						draggedCat.x = touch.globalX;
						draggedCat.y = touch.globalY;
					}
					break;
					
				default:
					if ( Config.SHOW_LOG_DRAGDROP )
					{
						trace("Unhandled touch event, value: " + touch.phase);
					}
					break;

			}			
		}
		
		
		
		private function onGoButtonTriggered( e:starling.events.Event ):void
		{
			goButton.removeEventListener( starling.events.Event.TRIGGERED, onGoButtonTriggered);
			
			_ce.gameData[Config.ACTIVE_CATS] 	= cats;
			_ce.gameData[Config.CURRENT_LEVEL]	= levelData;
			
			vs = new VideoStream( "assets/TransitionAnimation.mp4" );
			vs.addEventListener( VideoStream.VIDEO_DONE, onVideoDone );
			vs.addEventListener( VideoStream.VIDEO_READY, onVideoReady );				
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
			cats 		= levelData.getCatsAsVector();
		}
		

		/// Callback when video is (automatically) done playing.
		private function onVideoDone( e:flash.events.Event ):void
		{
			videoIsPlaying = false;
			switchToBattleState();
		}
		
		
		/// Callback when video buffer is loaded and ready to start playing.
		private function onVideoReady( e:flash.events.Event ):void
		{
			if ( !videoIsPlaying )
			{
				Global.stage2d.addChild( vs.video );
				vs.video.width 		= Global.stage2d.stageWidth;
				vs.video.height 	= Global.stage2d.stageHeight;
				vs.play( true );
				
				videoIsPlaying  	= true;
				
				stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			}
		}
		
		
		private function onKeyDown( e:KeyboardEvent ):void
		{
			vs.stop();
			switchToBattleState();
		}
		
		
		private function switchToBattleState():void
		{
			videoIsPlaying = false;
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			Global.stage2d.removeChild( vs.video );
			vs.removeEventListener( VideoStream.VIDEO_DONE, onVideoDone );
			vs.removeEventListener( VideoStream.VIDEO_READY, onVideoReady );
			_ce.state = new BattleState();			
		}

	}

}