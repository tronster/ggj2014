package  
{
	import citrus.core.IState;
	import citrus.objects.CitrusSprite;
	import starling.textures.Texture;
	/**
	 * BattleObject is used to display a battle between a cat and dog.
	 */
	public class BattleObject extends CitrusSprite
	{
		public var isBattling:Boolean = true;
		public var catHealth:CitrusSprite;
		public var dogHealth:CitrusSprite;
		
		private var cat:Cat;
		private var dog:Dog;
		
		public function BattleObject(name:String, cat:Cat, dog:Dog, params:Object = null)
		{
			this.cat = cat;
			cat.inBattle = true;
			catHealth = new CitrusSprite("cat_battle_health", {view:Resources.getAtlas("temp_sheet").getTexture("start_game_idle_button") });
			
			this.dog = dog;
			dog.inBattle = true;
			dogHealth = new CitrusSprite("cat_battle_health", {view:Resources.getAtlas("temp_sheet").getTexture("start_game_over_button") });
			
			this.x = cat.x;
			this.y = cat.y;
			
			catHealth.x = this.x - Texture(catHealth.view).width * .5;
			catHealth.y = this.y - (Texture(catHealth.view).width * .5) - 20;
			
			dogHealth.x = this.x - Texture(catHealth.view).width * .5;
			dogHealth.y = this.y + 20;
			//force the view in params to be battle cloud incase something else gets passed in
			params.view = "assets/battle_animation.swf";
			super(name, params);
		}
		
		/**
		 * custom function to remove battle object from the engine, DOES NOT override destroy() because a state needs to be passed to this
		 * object to remove it correctly
		 * @param	state
		 */
		public function dispose(state:IState):void
		{
			super.destroy();
			state.remove(this);
			state.remove(catHealth);
			state.remove(dogHealth);
		}
		
		override public function update(timeDelta:Number):void 
		{
			//determine damage
			if (cat.type > dog.type)
			{
				dog.hp -= Config.DAMAGE_HIGH;
				cat.hp -= Config.DAMAGE_LOW;
			}else if (cat.type == dog.type)
			{
				dog.hp -= Config.DAMAGE_MED;
				cat.hp -= Config.DAMAGE_MED;
			}else {
				dog.hp -= Config.DAMAGE_LOW;
				cat.hp -= Config.DAMAGE_HIGH;
			}			
			
			checkBattleEnded();
			
			trace("There is a battle going on", cat.hp, cat.type, dog.hp, dog.type);
		}
		
		private function checkBattleEnded():void
		{
			var endBattle:Boolean = false;
			
			if (dog.hp <= 0) 
			{
				dog.isActive = false;
				endBattle = true;
			}
			
			if (cat.hp <= 0) 
			{
				cat.isActive = false;
				endBattle = true;
			}
			
			if (endBattle)
			{
				isBattling = false;
				cat.inBattle = false;
				dog.inBattle = false;
			}
		}
	}

}