package org.mgo.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import org.mgo.Game;
	
	/**
	 * Textfeld zur Eingabe der Initialien
	 * @author Maggo
	 */
	public class FPTextField extends Entity 
	{
		/**
		 * Text Klasse
		 */
		public var textobj:Text;
		
		/**
		 * Die letzten Eingaben
		 */
		private var lastkeys:String;
		
		public function FPTextField(x:int, y:int) 
		{
			// Initialisieren
			Text.size = 32;
			textobj = new Text("Initials: XXX");
			
			textobj.color = 0x000000;
			super(x, y, textobj);
		}
		
		override public function added():void 
		{
			// Zeige die letzten 3 Buchstaben an
			Input.keyString = Game.initialien;
			lastkeys = Input.keyString;
			if (Game.initialien.length == 3) {
				textobj.text = "Initials: " + Input.keyString;
			} else {
				textobj.text = "Initials: " + Input.keyString + "_";
			}
		}
		
		override public function update():void 
		{
			// Aktualisiere Anzeige
			if (lastkeys != Input.keyString) {
				if (Input.keyString.length + 1 > 3) {
					Game.initialien = Input.keyString.toUpperCase();
					textobj.text = "Initials: " + Input.keyString.toUpperCase();
					Input.keyString = Input.keyString.slice(0, 2);
				} else {
					textobj.text = "Initials: " + Input.keyString.toUpperCase() + "_";
				}
				lastkeys = Input.keyString;
			}	
		}
		
	}

}