package  
{
	import citrus.input.controllers.Keyboard;
	//import flash.ui.Keyboard;
	
	
	//
	//	Global statics
	//
	public class Config 
	{	
		// ----- INPUT --------------------

		// Alternative set of keys
		public static const DEFAULT_P1_MOVE_LEFT	:uint	= Keyboard.J;
		public static const DEFAULT_P1_MOVE_RIGHT	:uint	= Keyboard.L;
		public static const DEFAULT_P1_MOVE_UP		:uint	= Keyboard.I;
		public static const DEFAULT_P1_MOVE_DOWN	:uint	= Keyboard.K;
		public static const DEFAULT_P1_JUMP			:uint	= Keyboard.Z;
/*
		public static const DEFAULT_P1_MOVE_LEFT	:uint	= Keyboard.LEFT;
		public static const DEFAULT_P1_MOVE_RIGHT	:uint	= Keyboard.RIGHT;
		public static const DEFAULT_P1_MOVE_UP		:uint	= Keyboard.UP;
		public static const DEFAULT_P1_MOVE_DOWN	:uint	= Keyboard.DOWN;
		public static const DEFAULT_P1_JUMP			:uint	= Keyboard.SPACE;
*/		
		public static var P1MoveLeft	:uint = DEFAULT_P1_MOVE_LEFT;
		public static var P1MoveRight	:uint = DEFAULT_P1_MOVE_RIGHT;
		public static var P1MoveUp		:uint = DEFAULT_P1_MOVE_UP;
		public static var P1MoveDown	:uint = DEFAULT_P1_MOVE_DOWN;
		public static var P1Jump		:uint = DEFAULT_P1_JUMP;
	}

}