package  
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import citrus.view.ICitrusArt;
	import citrus.view.starlingview.StarlingArt;
	
	/**
	 * ...
	 * @author ...
	 */
	public class CatPhysicsObject extends ExtendedBox2DPhysicsObject
	{
		public var parent:Cat;
		
		public function CatPhysicsObject(parent:Cat, name:String, params:Object = null) 
		{
			this.parent = parent;
			super(name, params);
		}
		
/*
		override public function handleArtReady( citrusArt:ICitrusArt ):void {	
			trace("This art is ready!: " + citrusArt );
			var imgArt:StarlingArt = citrusArt as StarlingArt;		// yes			
//			var catSprite:CitrusSprite = (view as CitrusSprite);	// nope
//			catSprite.onCollide.add( parent.onCollideEdit );
//			catSprite.name = "cat" + String(parent.id);
		}
*/		
		override public function handleBeginContact(contact:b2Contact):void 
		{
			trace("contact: " + contact );
		}
		
		
	}

}