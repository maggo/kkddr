package org.mgo 
{
	import flash.display.BitmapData;
	import flash.net.SharedObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import org.mgo.entities.Button;
	import org.mgo.entities.FPTextField;
	
	/**
	 * Hauptmenü - Logo, Buttons, Vorschau
	 * @author Marco Kaul
	 */
	public class Menu extends World
	{
		/**
		 * Das Logo
		 */
		private var logo:Entity;
		
		public function Menu() 
		{
			// Spielstatus
			Game.state = State.MENU;
		}
		
		override public function begin():void 
		{
			// Wolken
			for (var i:int = 0; i < 4; i++) {
				var cloud:Entity = new Entity(Math.random() * FP.width, (FP.height - 160) * Math.random(), new Image(Assets.CLOUD));
				add(cloud);
			}
			
			// Logo - Mittig, oben, Fliegt herein
			{
				var logoimg:Image = new Image(Assets.LOGO);
				logoimg.scale = 0;
				logoimg.centerOrigin();
				logoimg.x -= logoimg.width / 2;
				logoimg.y -= logoimg.height / 2;
				logo = new Entity(FP.halfWidth, 96, logoimg);
				logo.setOrigin(144, 30);
				
				// Logo-Skalierungstween
				var tween:VarTween = new VarTween();
				tween.tween(logoimg, "scale", 1, 1.5, Ease.backOut);
				addTween(tween, true);
				
				add(logo);
			}
			
			// Hintergrundleiste
			
			add(new Entity(0, 192, new Image(new BitmapData(FP.width, 40, false, 0x8a956d))));
			
			// Textfeld
			
			var ini:FPTextField = new FPTextField(10, 196);
			ini.x = FP.halfWidth - ini.textobj.width / 2;
			add(ini);
			
			// Buttons	
			{
				// Start
				add(new Button(FP.halfWidth - 65, 256, new Image(Assets.START_BUTTON), new Image(Assets.START_BUTTON_ACTIVE), function():void { FP.world = new Level(); }));
				
				// Score
				add(new Button(FP.halfWidth - 65, 296, new Image(Assets.SCORE_BUTTON), new Image(Assets.SCORE_BUTTON_ACTIVE), function():void { FP.world = new Score(); }));
			}
			
			// Spielerdummy
			add(new Entity(32, FP.height - 94, new Image(Assets.PLAYER)));
			
			// Boden
			add(new Entity(0, FP.height - 96, new Image(Assets.GROUND_MENU)));
			
			// Version
			Text.size = 16;
			var vtext:Text = new Text("Version 1.0");
			vtext.color = 0x000000;
			add(new Entity(5, FP.height - 20, vtext));
			
		}
		
		override public function update():void 
		{
			// ENTF um Dateien zu löschen.
			if (Input.pressed(Key.DELETE)) {
				var cookie:SharedObject = SharedObject.getLocal("KKDDR_Highscore");
				cookie.data.highscore = null;
				cookie.flush();
				trace("Score deleted");
			}
			
			// Mit Enter Spiel starten
			if (Input.pressed(Key.ENTER)) FP.world = new Level();
			
			super.update();
		}
		
	}

}