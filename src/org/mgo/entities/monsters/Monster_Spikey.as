package org.mgo.entities.monsters 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import org.mgo.Assets;
	import org.mgo.entities.Player;
	
	/**
	 * Spikey, nicht berühren!
	 * @author Maggo
	 */
	public class Monster_Spikey extends Entity 
	{
		
		private var img:Image;
		
		public function Monster_Spikey(x:Number, y:Number) 
		{
			img = new Image(Assets.MONSTER_SPIKEY);
			
			super(x, y, img);
		}
		
		override public function added():void 
		{
			setHitbox(64, img.height - 4, -12, 0);
		}
		
		override public function update():void 
		{
			// Bei Berührung - Spieler tot
			var collider:Player = collide("player", x, y) as Player;
			if (collider && collider.isAlive) {
				collider.die();				
			}
			
		}
		
	}

}