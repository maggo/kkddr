package org.mgo.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * Menübuttons
	 * @author Maggo
	 */
	public class Button extends Entity
	{
		public var onClick:Function;
		public var normalgraphic:Image;
		public var activegraphic:Image;
		
		private var selectsound:SfxrSynth;
		private var pressedsound:SfxrSynth;
		
		private var mouseover:Boolean = false;
		
		public function Button(x:Number, y:Number, graphic:Image, activegraphic:Image, onClick:Function=null) 
		{
			this.normalgraphic = graphic;
			this.activegraphic = activegraphic;
			this.onClick = onClick;
			
			// Sounds
			selectsound = new SfxrSynth();
			selectsound.params.setSettingsString("0,,0.1039,,0.1267,0.4109,,,,,,,,0.0606,,,,,1,,,0.1,,0.5");
			
			pressedsound = new SfxrSynth();
			pressedsound.params.setSettingsString("0,,0.1704,,0.1888,0.5371,,,,,,,,0.5441,,,,,1,,,0.1,,0.5");
			
			super(x, y, graphic);
		}
		
		override public function added():void 
		{
			// Hitbox setzen
			setHitbox(normalgraphic.width-2, normalgraphic.height-2);
		}
		
		override public function update():void 
		{
			// Mouseover
			if (collidePoint(x, y, Input.mouseX, Input.mouseY) && mouseover == false) {
				mouseover = true;
				
				selectsound.play();
				
				graphic = activegraphic;
				
			} else if(!collidePoint(x, y, Input.mouseX, Input.mouseY) && mouseover == true) {
				mouseover = false;
				graphic = normalgraphic;
			}
			
			// Angegebene Funktion ausführen
			if (mouseover) {
				if (onClick != null && Input.mousePressed) {
					pressedsound.play();
					onClick();
				}
			}
		}
		
	}

}