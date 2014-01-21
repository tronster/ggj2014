package  {

	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.core.starling.StarlingState;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.view.ACitrusView;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import drg.Keyboard;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.extensions.particles.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author Shawn Freeman
	 */
	
	public class BlittingGameState extends StarlingState {

		// embed your graphics
		[Embed(source = '../lib/hero_idle.png')]
		private var _heroIdleClass:Class;
		[Embed(source = '../lib/hero_walk.png')]
		private var _heroWalkClass:Class;
		[Embed(source = '../lib/hero_jump.png')]
		private var _heroJumpClass:Class;
		[Embed(source = '../lib/bg_hills.png')]
		private var _hillsClass:Class;
		
		//import spritesheet
		[Embed(source = '../lib/asset_sheet.png')]
		private var assetSheet:Class;
		[Embed(source="../lib/asset_sheet_data.xml", mimeType="application/octet-stream")]
		private var assetSheetData:Class;
		
		//import particle resources
		[Embed(source="../lib/particles/particle.pex", mimeType="application/octet-stream")]		//particle informatiion in XML formate
		private var particlePEX:Class;
		[Embed(source="../lib/particles/texture.png")]			
		private var particleTexture:Class;
		
		private var hero:MyHero;
		private var heroParticle:PDParticleSystem;
		private var testParticleEffect:CitrusSprite;
		
		public function BlittingGameState() {
			super();
		}

		override public function initialize():void {
			
			super.initialize();
			
			var box2D:Box2D = new Box2D("box2D");
			//box2D.visible = true;
			add(box2D);
			
			_ce.input.keyboard.destroy();
			_ce.input.keyboard = new Keyboard("keyboard");
			//load texture atlas
			var assetTexture:Texture = Texture.fromBitmap(new assetSheet());
			var assetData:XML = XML(new assetSheetData());
			var assetAtlas:TextureAtlas = new TextureAtlas(assetTexture, assetData);
			
			var platform:Platform = new Platform("P1");
			platform.view = assetAtlas.getTexture("platform");
			platform.width = platform.view.width;
			platform.height = platform.view.height;
			platform.x = stage.stageWidth * .5;
			platform.y = stage.stageHeight - (platform.height * .5);
			add(platform);
			
			// You can quickly create a graphic by passing the embedded class into a new blitting art object.
			add(new CitrusSprite("Hills", { parallaxX:0.4, parallaxY:0.4, view:new _hillsClass() } ));
			
			heroParticle = new PDParticleSystem(XML(new particlePEX()), Texture.fromBitmap(new particleTexture()));
			heroParticle.start();
			testParticleEffect = new CitrusSprite("pEffect", { view:heroParticle } );
			add(testParticleEffect);
			
			// Set up your game object's animations like this;
			var heroArt:AnimationSequence = new AnimationSequence(assetAtlas, ["big_eradium_explosion_", "blue_hit_", "plasma_explosion_", "blue_burst_"], "big_eradium_explosion_", 30, true);
			
			//output all the animation names hero art contains
			var names:Vector.<String> = heroArt.getAnimationNames();
			for each(var str:String in names)
			{
				trace("Animation Name: " + str);
			}
			
			//output all looping animations in within Starling Art, this should be global across the entire game
			StarlingArt.setLoopAnimations(["big_eradium_explosion_", "blue_hit_", "plasma_explosion_", "blue_burst_"]);
			for each(var obj:Object in StarlingArt.loopAnimation)
			{
				trace("StarlingArt Loops: " + obj);
			}
			
			hero = new MyHero("Hero", {x:320, y:150, view:heroArt});
			add(hero);
			
			//'Image' is used here instead of a Starling Texture because Textures have no writeable scale properties or functions
			var tempImg:Image = new Image(assetAtlas.getTexture("damageup"));		
			var coin:Coin = new Coin("coin");
			coin.view = tempImg;
			Image(coin.view).scaleX = .25;
			Image(coin.view).scaleY = .25;
			coin.width = coin.view.width;
			coin.height = coin.view.height;
			coin.x = stage.stageWidth * .5;
			coin.y = 400;
			coin.onBeginContact.add(function(contact:b2Contact):void {
				trace("Coin Collected by: " +  Box2DUtils.CollisionGetOther(coin, contact));
				remove(coin);
			});
			add(coin);
			
			
			/*view.camera.setUp(hero, new Rectangle(0, -200, 1200, 600));
			trace(view);
			// If you update any properties on the state's view, call updateCanvas() afterwards.
			BlittingView(view).backgroundColor = 0xffffcc88;
			BlittingView(view).updateCanvas(); // Don't forget to call this
				
			_ce.onStageResize.add(function(w:Number, h:Number):void
			{
				BlittingView(view).updateCanvas();
			});*/
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			if (hero.y > stage.stageHeight + 100)
			{
				hero.y = 10;
				hero.x = stage.stageWidth * .5;
			}
			
			
			if(hero != null) moveEmitter(testParticleEffect, hero.x, hero.y);
		}
		
		private function moveEmitter(sprite:CitrusSprite, x:int, y:int):void
		{
			(sprite.view as PDParticleSystem).emitterX = x;
			(sprite.view as PDParticleSystem).emitterY = y;
		}
		
		// Make sure and call this override to specify Blitting mode.
		override protected function createView():ACitrusView {
			return super.createView();
			//return new BlittingView(this);
		}
	}
}
