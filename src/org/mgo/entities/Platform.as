package org.mgo.entities 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import org.mgo.Assets;
	import org.mgo.Level;
	
	/**
	 * Standartplattform
	 * @author Marco Kaul
	 */
	public class Platform extends Entity
	{
		
		public function Platform(x:int, y:int) 
		{
			var img:Image = new Image(Assets.PLATFORM);
			
			width = img.width;
			height = img.height;
			
			super(x, y, img);
		}
		
		override public function added():void 
		{
			// Kollisionstyp
			type = "platform";
			
			// Hitbox
			setHitbox(width-2, height-2);
		}
		
		override public function update():void 
		{
			// Wenn aus dem Bild verschwindet, füge neue Plattform hinzu und verschwinde
			if (y > FP.camera.y + FP.height) {
				(world as Level).createPlatform();
				world.remove(this);
			}
		}
		
	}

}