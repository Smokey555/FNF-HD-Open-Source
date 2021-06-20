package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;
import lime.utils.Assets;
import flixel.math.FlxMath;
import flixel.text.FlxText;

using StringTools;

class ConfigMenu extends MusicBeatState
{

	public static var startSong:Bool = true;

	var configText:FlxText;
	var descText:FlxText;
	var configSelected:Int = 0;
	
	var offsetValue:Float;
	var accuracyType:String;
	var accuracyTypeInt:Int;
	var	cutsceneTypeInt:Int;
	var accuracyTypes:Array<String> = ["none", "simple", "complex"];
	var cutsceneTypes:Array<String> = ["story", "everywhere", "diaper mode"];
	//EVERYWHERE? LIKE FROM  EVERYWHERE AT THE END OF TIME FROM FNF?
	var healthValue:Int;
	var healthDrainValue:Int;
	var iconValue:Bool;
	var downValue:Bool;
	var inputValue:Bool;
	var cutsceneValue:String;
	var glowValue:Bool;
	var randomTapValue:Bool;
	var disableDodgeSoundValue:Bool;
	
	var canChangeItems:Bool = true;

	var leftRightCount:Int = 0;
	public static var ingame:Bool = false;
	
	var settingDesc:Array<String> = [
		"Adjust note timings.\nPress \"ENTER\" to start the offset calibration." + (FlxG.save.data.ee1?"\nHold \"SHIFT\" to force the pixel calibration.\nHold \"CTRL\" to force the normal calibration.":""), 
		"What type of accuracy calculation you want to use. Simple is just notes hit / total notes. Complex also factors in how early or late a note was.", 
		"Modifies how much Health you gain when hitting a note.",
		"Modifies how much Health you lose when missing a note.",
		"Turns on HD Icons.",
		"Makes notes appear from the top instead the bottom.",
		"Disables miss stun and plays miss animations for missed notes.",
		"Makes note arrows glow if they are able to be hit.\n[This disables modded note arrows unless there is a version of the files included in the mod.]",
		"Prevents you from missing when you don't need to play.",
		"Toggle Cutscenes. Everywhere option enables them in Freeplay. (Diaper mode turns them off, pussy.)",
		"Disable the dodge sound effect.",
		"Change custom key binds."
		
									];


