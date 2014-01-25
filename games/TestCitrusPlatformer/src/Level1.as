package 
{
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.ACitrusCamera;
	import citrus.view.starlingview.AnimationSequence;
	import citrus.view.starlingview.StarlingArt;
	import citrus.view.starlingview.StarlingCamera;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import starling.display.Image;
	import starling.utils.AssetManager;

	
	public class Level1 extends StarlingState 
	{
		private var level	:MovieClip;
		private var hero	:Hero;
		
		
		public function Level1(lvl:MovieClip)
		{
			super();
			level = lvl;
		}
		
		override public function initialize():void
		{
			super.initialize();

			var b2d:Box2D = new Box2D("box2D");
			b2d.visible = true;
			add( b2d );
			
			ObjectMaker2D.FromMovieClip( level );
			
			add(new Platform("platform", {x:0, y:600, width:3000, height:20}));
			
			hero = new Hero("hero", { x:200, y:200, width:100, height:50, view:"assets/hero.swf" } );
			//var animSeq:AnimationSequence = new AnimationSequence("assets/hero.swf", ["idle"], "idle");
			//hero = new Hero("hero", { x:200, y:200, width:100, height:50, view:animSeq } );
			add( hero );
			
			
			StarlingArt.setLoopAnimations(["idle"]);
						
			camera.setUp( hero, new Rectangle(0, 0, 3000, 640), new Point( stage.stageWidth >> 1, stage.stageHeight >> 1), new Point(.2, .2) );
			camera.parallaxMode = ACitrusCamera.PARALLAX_MODE_TOPLEFT;
		}
	}
	
}