package  
{
	import flash.text.Font;
	import starling.display.Button;
	import starling.events.Event;

	/// Common button for game usage.
	public class ButtonGame extends Button
	{
		private var callback:Function;
		
		
		public function ButtonGame( label:String, callback:Function ) 
		{
			super(
				Resources.getAtlas().getTexture("button"),
				label,
				Resources.getAtlas().getTexture("button hover"));
	
			useHandCursor = true;
			addEventListener( starling.events.Event.TRIGGERED, callback);
			this.callback = callback;
			
			fontSize = 24;
			//fontName = ;
			fontColor = 0x0;
			
			//??TRON debug
			/*
			trace("----- FONTs ------");
			var embeddedFonts:Vector.<Font> = Vector.<Font>(Font.enumerateFonts());		   
			for (var i:int = embeddedFonts.length - 1; i > -1; i-- )
			{
			   trace("EMBEDDED FONT #" + i + ": " + embeddedFonts[i].fontName );
			}
			*/
		}
		
		override public function dispose():void
		{
			if ( callback != null)
				removeEventListener( Event.TRIGGERED, callback );
			super.dispose();
		}
		
	}

}