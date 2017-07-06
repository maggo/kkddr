package org.mgo.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import org.mgo.Assets;
	import org.mgo.Level;
	import org.mgo.Score;
	
	/**
	 * Der Spieler, wie er im Level steht.
	 * @author Marco Kaul
	 */
	public class Player extends Entity
	{
		/**
		 * Lebt der Spieler?
		 */
		public var isAlive:Boolean = true;
		
		/**
		 * Horizontale Bewegungsgeschwindigkeit
		 */
		public var movespeed:Number = 3.337;
		
		/**
		 * Vertikale Sprunghöhe
		 */
		public var jumpheight:Number = 10;
		
		/**
		 * Anziehungskraft
		 */
		private var gravity:Number = 0.3;
		
		/**
		 * Y-Momentum
		 */
		public var yspeed:Number = 0;
		
		/**
		 * X-Momentum
		 */
		private var xspeed:Number = 0;
		
		/**
		 * Befindet sich auf Plattform?
		 */
		private var grounded:Boolean = false;
		
		// Sounds
		private var jumpsound:SfxrSynth;
		private var gameoversound:SfxrSynth;
		
		/**
		 * Gibt an ob das Spiel läuft.
		 */
		private var running:Boolean = false;
		
		/**
		 * Erstelle neuen Spieler mit angegebener Position
		 * @param	x X-Position
		 * @param	y Y-Position
		 */
		public function Player(x:int, y:int) 
		{
			var img:Image = new Image(Assets.PLAYER);
			width = img.width;
			height = img.height;
			
			// Sounds
			jumpsound = new SfxrSynth();
			jumpsound.params.setSettingsString("0,,0.1212,,0.2446,0.4492,,0.215,,,,,,0.4343,,,,,1,,,,,0.5");
			
			gameoversound = new SfxrSynth();
			gameoversound.params.setSettingsString("0,0.41,0.1239,0.5371,0.9258,0.532,,,0.4428,0.8811,-0.5356,0.5196,-0.1012,0.7158,-0.4405,0.1839,0.0082,0.0662,0.4138,-0.0219,0.5321,0.0033,-0.0005,0.5");
			gameoversound.cacheSound(function():void{}, 1);
			
			super(x, y, img);
		}
		
		/**
		 * Spieler hinzugefügt
		 */
		override public function added():void 
		{			
			// Kollisionstyp
			type = "player";
			
			// Hitbox
			setHitbox(width-16, height-2, -8);
		}
		
		/**
		 * Update-Funktion
		 */
		override public function update():void 
		{

			if (!this.onCamera)
			{
				die();
			}
			
			if ((Input.check("left") || Input.check("right")) && !running) running = true;
			
			// Seitwärtsbewegung
			
			if (isAlive) {
				if (Input.check("left")) xspeed -= movespeed;
				if (Input.check("right")) xspeed += movespeed;
			}
			
			
			var img:Image = graphic as Image;
			
			//Automatisches Springen wenn auf Platform
			if (running && grounded) {
				jump();
			}
			
			checkCollision();
			
			xspeed = 0;
			
			//Schwerkraft
			yspeed += gravity;
		}
		
		/**
		 * Prüfe X und Y Kollision
		 */
		private function checkCollision():void 
		{
			// Vertikale Kollision
			for (var i:int = 0; i < Math.abs(yspeed); i++) 
			{
				// Schreibe Kollision in Variable
				var collider:Entity = collideTypes(new Array("platform", "altplatform"), x, y + FP.sign(yspeed));
				// Wenn nicht kollidiert
				if ((collider == null || yspeed < 0) || !isAlive)
				{
					grounded = false;
					y += FP.sign(yspeed);
				} 
				else if(collider)// Wenn kollidiert
				{
					yspeed = 0;
					grounded = true;
					if (collider.type == "altplatform") {
						(world as Level).createPlatform();
						(collider as AltPlatform).destroy();
					}
					break;
				}
				
			}
			
			// Horizontale Kollision
			for (i = 0; i < Math.abs(xspeed); i++) 
			{
				if (	x + FP.sign(xspeed) >= 0 
					&& 	x + width + FP.sign(xspeed)+16 <= FP.width) 
				{
					x += FP.sign(xspeed);
				}
			}
			
		}
		
		/**
		 * Ende!
		 */
		public function die():void 
		{ 
			if (isAlive) {
				isAlive = false;
				
				gameoversound.play();
				
				Text.size = 64;
				var gameover:Text = new Text("GAME\nOVER!");
			
				var gotext:Entity = new Entity(FP.halfWidth - gameover.width / 2, FP.halfHeight - gameover.height / 2, gameover);
				gameover.scrollY = 0;
				gameover.color = 0x000000;
				gameover.scale = 0;
				gameover.centerOrigin();
			
				world.add(gotext);
			
				// GameOver-Skalierungstween
				var tween:VarTween = new VarTween(function():void { FP.world = new Score(); });
				tween.tween(gameover, "scale", 1, 3, Ease.backOut);
				world.addTween(tween, true);
			}
			
		}
		
		/**
		 * Sprungfunktion
		 */
		public function jump():void {
			yspeed = 0;
			jumpsound.play();
			yspeed -= jumpheight;
			grounded = false;
		}
		
	}

}