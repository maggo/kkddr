package org.mgo.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import org.mgo.Level;
	import org.mgo.Game;
	
	/**
	 * Punktezähler
	 * @author Maggo
	 */
	public class PtsCounter extends Entity
	{
		/**
		 * Text-Klasse
		 */
		public var counter:Text;
		
		public function PtsCounter() 
		{
			// Initialisieren
			Text.size = 32;
			counter = new Text("Score: 99999999999");
			counter.color = 0x000000;
			
			graphic = counter;
			
			super(10, 5, counter);
		}
		
		override public function added():void 
		{
			// Nicht mitscrollen
			graphic.scrollY = 0;
		}
		
		override public function update():void 
		{
			// Punkteanzeige aktualisieren
			counter.text = "Score: " + Game.score.toString();
		}
		
	}

}