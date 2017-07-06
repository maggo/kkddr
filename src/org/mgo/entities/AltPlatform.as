package org.mgo.entities 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import org.mgo.Assets;
	import org.mgo.Level;
	
	/**
	 * Brüchige Plattform
	 * @author Marco Kaul
	 */
	public class AltPlatform extends Entity
	{
		private var destroysound:SfxrSynth;
		
		public function AltPlatform(x:int, y:int) 
		{
			var img:Image = new Image(Assets.ALTPLATFORM);
			
			// Sound
			destroysound = new SfxrSynth();
			destroysound.params.setSettingsString("3,,0.1443,0.7643,0.1945,0.6192,,-0.3042,,,,0.3836,0.7467,,,0.6558,,,1,,,,,0.5");
			destroysound.cacheSound(function():void { } );
			
			width = img.width;
			height = img.height;
			
			super(x, y, img);
		}
		
		override public function added():void 
		{
			// Kollisionstyp
			type = "altplatform";
			
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
		
		/**
		 * Zerstöre die Plattform und spiele Sound ab
		 */
		public function destroy():void {
			destroysound.play();
			if(world) world.remove(this);	
		}
		
	}

}