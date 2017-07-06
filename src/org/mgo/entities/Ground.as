package org.mgo.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import org.mgo.Assets;
	import org.mgo.Level;
	
	/**
	 * Boden-Objekt
	 * @author Marco Kaul
	 */
	public class Ground extends Entity
	{
		private var img:Image;
		
		public function Ground() 
		{
			img = new Image(Assets.GROUND);
			super(0, FP.height - img.height, img);
		}
		
		override public function added():void 
		{
			// Kollisionstyp
			type = "platform";
			
			// Hitbox definieren
			setHitbox(img.width, img.height - 32, 0, -32);
		}
		
		override public function update():void 
		{
			// Verschwinde sobald nicht mehr sichtbar und erstelle neue Plattform
			if (y > FP.camera.y + FP.height) {
				(world as Level).createPlatform();
				world.remove(this);
			}
		}
		
	}

}