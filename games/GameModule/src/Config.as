 package  
{
	import citrus.input.controllers.Keyboard;
	
	
	//
	//	Global statics
	//
	public class Config 
	{	
		// ----- Global Strings --------------
		public static const LEFT						:String = "Left";
		public static const RIGHT						:String = "Right";
		public static const UP							:String = "Up";
		public static const DOWN						:String = "Down";
		public static const IDLE						:String = "Idle";
		public static const VICTORY						:String = "Victory";
		public static const DEFEAT						:String = "Defeat";
		public static const LOSE						:String = "Lose";
		public static const READY						:String = "Ready";
		
		// ----- Game data --------------------
		
		public static const GAMEDATA_LEVELS		:String = "levels";
		public static const CURRENT_LEVEL_NUM	:String = "currentLevelNum";
		public static const CURRENT_LEVEL		:String = "currentLevel";
		public static const ACTIVE_CATS			:String = "activeCats";
		
		
		// ----- Game values --------------------
		
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
		
		public static const DAMAGE_HIGH		:Number = .3;
		public static const DAMAGE_MED		:Number = .2;
		public static const DAMAGE_LOW		:Number = .1;

		
		// ----- LEVELS --------------------
		
		static public const TILE_NONE			:uint = 0;
		static public const TILE_STRAIGHT		:uint = 1;
		static public const TILE_VSTRAIGHT		:uint = 2;
		static public const TILE_TOP_RIGHT		:uint = 3;
		static public const TILE_BOTTOM_RIGHT	:uint = 4;
		static public const TILE_TOP_LEFT		:uint = 5;
		static public const TILE_BOTTOM_LEFT	:uint = 6;
		static public const TILE_DOG_START		:uint = 7;
		static public const TILE_UNUSED2		:uint = 8;
		static public const TILE_SUSHI			:uint = 9;
				
		static public const TILES_STRAIGHT:Array = [ 
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			9, 1, 1, 1, 1, 1, 7,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0,
			];
		
		static public const TILES_ONEBEND:Array = [ 
			0, 0, 0, 0, 0, 0, 0,
			9, 1, 6, 0, 0, 0, 0,
			0, 0, 3, 1, 1, 1, 7,
			0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0
			];

		static public const TILES_ONEBENDLONG:Array = [ 
			9, 1, 6, 0, 0, 0, 0,
			0, 0, 2, 0, 0, 0, 0,
			0, 0, 2, 0, 0, 0, 0,
			0, 0, 2, 0, 0, 0, 0,
			0, 0, 3, 1, 1, 1, 7
			];

		static public const TILES_TWOBEND:Array = [ 
			0, 4, 1, 6, 0, 0, 0,
			0, 2, 0, 2, 0, 0, 0,
			9, 5, 0, 2, 0, 0, 0,
			0, 0, 0, 2, 0, 0, 0,
			0, 0, 0, 3, 1, 1, 7
			];
		
			
			
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