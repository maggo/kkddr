package org.mgo.entities.monsters 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import org.mgo.Assets;
	import org.mgo.entities.Player;
	import org.mgo.Game;
	
	/**
	 * Bewegt sich nach Links und Rechts.
	 * @author Maggo
	 */
	public class Monster_Sizzler extends Entity
	{
		/**
		 * Bewegungsgeschwindigkeit
		 */
		public var movespeed:Number = 1.3;
		
		/**
		 * Bewegungsrichtung
		 */
		private var movedir:int = 1;
		
		private var img:Image;
		
		private var deathsound:SfxrSynth;
		
		public function Monster_Sizzler(x:Number, y:Number) 
		{
			img = new Image(Assets.MONSTER_SIZZLER);
			
			// Sterbesound
			deathsound = new SfxrSynth();
			deathsound.params.setSettingsString("3,,0.257,0.5936,0.1944,0.179,,0.0839,,,,,,,,,0.0982,-0.2881,1,,,,,0.5");
			deathsound.cacheSound(function():void { }, 1);
			
			super(x, y, img);
		}
		
		override public function added():void 
		{
			setHitbox(img.width - 4, 44, -4, -8);
		}
		
		override public function update():void 
		{
			// Seitwärtsbewegung
			if (x + width > FP.width) {
				x = FP.width - width;
				movespeed *= -1;
				img.flipped = true;
			}
			
			if (x < 0) {
				x = 0;
				movespeed *= -1;
				img.flipped = false;
			}
			
			x = x + movespeed * movedir;
			
			// Spielerkollision von unten - Spieler tot, ansonsten Monster tot.
			var collider:Player = collide("player", x, y) as Player;
			if (collider && collider.isAlive) {
				if (collider.yspeed > 0) {
					collider.jump();
					deathsound.play();
					Game.score += 200;
					world.remove(this);
				} else {
					collider.die();
				}
				
			}
			
		}
		
	}

}