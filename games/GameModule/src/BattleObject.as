package  
{
	import citrus.objects.CitrusSprite;
	/**
	 * BattleObject is used to display a battle between a cat and dog.
	 */
	public class BattleObject extends CitrusSprite
	{
		public var isBattling:Boolean = true;
		
		private var cat:Cat;
		private var dog:Dog;
		
		public function BattleObject(name:String, cat:Cat, dog:Dog, params:Object = null)
		{
			super(name, params);
			
			this.cat = cat;
			this.dog = dog;
		}
		
		override public function update(timeDelta:Number):void 
		{
			
		}
		
	}

}