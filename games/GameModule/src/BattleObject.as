package  
{
	import citrus.core.IState;
	import citrus.objects.CitrusSprite;
	import citrus.view.starlingview.AnimationSequence;
	import starling.textures.Texture;
	/**
	 * BattleObject is used to display a battle between a cat and dog.
	 */
	public class BattleObject extends CitrusSprite
	{
		public var isBattling:Boolean = true;
		public var catHealth:CitrusSprite;
		public var dogHealth:CitrusSprite;
		
		private var numHealthBarFrames:int;
		private var cat:Cat;
		private var dog:Dog;
		
		public function BattleObject(name:String, cat:Cat, dog:Dog, params:Object = null)
		{
			//force the view in params to be battle cloud incase something else gets passed in
			params.view = Resources.getView("Battlecloud");
			super(name, params);
			
			this.x = cat.x - (view.width * .5);
			this.y = cat.y - (view.height * .5);
			
			this.cat = cat;
			cat.inBattle = true;
			
			this.dog = dog;
			dog.inBattle = true;
			
			catHealth = new CitrusSprite("cat_battle_health", {view:Resources.getView("hpbar")});
			catHealth.x = (this.x + view.width * .5) - catHealth.view.width * .5;
			catHealth.y = (this.y + view.height * .5) - (catHealth.view.height * .5) - 20;
			
			dogHealth = new CitrusSprite("dog_battle_health", { view:Resources.getView("hpbar") } );
			dogHealth.x = (this.x + view.width * .5) - catHealth.view.width * .5;
			dogHealth.y = (this.y + view.height * .5) + 20;
			
			numHealthBarFrames = AnimationSequence(catHealth.view).mcSequences["hpbar"].numFrames;
			
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
		
		public function stopAnimation():void
		{
			AnimationSequence(catHealth.view).mcSequences["hpbar"].stop();
			AnimationSequence(dogHealth.view).mcSequences["hpbar"].stop();
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
			
			//set both healthbars to a frame number that coresponds to a percentage of health
			AnimationSequence(catHealth.view).mcSequences["hpbar"].currentFrame = Math.ceil((cat.hp / cat.maxHp) * (numHealthBarFrames - 1));
			AnimationSequence(dogHealth.view).mcSequences["hpbar"].currentFrame = Math.ceil((dog.hp / dog.maxHp) * (numHealthBarFrames - 1));
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