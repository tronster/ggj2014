package drg 
{
	import citrus.input.controllers.Keyboard;
	
	/**
	 * Keyboard.as
	 * @author Dr. G = Doodle Inc, Raizin, Geek House Games
	 *
	 * Keyboard that utilizes global configuration
	 */
	public class Keyboard extends citrus.input.controllers.Keyboard
	{
		
		public function Keyboard(name:String, params:Object = null)
		{
			super(name, params);
			
			// Remove key actions from the base class.
			resetAllKeyActions();
			
			addKeyAction("left", 	Config.P1MoveLeft	);
			addKeyAction("up", 		Config.P1MoveUp		);
			addKeyAction("right", 	Config.P1MoveRight	);
			addKeyAction("down", 	Config.P1MoveDown	);
			addKeyAction("jump", 	Config.P1Jump		);			
		}
		
	}

}