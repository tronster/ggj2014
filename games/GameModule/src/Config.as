package  
{
	import citrus.input.controllers.Keyboard;
	
	
	//
	//	Global statics
	//
	public class Config 
	{	
		// ----- Game values --------------------
		
		public static const GAMEDATA_LEVELS		:String = "levels";
		public static const CURRENT_LEVEL_NUM	:String = "currentLevelNum";
		public static const CURRENT_LEVEL		:String = "currentLevel";
		
		public static const MAX_HP_CAT_1	:int	= 100;
		public static const MAX_HP_CAT_2	:int	= 100;
		public static const MAX_HP_CAT_3	:int	= 100;
		public static const MAX_HP_DOG_1	:int	= 100;
		public static const MAX_HP_DOG_2	:int	= 100;
		public static const MAX_HP_DOG_3	:int	= 100;
		
		public static const DAMAGE_1_TO_2	:Number = 10;
		public static const DAMAGE_2_TO_3	:Number = 10;
		public static const DAMAGE_3_TO_1	:Number = 10;
		
		public static const DAMAGE_2_TO_1	:Number = 3;
		public static const DAMAGE_3_TO_2	:Number = 3;
		public static const DAMAGE_1_TO_3	:Number = 3;

		public static const DAMAGE_SAME		:Number = 5;

		
		
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