	override function create()
	{	
		trace('INGAME MODE : ' + ingame);
		if(startSong)
			FlxG.sound.playMusic(Paths.music("configurator", "fpsPlus"), 1, true);
		else
			startSong = true;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('optionsHD'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0;
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
	
		
		Config.reload();
		
		offsetValue = Config.offset;
		accuracyType = Config.accuracy;
		accuracyTypeInt = accuracyTypes.indexOf(Config.accuracy);
		healthValue = Std.int(Config.healthMultiplier * 10);
		healthDrainValue = Std.int(Config.healthDrainMultiplier * 10);
		iconValue = Config.betterIcons;
		downValue = Config.downscroll;
		inputValue = Config.newInput;
		cutsceneValue = Config.disableCutscenes;
		glowValue = Config.noteGlow;
		randomTapValue = Config.noRandomTap;
		disableDodgeSoundValue = Config.disableDodgeSound;
		cutsceneTypeInt = cutsceneTypes.indexOf(Config.disableCutscenes);
		
		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');
		var optionTitle:FlxSprite = new FlxSprite(0, 45);
		optionTitle.frames = tex;
		optionTitle.animation.addByPrefix('selected', "options white", 24);
		optionTitle.animation.play('selected');
		optionTitle.scrollFactor.set();
		optionTitle.antialiasing = true;
		optionTitle.updateHitbox();
		optionTitle.screenCenter(X);
			
		add(optionTitle);
			
		
		configText = new FlxText(0, 200, 1280, "", 48);
		configText.scrollFactor.set(0, 0);
		configText.setFormat(Paths.font("Funkin-Bold.otf"), 48, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		configText.borderSize = 3;
		configText.borderQuality = 1;
		
		descText = new FlxText(100, 660, 720, "", 20);
		descText.scrollFactor.set(0, 0);
		descText.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.borderQuality = 1;

		add(configText);
		add(descText);

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		switch(configSelected){
			case 0:
				configText.text = 
				"> NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 1:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\n> ACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 2:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\n> HP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +
				"\nCUTSCENES: " + cutsceneValue +
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue + 
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 3:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\n> HP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 4:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\n> HD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 5:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\n> DOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 6:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\n> NEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 7:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\n>NOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 8:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\n>ALLOW GHOST TAPPING: " + randomTapValue + 
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 9:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +  
				"\n>CUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 10:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +  
				"\nCUTSCENES: " + cutsceneValue + 
				"\n>DISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n[EDIT KEY BINDS]\n" +
				"\n";
			case 11:
				configText.text = 
				"NOTE OFFSET: " + offsetValue + "ms" +
				"\nACCURACY DISPLAY: " + accuracyType + 
				"\nHP GAIN MULTIPLIER: " + healthValue / 10.0 + 
				"\nHP DRAIN MULTIPLIER: " + (healthDrainValue / 10.0) + 
				"\nHD HEALTH HEADS: " + iconValue +
				"\nDOWNSCROLL: " + downValue +
				"\nNEW INPUT: " + inputValue +
				"\nNOTE GLOW: " + glowValue +
				"\nALLOW GHOST TAPPING: " + randomTapValue +  
				"\nCUTSCENES: " + cutsceneValue + 
				"\nDISABLE DODGE SOUND: " + disableDodgeSoundValue +
				"\n>[EDIT KEY BINDS]\n" +
				"\n";
		}
		
	
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(canChangeItems){
			if (controls.UP_P)
				{
					FlxG.sound.play(Paths.sound("scrollMenu"));
					changeItem(-1);
				}

				if (controls.DOWN_P)
				{
					FlxG.sound.play(Paths.sound("scrollMenu"));
					changeItem(1);
				}
				
				switch(configSelected){
					case 0: //Offset
						if (controls.RIGHT_P)
						{
							FlxG.sound.play(Paths.sound("scrollMenu"));
							offsetValue += 1;
						}
						
						if (controls.LEFT_P)
						{
							FlxG.sound.play(Paths.sound("scrollMenu"));
							offsetValue -= 1;
						}
						
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64) {
								offsetValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64) {
								offsetValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}

						if(FlxG.keys.justPressed.ENTER){
							FlxG.sound.music.fadeOut(0.3);
							Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, inputValue, glowValue, randomTapValue, cutsceneValue, disableDodgeSoundValue);
							AutoOffsetState.forceEasterEgg = FlxG.keys.pressed.SHIFT ? 1 : (FlxG.keys.pressed.CONTROL ? -1 : 0);
							FlxG.switchState(new AutoOffsetState());
						}
						
					case 1: //Accuracy
						if (controls.RIGHT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								accuracyTypeInt += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								accuracyTypeInt -= 1;
							}
							
							if (accuracyTypeInt > 2)
								accuracyTypeInt = 0;
							if (accuracyTypeInt < 0)
								accuracyTypeInt = 2;
							
							
							accuracyType = accuracyTypes[accuracyTypeInt];
							
					case 2: //Health Multiplier
						if (controls.RIGHT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								healthValue += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								healthValue -= 1;
							}
							
							if (healthValue > 50)
								healthValue = 0;
							if (healthValue < 0)
								healthValue = 50;
								
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
								
					case 3: //Health Drain Multiplier
						if (controls.RIGHT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								healthDrainValue += 1;
							}
							
							if (controls.LEFT_P)
							{
								FlxG.sound.play(Paths.sound("scrollMenu"));
								healthDrainValue -= 1;
							}
							
							if (healthDrainValue > 100)
								healthDrainValue = 0;
							if (healthDrainValue < 0)
								healthDrainValue = 100;
								
						if (controls.RIGHT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthDrainValue += 1;
							}
						}
						
						if (controls.LEFT)
						{
							leftRightCount++;
							
							if(leftRightCount > 64 && leftRightCount % 10 == 0) {
								healthDrainValue -= 1;
							}
						}
						
						if(!controls.RIGHT && !controls.LEFT)
						{
							leftRightCount = 0;
						}
					case 4: //Heads
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play(Paths.sound("scrollMenu"));
							iconValue = !iconValue;
						}
					case 5: //Downscroll
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play(Paths.sound("scrollMenu"));
							downValue = !downValue;
						}
					case 6: //Miss Stun
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play(Paths.sound("scrollMenu"));
							inputValue = !inputValue;
						}
					case 7: //Note Glow
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play(Paths.sound("scrollMenu"));
							glowValue = !glowValue;
						}
					case 8: //Random Tap 
						if (controls.RIGHT_P || controls.LEFT_P) {
							FlxG.sound.play(Paths.sound("scrollMenu"));
							randomTapValue = !randomTapValue;
						}
					case 9: //Cutscene shit
						if (controls.RIGHT_P)
						{
							FlxG.sound.play(Paths.sound("scrollMenu"));
							cutsceneTypeInt += 1;
						}
							
						if (controls.LEFT_P)
						{
							FlxG.sound.play(Paths.sound("scrollMenu"));
							cutsceneTypeInt -= 1;
						}
						
							
						if (cutsceneTypeInt > 2)
							cutsceneTypeInt = 0;
						if (cutsceneTypeInt < 0)
							cutsceneTypeInt = 2;
						cutsceneValue = cutsceneTypes[cutsceneTypeInt];
					case 10: //Disable High Sound
					if (controls.RIGHT_P || controls.LEFT_P) {
						FlxG.sound.play(Paths.sound("scrollMenu"));
						disableDodgeSoundValue = !disableDodgeSoundValue;
					}

					case 11: //Binds
						if (FlxG.keys.justPressed.ENTER) {
							canChangeItems = false;
							FlxG.sound.play(Paths.sound("scrollMenu"));
							Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, inputValue, glowValue, randomTapValue, cutsceneValue, disableDodgeSoundValue);
							FlxG.switchState(new KeyBindMenu());
						}
						
			}
		}

			if (controls.BACK)
			{
				Config.write(offsetValue, accuracyType, healthValue / 10.0, healthDrainValue / 10.0, iconValue, downValue, inputValue, glowValue, randomTapValue, cutsceneValue, disableDodgeSoundValue);
				canChangeItems = false;
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.sound("cancelMenu"));
				if (ingame)
				FlxG.switchState(new PlayState());
				else
				FlxG.switchState(new MainMenuState());
			}

			if (FlxG.keys.justPressed.R)
				{
					Config.resetSettings();
					FlxG.save.data.ee1 = false;

					canChangeItems = false;

					FlxG.sound.music.stop();
					FlxG.sound.play(Paths.sound("cancelMenu"));

					if (ingame)
					FlxG.switchState(new PlayState());
					else
					FlxG.switchState(new MainMenuState());
				}
		

		super.update(elapsed);
		
		changeItem();
		
	}

	function changeItem(huh:Int = 0)
	{
		configSelected += huh;
			
		if (configSelected > settingDesc.length - 1)
			configSelected = 0;
		if (configSelected < 0)
			configSelected = settingDesc.length - 1;
			
		descText.text = settingDesc[configSelected];
	}
}



