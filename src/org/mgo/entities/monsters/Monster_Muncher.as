package org.mgo.entities.monsters 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import org.mgo.Assets;
	import org.mgo.entities.Player;
	import org.mgo.Game;
	import org.mgo.Level;
	
	/**
	 * Muncher, kann von oben besiegt werden
	 * @author Maggo
	 */
	public class Monster_Muncher extends Entity 
	{
		private var img:Image;
		
		private var deathsound:SfxrSynth;
		
		public function Monster_Muncher(x:Number, y:Number) 
		{
			img = new Image(Assets.MONSTER_MUNCHER);
			
			// Sterbesound
			deathsound = new SfxrSynth();
			deathsound.params.setSettingsString("3,,0.257,0.5936,0.1944,0.179,,0.0839,,,,,,,,,0.0982,-0.2881,1,,,,,0.5");
			deathsound.cacheSound(function():void { }, 1);
			
			super(x, y, img);
		}
		
		override public function added():void 
		{
			setHitbox(img.width - 4, 44, 0, -8);
		}
		
		override public function update():void 
		{	
			// Spielerkollision von unten - Spieler tot, ansonsten Monster tot.
			var collider:Player = collide("player", x, y) as Player;
			if (collider && collider.isAlive) {
				if (collider.yspeed > 0) {
					collider.jump();
					deathsound.play();
					Game.score += 200;
					(world as Level).createPlatform();
					world.remove(this);
				} else {
					collider.die();
				}
				
			}
			
		}
		
	}

}