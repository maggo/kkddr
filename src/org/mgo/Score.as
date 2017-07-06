package org.mgo 
{
	import flash.display.BitmapData;
	import flash.net.SharedObject;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import org.mgo.entities.Button;
	import org.mgo.entities.FPTextField;
	
	/**
	 * Punktetafel füttern, auslesen und anzeigen
	 * @author Marco Kaul
	 */
	public class Score extends World
	{
		/**
		 * Highscoreliste aus Flashcookie
		 */
		public var scores:Array;
		
		public function Score() 
		{
			// Wenn Debugmodus - Punktestand setzen
			if(Game.DEBUG) Game.score = 0;
			
			// Setze Status
			Game.state = State.HIGHSCORE;
			
			// FlashCookie in Variable
			var cookie:SharedObject = SharedObject.getLocal("KKDDR_Highscore");
			
			// Wenn keine Highscoredaten gesichert sind, erstelle eine Beispielliste - DEBUGMODUS: Immer neue Liste erstellen
			if (cookie.data.highscore == null || Game.DEBUG) {
				cookie.data.highscore = new Array(
					{name: "LOL", score: "5678" },
					{name: "OMG", score: "4567" },
					{name: "BBQ", score: "3456" },
					{name: "FTW", score: "2345" },
					{name: "KRZ", score: "1234" }
				);
				
				// Cookie speichern
				cookie.flush();
			}
			
			// Punkte in Array
			scores = cookie.data.highscore;
		}
		
		/**
		 * Wenn Level beginnt
		 */
		override public function begin():void 
		{
			// Punktestand übernehmen
			var playerscore:int = Game.score;
			
			
			// Prüfen ob Spieler in der Highscoreliste steht, wenn ja Eintragen.
			var ind:int = -1;
			
			for (var i:int = 0; i < scores.length; i++) {
				if (playerscore > scores[i].score) {
					scores.splice(i, 0, { name: Game.initialien, score: playerscore } );
					scores.pop();
					var cookie:SharedObject = SharedObject.getLocal("KKDDR_Highscore");
					cookie.data.highscore = scores;
					cookie.flush();
					ind = i;
					break;
				}
			}
			
			// Punkte zeichnen
			drawScore(ind);
		}
		/**
		 * Wenn Level endet.
		 */
		override public function end():void 
		{
			// Punktestand zum Neustart zurücksetzen
			Game.score = 0;
		}
		
		override public function update():void 
		{
			// Zurück?
			if (Input.check(Key.ESCAPE)) FP.world = new Menu();
			super.update();
		}
		
		/**
		 * Zeichnet die Punktetabelle
		 */
		private function drawScore(ind:int):void {
			
			// Überschrift
			Text.size = 56;
			var text:Text = new Text("HIGHSCORE");
			text.color = 0x000000;
			add(new Entity(FP.halfWidth - text.width / 2, 8, text));
			
			// Trennstrich
			add(new Entity(0, 68, new Image(new BitmapData(FP.width, 5, false, 0x000000))));
			
			// Textgröße
			Text.size = 32;
			
			// Entfernung y Achse
			var tableoffset:int = 96;
			
			// Zeilenhöhe y
			var tablelineheight:int = 35;
			
			// Zeichne Punkestände
			for (var index:String in scores) {
				var t:Text;
				
				// Wenn Eintrag neu
				if (ind == int(index)) {
					// Hintergrundleiste
			
					add(new Entity(0, (tablelineheight * int(index) + tableoffset) - 2, new Image(new BitmapData(FP.width, 36, false, 0x8a956d))));
				}
				// Stand
				t = new Text((int(index) + 1) + ".");
				t.color = 0x000000;
				add(new Entity(20, 	tablelineheight * int(index) + tableoffset, t));
				
				// Initialien
				t = new Text(scores[index].name);
				t.color = 0x000000;
				add(new Entity(60, 	tablelineheight * int(index) + tableoffset, t));
				
				// Punkte
				t = new Text(scores[index].score);
				t.color = 0x000000;
				add(new Entity(160, tablelineheight * int(index) + tableoffset, t));
			}
			
			// Spieler hat Punkte
			if (Game.score != 0) {
				// Punkte anzeigen
				var scoreent:Entity = new Entity(0, FP.height - 145, new Text("Score: " + Game.score));
				(scoreent.graphic as Text).color = 0x000000;
				scoreent.x = FP.halfWidth - (scoreent.graphic as Text).width /2;
				add(scoreent);
			}
			
			// Zurück-Button
			add(new Button(FP.halfWidth - 65, FP.height - 56, new Image(Assets.BACK_BUTTON), new Image(Assets.BACK_BUTTON_ACTIVE), function():void { FP.world = new Menu(); } ));
		}
		
	}

}