package
{
	/**
	 * 
	 * CITRUS EXAMPLE LAUNCHER.
	 * 
	 * How to use :
	 * change the packageName constant to the folder name of the example you want to try.
	 * (don't forget the directory structure, to test the braid demo, set it to "games.braid")
	 */
	
	import advancedSounds.Main;
	import away3dbox2d.Main;
	import awayphysics.car.Main;
	import blitting.Main;
	import box2dstarling.Main;
	import cameramovement.Main;
	import complexbox2dobject.Main;
	import dragonbones.Main;
	import entity.Main;
	import games.braid.Main;
	import games.hungryhero.Main;
	import games.live4sales.Main;
	import games.osmos.Main;
	import games.superhexagon.Main;
	import games.tinywings.Main;
	import groupobjects.Main;
	import mobilenapestarling.Main;
	import multiplayer.Main;
	import multiresolutions.Main;
	import objectpooling.Main;
	import simplecollision.Main;
	import soundpatchdemo.Main;
	import stage3dinteroperation.Main;
	import starlingdemo.Main;
	import starlingtiles.Main;
	import statetransitions.Main;
	import tiledmap.displaylist.Main;
	import tiledmap.starling.Main;
	import ui.Main;
	import vehicle.Main;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class CitrusExampleLauncher extends Sprite
	{
		
		/**
		 * package name of the example you want to try
		 */
		public static const packageName:String = "advancedSounds";	// ok
		//public static const packageName:String = "away3dbox2d";		// ok
		//public static const packageName:String = "awayphysics.car";	// ok
		//public static const packageName:String = "blitting";			// ok
		//public static const packageName:String = "box2dstarling";		// ok
		//public static const packageName:String = "cameramovement";	// ok
		//public static const packageName:String = "complexbox2dobject";// ok
		//public static const packageName:String = "dragonbones";		// ok
		//public static const packageName:String = "entity";			// ok
		//public static const packageName:String = "games.braid";		// ok
		//public static const packageName:String = "games.hungryhero";	// ok
		//public static const packageName:String = "games.live4sales";
		//public static const packageName:String = "games.osmos";
		//public static const packageName:String = "games.superhexagon";
		//public static const packageName:String = "games.tinywings";
		//public static const packageName:String = "groupobjects";
		//public static const packageName:String = "mobilenapestarling";
		//public static const packageName:String = "multiplayer";
		//public static const packageName:String = "multiresolutions";
		//public static const packageName:String = "objectpooling";
		//public static const packageName:String = "simplecollision";
		//public static const packageName:String = "soundpatchdemo";
		//public static const packageName:String = "stage3dinteroperation";
		//public static const packageName:String = "starlingdemo";
		//public static const packageName:String = "starlingtiles";
		//public static const packageName:String = "statetransitions";
		//public static const packageName:String = "tiledmap.displaylist";
		//public static const packageName:String = "tiledmap.starling";
		//public static const packageName:String = "ui";
		//public static const packageName:String = "vehicle";
		
		
		//-----------------------------------------------------------------------------------
		
		public function CitrusExampleLauncher()
		{
			
			var example:* = new (getDefinitionByName(packageName+".Main") as Class)();
			
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void
				{
					e.target.removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
					addChild(example as DisplayObjectContainer);
				});
		}
		
		public static var examples:Array = [advancedSounds.Main, away3dbox2d.Main, awayphysics.car.Main, blitting.Main, box2dstarling.Main, cameramovement.Main, complexbox2dobject.Main, dragonbones.Main, entity.Main, games.braid.Main, games.hungryhero.Main, games.live4sales.Main, games.osmos.Main, games.superhexagon.Main, games.tinywings.Main, groupobjects.Main, mobilenapestarling.Main, multiplayer.Main, multiresolutions.Main, objectpooling.Main, simplecollision.Main, soundpatchdemo.Main, stage3dinteroperation.Main, starlingdemo.Main, starlingtiles.Main, statetransitions.Main, tiledmap.displaylist.Main, tiledmap.starling.Main, ui.Main, vehicle.Main];
		
	
	}

}