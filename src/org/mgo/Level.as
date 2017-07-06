package org.mgo 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import org.mgo.entities.AltPlatform;
	import org.mgo.entities.Ground;
	import org.mgo.entities.monsters.Monster_Muncher;
	import org.mgo.entities.monsters.Monster_Sizzler;
	import org.mgo.entities.monsters.Monster_Spikey;
	import org.mgo.entities.Platform;
	import org.mgo.entities.Player;
	import org.mgo.entities.PtsCounter;
	
	/**
	 * Das eigentliche Spiel, springen und so
	 * @author Marco Kaul
	 */
	public class Level extends World
	{
		/**
		 * Der Spieler
		 */
		public static var player:Player;
		
		/**
		 * Zählt Position der nächsten Plattform
		 */
		public static var heightcounter:int;
		
		public function Level():void 
		{
			// Spielstatus
			Game.state = State.GAME;
		}
		
		/**
		 * Welt initialisieren
		 */
		override public function begin():void 
		{
			createWorld();
		}
		
		/**
		 * Welt erstellen
		 */
		public function createWorld():void 
		{
			// Alle vorhandenen Entitäten löschen
			removeAll();
			
			// Hintergrund
			for (var i:int = 0; i < 4; i++) {
				var cloudimg:Image = new Image(Assets.CLOUD);
				cloudimg.scrollY = FP.random * 0.3;
				var cloud:Entity = new Entity(Math.random() * FP.width, (FP.height - 160) * Math.random(), cloudimg);
				add(cloud);
			}
			
			// Boden hinzufügen
			add(new Ground());
			
			// Plattformen hinzufügen
			for (heightcounter = FP.height - 160; heightcounter > -2000; heightcounter -= 80)
			{
				add(new Platform(FP.rand(FP.width - 96), heightcounter));		
			}
			
			// Spieler hinzufügen
			player = new Player(FP.halfWidth - 16, FP.height - 94);
			add(player);
			
			// Punktezähler hinzufügen
			add(new PtsCounter());
		}
		/**
		 * Verschwindende Plattformen generieren automatisch neue.
		 */
		public function createPlatform():void {
			// Höhe dazurechnen
			heightcounter -= 80;
			
			// Zufallswerte für Position und Art
			var spawnrand:Number = FP.random;
			var xrand:Number = FP.rand(FP.width - 96);
			// Monster
			if (spawnrand < 0.1) {
				switch(FP.rand(3)) {
					case 0:
						add(new Monster_Sizzler(xrand, heightcounter));
						break;
					case 1:
						add(new Monster_Muncher(xrand, heightcounter));
						break;
					case 2:
						add(new Monster_Spikey(xrand, heightcounter));
						break;
					default:
						break;
				}
			
				add(new Platform(FP.rand(FP.width - 96), heightcounter));
			} else { // Kein Monster
				if (FP.random < 0.2) {
					add(new AltPlatform(xrand, heightcounter));
				} else {
					add(new Platform(xrand, heightcounter));	
				}
				
			}
			
		}
		
		override public function update():void 
		{
			// Kamerabewegung errechnen
			var merge:Number = merge_number(FP.camera.y, player.y - 300, .2);
			
			// Kameraposition aktualisieren
			if (merge <= FP.camera.y && player.isAlive)
			{
				FP.camera.y = merge;
			}
			
			// Aktualisiere Punkte
			
			if ((player.y - 386) * -1 > Game.score) {
				Game.score = (player.y - 386) * -1;
			}
			
			super.update();
		}
		
		/**
		 * Annährung zweier Werte in einer bestimmten Rate
		 * @param	numA	Von
		 * @param	numB	Zu
		 * @param	amount	Rate
		 * @return	Errechneter Wert
		 */
		private function merge_number(numA:Number,numB:Number,amount:Number):Number {
			return (numA+((numB-numA)*amount))
		}
		
		// TODO: Monster, PowerUps
		
	}

}