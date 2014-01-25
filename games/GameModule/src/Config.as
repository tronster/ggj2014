package  
{
	import citrus.input.controllers.Keyboard;
	
	
	//
	//	Global statics
	//
	public class Config 
	{	
		// ----- INPUT --------------------

		public static const DEFAULT_P1_MOVE_LEFT	:uint	= Keyboard.LEFT;
		public static const DEFAULT_P1_MOVE_RIGHT	:uint	= Keyboard.RIGHT;
		public static const DEFAULT_P1_MOVE_UP		:uint	= Keyboard.UP;
		public static const DEFAULT_P1_MOVE_DOWN	:uint	= Keyboard.DOWN;
		public static const DEFAULT_P1_JUMP			:uint	= Keyboard.SPACE;
		
		public static var P1MoveLeft	:uint = DEFAULT_P1_MOVE_LEFT;
		public static var P1MoveRight	:uint = DEFAULT_P1_MOVE_RIGHT;
		public static var P1MoveUp		:uint = DEFAULT_P1_MOVE_UP;
		public static var P1MoveDown	:uint = DEFAULT_P1_MOVE_DOWN;
		public static var P1Jump		:uint = DEFAULT_P1_JUMP;
		
	
		
		// ----- ACTIONS --------------------
		
		public static const ACTION_JUMP		:String = "jump";
		public static const ACTION_LEFT		:String = "left";
		public static const ACTION_RIGHT	:String = "right";
		public static const ACTION_DUCK		:String = "duck";
		
		
	}

}