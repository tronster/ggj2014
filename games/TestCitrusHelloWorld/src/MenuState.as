package
{
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.core.starling.StarlingState;
	
	public class MenuState extends StarlingState
	{	
		public function MenuState() 	
		{		
			super();
		}

		override public function initialize():void
		{
			super.initialize();
			
			var physics:Box2D 		= new Box2D("box2d");
			physics.visible 		= true;
			add( physics );
			
			var floor:Platform 		= new Platform("floor", { x:512, y:748, width:1024, height:40 } );
			add( floor );

			var p1:Platform 		= new Platform("p1", { x:874, y:151, width:300, height:40 } );
			add( p1 );
			
			var mp:MovingPlatform 	= new MovingPlatform("moving", { x:220, y:700, width:200, height:40, startX:220, startY:700, endX:500, endY:151 } );
			add( mp );	
			
		}
	}

}