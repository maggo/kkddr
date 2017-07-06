package org.mgo
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * Hauptklasse, initialisiert Menü und Variablen
	 * @author Marco Kaul
	 */
	public class Game extends Engine
	{
		/**
		 * Aktueller Spielstatus
		 */
		public static var state:int;
		
		/**
		 * Aktueller Punktestand
		 */
		public static var score:int;
		
		/**
		 * Initialien des Spielers
		 */
		public static var initialien:String = "";
		
		/**
		 * Debugmodus
		 */
		public static var DEBUG:Boolean = false;
		
		public function Game():void 
		{
			// Neues Spiel mit den Maßen 320x480 Pixel initialisieren
			super(320, 480);
		}
		
		/**
		 * Begin des Spiels
		 */
		override public function init():void 
		{
			// Definiere Tasten
			
			Input.define("left", Key.LEFT);
			Input.define("right", Key.RIGHT);
			Input.define("special", Key.SPACE);

			// Zeige Menü
			FP.world = new Menu();
			
			// Nintendo Gameboy Classic Hintergrundfarbe
			FP.screen.color = 0xC3CFA1;
			
			// Debugkonsole
			if (DEBUG) {
				FP.console.enable();
				FP.console.toggleKey = Key.SPACE;
			}
			
		}
		
	}
	
}