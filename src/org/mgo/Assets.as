package org.mgo 
{
	/**
	 * Klasse zur Verwaltung von Grafiken
	 * @author Marco Kaul
	 */
	public class Assets
	{
		[Embed(source = '../../assets/player.png')] 				public static const PLAYER				:Class;
		[Embed(source = '../../assets/platform.png')] 				public static const PLATFORM			:Class;
		[Embed(source = '../../assets/altplatform.png')] 			public static const ALTPLATFORM			:Class;
		[Embed(source = '../../assets/ground_game.png')] 			public static const GROUND				:Class;
		[Embed(source = '../../assets/ground_menu.png')] 			public static const GROUND_MENU			:Class;
		[Embed(source = '../../assets/cloud.png')] 					public static const CLOUD				:Class;
		[Embed(source = '../../assets/kkddr_logo.png')] 			public static const LOGO				:Class;
		[Embed(source = '../../assets/score_button.png')] 			public static const SCORE_BUTTON		:Class;
		[Embed(source = '../../assets/start_button.png')] 			public static const START_BUTTON		:Class;
		[Embed(source = '../../assets/score_button_active.png')] 	public static const SCORE_BUTTON_ACTIVE	:Class;
		[Embed(source = '../../assets/start_button_active.png')] 	public static const START_BUTTON_ACTIVE	:Class;
		[Embed(source = '../../assets/back_button.png')] 			public static const BACK_BUTTON			:Class;
		[Embed(source = '../../assets/back_button_active.png')] 	public static const BACK_BUTTON_ACTIVE	:Class;
		[Embed(source = '../../assets/monster_muncher.png')] 		public static const MONSTER_MUNCHER		:Class;
		[Embed(source = '../../assets/monster_sizzler.png')] 		public static const MONSTER_SIZZLER		:Class;
		[Embed(source = '../../assets/monster_spikey.png')] 		public static const MONSTER_SPIKEY		:Class;
	}

}