/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXxooodk0KNWMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNXKXNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc. .  ...,:ldx0KNWMMMMMMMMMMMMMMWN0kdl:;,'.'dNMMMMMMMMMMMMMMMWWNXNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0' ..............,coxOKNWWMMMMWKxc,........ .xWMMMMMMMMMMWN0xoc;''cKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKxdoddkOKNWMMMMMMM0, ....................,;:ok0kc........... .dWMMMMMWNX0xoc,.. ... .cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx'. ......';codkKNWNl.......................................  .dKXKOxoc;............. .dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK; ...............':l:. ............................................................... cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0, ..................    .............................................................. cNMMMWMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK: .....................   ...........................................................  ,llc::oKMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx. .................................................................................   .....  cNMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMWXkxkKNWMMMNo. ......................................................................................... :XMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMK:. ..,cdkKNNx' ....................................................................................... .lNMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMk. ........,coc.  ..................................................................................... .,oONMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMk. .............   ...................................................................................  .. .cKMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMO' ........................................................................................................ .xMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMK: ........................................................................................................ .xWMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMWd. ....................................................................................................... .kMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMO' ....................................................................................................... ;KMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMNl. ..................................................................................................... .xWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMO' .................................................................................................... .lNMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMNl......................................................................................................:KMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMM0, .................................................................................................. .;lokNMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMWd. ................................................................................................   .. .:0WMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMK; ....................................................................................................... cXMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMWk. ........................................................................ ............................ .oNMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMWXkdolllc.  ..................................................................,:cc:;'.    .......................:KMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMWx'. ......     ........................................................... .,clcc::;,,,;;.. ....................:KMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMWx. ........................................................................,;;,''',,,,'''..  ................ .oXMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMWx. .....................................................................cOOo;.......'''.. ..  ..............;OWMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMWx' ............................... ...';c:;'...........................cl,.. .,,''',,,,..;o' ........... .lXMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMWk,.............................  ..'',:cc:;,.    ......................'od..',,...',,,..:x,  .......... .lONMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMW0:. ........................ ..'''...','''',;lddl,.................. .oKx...,,''',,,'..,,.. ..............;xXWMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMNd' ...................... .:oc,.............;lxkl................. .''.. ...........';ll. .............. .,dXMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMW0:. .................... ':'. ..,,,''',,...,c,,;'.........      .        ..,:llodk0XN0; ................. .;OWMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMXd. ................... ..,;..',,,...',,..;0Kl. .......  ..................'cx0NMWKd'.................... .cNMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMWx.  .................   ck,..,,,'..',,...;c;. ............................ ..;c;...................... .:0WMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMK; .. ................  .::...'''''.....,:c,..................................   ................... .,xNMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.';..   .............  ........',:loc,,,......................................   .................:xXMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMW0: ..................... .,lk000KXNWMNd,...........................................  .......... .;d0WMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMKc.. ....................... .cx0KXXKOd:...............................................  .... ... ,0MMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMM0;  ....................................................................................      'll..oNMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMWKo'. ....................................................................................  . ;dxc..dNMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMWK: .....................................................................................  .:xxdc..oXMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.'c:,.... ............................................................................. .,dxxxl'.:OWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMM0,.:xxxdol:;,'............................................................................ .;dxxxo;..cOWMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.'oxxxxxxxxxdolcc:,. .'.......  ..............',;;::clllcc:;,'............................ .lxxxxdo;..:xXMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMKc.'loclxxxxxxxxxxxxxo'.oXKOkxxddoooooooooooodk0KXNWWWMMMMMMMWWNXK0Okdlc;'... ............... .;dxxxxxxl' .kMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMM0;.,oxc'cxxxxxxxxxxxxxo'.oWMMMMMMMMMMMMMMMMMMMMMMMMWWNNNNWMMMMMMMMMMMMMMWWX0kdl:,.............. 'oxxxxxo;..dXMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMNc.'oxd,.cxxxdddxxxxxxxd;.:XMMMMMMMMMMMMMMMMMMMN0xolc::::::coollcccxXMMMMMMMMMMMWX0xl;. ........ .cxxxo:..c0WMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMNo..,;,..:dxxdc;:ldxxxxxc..;ldkKNWMMMMMMMMMMMMWk::clxkO00OxolloddxxONMMMMMMMMMMMMMMMWk,.........  ;ol;..;kNMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMW0oc:cc'.:oxxdc..';codxo, .''.',:ldkOKNWMMMMMMNXWMMMMMMNx:l0WMMMMMMMMMMMMMMMMMMMMNOc..;loc,.  .  ...,ckNMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMWO:..;::'... ..',:,..'col:;,'..',:ldkOKXNWMMMMMMMWKO0NMMMMMMMMMMMMMMMMMMNOo,..;ldxxxd;  .  .o0NWMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOo:;;cxk; ':;,'....,oxxxxddol:;,'.''',:clodkOKXNWWMMMMMMMMMMMMMMMWXkl,..;cdxxxxxxd;.,xxokNMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNWWMX:.;dxdl:clodxxxxxxxxxxxxddolc. ':::;,,,,;:clodxk0KXXNXKOdc'.';cdxxdccllc;'.,kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNl.,oo;..:dxxxxxxoodxxxxxxxxxd,.cKNWNX0k, .,,''''''',,,'..,:ldxxxxxo'..'',lkXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx...... ,dxxxxxl;cxxxxxxxxxxd;.;xKMMMMX: ;dxxxddolllllllodxxxxo;:ol..lKXNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,:xO:.,dxxdo;.,dxxxxxxxxxxxc.'cOMMMMX:.;dxxxxxxxxxxxxc;oxxxo, ....,0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNWMNc.,doc,....lxxxdlodxxxxl..:kMMMMK;.:xxxxxxxxxxxxd;'lxxd:.'llclOWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo..'..;dOc.'oxd;..:dxxxl..,xWMMM0'.cxxddxxxxxxxxo'.':l;..xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo:cd0NMMO'.;c'.''.'codo'..oWMMMk..'c:,':odxxxxd;..;,..;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMMMMMMWd...;dKKd;..''.  :XMMWx..',',,'.';:cc;.'kNXKKNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOkOXNNNNKOdoo:. 'ONWWk.'kXKXNKko:;,',cOWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOl:;;,,,,;;;;'. .',:OO'.,:::ccclodOXNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNc...........'''''. .kK; ........ .dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk'..'........',,'..cNXc .,,,,,,..'kMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd......,'...,,,..'OMWd..',,,,'..dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0; .......',,,'..cXMM0, ...'.. 'xXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0Oxo:,....,''',,,,'...,x0NNk;..    ...':okKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0:......''',,,,,,,,,'......,:l:...  .','....'xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx..',,,,,,,,,,,,,,,,....ldl:;',;l:. .,,,,,,. ,0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWd..',,,,,,,,,,,,,,,,....lxxxxxxxxo, .,,,,,,'..lNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx..',,,,,,,,,,,,,,,,'...cxxxxxxxxxc..',,,,,,. '0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk..',,,,,,,,,,,,,,,,''..,dxxxxxxxxo'..,,',,,'..dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk..',,,'..',,,,,,,,,,,...:xxxxxxxxx:..''..',,..cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx..',,,'...,,,,,,,,,,,'..,dxxxxxxxxl. .'. .',. ,0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
*/