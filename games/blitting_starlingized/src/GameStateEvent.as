package  
{
	import starling.events.Event;
	/**
	 * ...
	 * @author Shawn Freeman
	 */
	public class GameStateEvent extends Event
	{
		public static const STATE_CHANGE:String =  "state_change";
		
		public var params:Object;
		
		public function GameStateEvent(type:String, params:Object = null, bubbles:Boolean = false) 
		{
			super(type, bubbles);
			this.params = params;
		}
		
	}

}