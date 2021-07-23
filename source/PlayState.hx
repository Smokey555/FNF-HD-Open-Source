package;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFramesCollection;
import flixel.effects.FlxFlicker;
#if desktop
import Discord.DiscordClient;
#end
import Section.SwagSection;
import Song.SwagSong;
import flixel.util.FlxAxes;

import flixel.FlxCamera;
import flixel.FlxG;
import flash.system.System;
import flixel.FlxObject;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.effects.FlxTrail;

import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;

using StringTools;

class PlayState extends MusicBeatState
{

	public static var pubCurBeat = 0;

	private var misses:Int = 0;
	private var totalPlayed:Float = 0;
	private var totalNotesHit:Float = 0;
	private var accuracy:Float = 100;

	private var invulnCount:Int = 0;
	private var canHit:Bool = false;
	private var noMissCount:Int = 0;
	private var ayoLookOut:FlxSprite;
	private var gameEnd:Bool = false;

	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var fuckCval:Bool;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;

	var halloweenLevel:Bool = false;

	private var dialogueList = CoolUtil.coolTextFile("assets/data/dialogueList.txt");
	private var dialogueEndList = CoolUtil.coolTextFile("assets/data/dialogueEndList.txt");

	private var vocals:FlxSound;

	private var dad:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;

	var isStressed:String;
	var shootBeats:Array<Int> = [32, 48, 64, 80, 104, 120, 160, 163, 165, 168, 171, 173, 200, 216, 224, 232, 240, 248, 256];
	var shootBeatsBSide:Array<Int> = [32,36,40,44,48,52,56,64,68,72,76,80,88,94,104,108,112,116,120,160, 163, 165, 168, 171, 173,180,184,188,196,200,204,208,216, 224, 232, 240, 248, 256];
	var shootBeatsMilf:Array<Int> = [24,32,40,104,136,192,193,194,195,196,197,198,199,240,242,244,245,246,252,260,261,262,275,296,304,312,325,327,348,356,360];
	var lampMilf:Int = 72;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private var camDoTheThing:Bool = true;

	private static var prevCamFollow:FlxObject;

	private var strumLineNotes:FlxTypedGroup<FlxSprite>;
	private var playerStrums:FlxTypedGroup<FlxSprite>;

	private var camZooming:Bool = false;
	private var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;

	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	
	var bgLimo:Week4Stage;

	private var camHUD:FlxCamera;
	private var camOverlay:FlxCamera;
	private var camDialogue:FlxCamera;
	private var camGame:FlxCamera;

	private var gfAnimate:Bool = true;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];
	var dialogueEnd:Array<String> = ['ayooooo', 'swagcool'];
	var usesDialogue:Bool = false;
	var usesEndDialogue:Bool = false;
	var doof:DialogueBox;
	var overlay:FlxSprite;
	var doof2:DialogueBox;
	var skyBG:FlxSprite;
	var fReturn:String;
	var lamp:FlxSprite;
	var hitbox:FlxSprite;
	var dodgelamp:FlxSprite;
	var dodgepole:FlxSprite;
	var pole:FlxSprite;
	var datebg:FlxSprite;
	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;
	var overlaySpook:FlxSprite;
	var tiddies:FlxSprite;
	public static var timerStop:Bool = false;
	public static var poleTimer:FlxTimer;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var limo:FlxSprite;
	var dancers:BackgroundDancer;
	var fastCar:FlxSprite;
	var billboard:FlxSprite;
	var bgEscalator:FlxSprite;
	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;
	var freshCrowd:FlxSprite;

	//Wacky input stuff=========================

	private var skipListener:Bool = false;

	private var upTime:Int = 0;
	private var downTime:Int = 0;
	private var leftTime:Int = 0;
	private var rightTime:Int = 0;

	private var upPress:Bool = false;
	private var downPress:Bool = false;
	private var leftPress:Bool = false;
	private var rightPress:Bool = false;
	
	private var upRelease:Bool = false;
	private var downRelease:Bool = false;
	private var leftRelease:Bool = false;
	private var rightRelease:Bool = false;

	private var upHold:Bool = false;
	private var downHold:Bool = false;
	private var leftHold:Bool = false;
	private var rightHold:Bool = false;

	//End of wacky input stuff===================


	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

	var talking:Bool = true;
	
	var songScore:Int = 0;
	var scoreTxt:FlxText;

	public static var campaignScore:Int = 0;

	var defaultCamZoom:Float = 1.05;

	// how big to stretch the pixel art assets
	public static var daPixelZoom:Float = 6;

	var inCutscene:Bool = false;

	#if desktop
	// Discord RPC variables
	var storyDifficultyText:String = "";
	var iconRPC:String = "";
	var songLength:Float = 0;
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	override public function create()
	{



		//trace('tolu'); - no.
		
		trace(Config.disableCutscenes);
		Conductor.setSafeZone();
		canHit = !Config.noRandomTap;
		noMissCount = 0;
		invulnCount = 0;
		GameOverSubstate.gotfuckinblown = false;
		GameOverSubstate.gofuckingdecked = false;
	//	FlxG.sound.cache(Paths.inst(PlayState.SONG.song));
		//FlxG.sound.cache(Paths.voices(PlayState.SONG.song));
		
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camOverlay = new FlxCamera();
		camOverlay.bgColor.alpha = 0;
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camDialogue = new FlxCamera();
		camDialogue.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camOverlay);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camDialogue);

		FlxCamera.defaultCameras = [camGame];
		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);
	
			if(dialogueList.contains(SONG.song.toLowerCase())){
				dialogue = CoolUtil.coolTextFile("assets/data/" + SONG.song.toLowerCase() + "/dialogue.txt");
				usesDialogue = true;
			}

			if(dialogueEndList.contains(SONG.song.toLowerCase())){
				dialogueEnd = CoolUtil.coolTextFile("assets/data/" + SONG.song.toLowerCase() + "/dialogueEnd.txt");
				usesEndDialogue = true;
			}
		

		#if desktop
		// Making difficulty text for Discord Rich Presence.
		switch (storyDifficulty)
		{
			case 0:
				storyDifficultyText = "Easy";
			case 1:
				storyDifficultyText = "Normal";
			case 2:
				storyDifficultyText = "Hard";
		}

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'senpai-angry':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;
		
		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
		#end
		
		switch (SONG.song.toLowerCase()) {
		case 'spookeez' | 'monster' | 'south':
		{
			curStage = "spooky";
			halloweenLevel = true;

			overlaySpook = new FlxSprite(-40, 50).loadGraphic(Paths.image('overlay'));
			overlaySpook.setGraphicSize(Std.int(overlaySpook.width * 1.5));
		

			var hallowTex = Paths.getSparrowAtlas('halloween_bg');
			
			halloweenBG = new FlxSprite(-200, -100);
			halloweenBG.frames = hallowTex;
			halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
			halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
			halloweenBG.animation.play('idle');
			halloweenBG.antialiasing = true;
			add(halloweenBG);

			isHalloween = true;
		}
		case  'pico' | 'blammed' | 'philly':
		{
			curStage = 'philly';

			var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('philly/sky'));
			bg.scrollFactor.set(0.1, 0.1);
			add(bg);

			var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('philly/city'));
			city.scrollFactor.set(0.3, 0.3);
			city.setGraphicSize(Std.int(city.width * 0.85));
			city.updateHitbox();
			add(city);

			phillyCityLights = new FlxTypedGroup<FlxSprite>();
			add(phillyCityLights);

			FlxG.sound.cache(Paths.sound("shooters", "week3"));

			for (i in 0...5)
			{
				var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('philly/win' + i));
				light.scrollFactor.set(0.3, 0.3);
				light.visible = false;
				light.setGraphicSize(Std.int(light.width * 0.85));
				light.updateHitbox();
				light.antialiasing = true;
				phillyCityLights.add(light);
			}

			var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('philly/behindTrain'));
			add(streetBehind);

			if(SONG.song.toLowerCase() == "blammed"){
				phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/trainBlood'));
			}
			else{
				phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('philly/train'));
			}
			
			add(phillyTrain);

			trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
			FlxG.sound.list.add(trainSound);

			// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

			var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('philly/street'));
			add(street);
		}


		case  'breaking-point':
		{
			curStage = 'date';

			defaultCamZoom = 0.7;
			datebg = new FlxSprite(-75,-65);
			
			datebg.frames = Paths.getSparrowAtlas('dateweek/date_night');
			datebg.animation.addByPrefix('stars', 'MarblePawns instance 1', 14, true);
			datebg.antialiasing = true;
			datebg.setGraphicSize(Std.int(datebg.width * 1.3));
			datebg.animation.play('stars');
			add(datebg);
			
			overlay = new FlxSprite(0,0).makeGraphic(1280,720,FlxColor.fromRGB(50,173,207,107));
		
			overlay.blend = 'multiply';
			overlay.scrollFactor.set(0,0);
			overlay.cameras = [camOverlay]; 
			
		}
		case 'milf' |'satin-panties' | 'high':
		{
			//RTX week 4 stage type beat
			curStage = 'limo';

			var kolsan = FlxColor.BLACK;
		

			defaultCamZoom = 0.70;
			ayoLookOut = new FlxSprite(80, 0).loadGraphic(Paths.image("warningNote","week3"));
			ayoLookOut.screenCenter(FlxAxes.Y);
			ayoLookOut.visible = false;
			ayoLookOut.scrollFactor.set();
			FlxFlicker.flicker(ayoLookOut,0);
			skyBG = new FlxSprite(-300, -600).loadGraphic(Paths.image('limo/limoSunset'));
			skyBG.scrollFactor.set(0.1, 0.1);
			add(skyBG);

			FlxG.sound.cache(Paths.sound("laser", "week4"));
			FlxG.sound.cache(Paths.sound("dancerDie", "week4"));
			FlxG.sound.cache(Paths.sound("warning", "week4"));
			FlxG.sound.cache(Paths.sound("news/MILF", "dialogue"));

			billboard = new FlxSprite(-300,-210);
			billboard.frames = Paths.getSparrowAtlas('limo/billboards');
			billboard.antialiasing = true;
			billboard.setGraphicSize(Std.int(billboard.width * 0.7));
			billboard.updateHitbox();
			billboard.scrollFactor.set(0.2,0.2);
			
			
			for (i in 0...8){
			billboard.animation.addByIndices('' + i,'billboards instance 1', [i], "",24, false);
			}
			add(billboard);

			dodgepole = new FlxSprite(-800,-140).loadGraphic(Paths.image('limo/street_pole'));
			dodgepole.antialiasing = true;
			dodgepole.scrollFactor.set(0.3,0.3);
			dodgepole.setGraphicSize(Std.int(dodgepole.width * 0.9));
			dodgelamp = new FlxSprite(-800,-130).loadGraphic(Paths.image('limo/street_light'));
			dodgelamp.antialiasing = true;
			dodgelamp.scrollFactor.set(0.3,0.3);
			dodgelamp.setGraphicSize(Std.int(dodgepole.width * 0.9));
			
			add(dodgepole);
			
			
			var rails:Week4Stage = new Week4Stage(-2150, 450, 'rails');
			rails.scrollFactor.set(0.3, 0.3);
			add(rails);


			var road:Week4Stage = new Week4Stage(-1150, 500, 'road');
			road.scrollFactor.set(0.3, 0.3);
			add(road);


			

			

			bgLimo = new Week4Stage(-200, 280,'bglimo');
			bgLimo.scrollFactor.set(0.4, 0.4);
			add(bgLimo);

			

			
			dancers = new BackgroundDancer(170,bgLimo.y -380);
			dancers.scrollFactor.set(0.4,0.4);
			add(dancers);

			
			
			dancers.dance('alvin');
		

			var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
			overlayShit.alpha = 0.5;
			// add(overlayShit);

			// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

			// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

			// overlayShit.shader = shaderBullshit;

			var limoTex = Paths.getSparrowAtlas('limo/limoDrive');

			limo = new FlxSprite(-120, 550);
			limo.frames = limoTex;
			limo.animation.addByPrefix('drive', "Limo stage", 24, false);
			limo.animation.addByIndices('loop', 'Limo stage', [18,19,20,21,22,23,24,25],'', 24, true);
			limo.animation.play('loop');
			fastCar = new FlxSprite(-300, 100).loadGraphic(Paths.image('limo/fastCarLol'));
			// add(limo);
			var dumbass:Int = 0;
			switch (SONG.song.toLowerCase())
			{
			case 'satin-panties':
			dumbass = 14;
			case 'high':
			dumbass = 60;
			case 'milf':
			skyBG.y += 300;
			dumbass = 73;
			}


			
			pole = new FlxSprite(400,-140).loadGraphic(Paths.image('limo/street_pole'));
			pole.antialiasing = true;
		
			lamp = new FlxSprite(250,-130).loadGraphic(Paths.image('limo/street_light'));
			lamp.antialiasing = true;
			//changing the hitbox for overlap
			lamp.width -= 300;
			lamp.height -= 200;
			hitbox = new FlxSprite(250,-130).makeGraphic(250,250,kolsan);
			hitbox.visible = false;
	
			
			overlay = new FlxSprite(0,0).makeGraphic(1280,720,FlxColor.fromRGB(235,90,63,dumbass));
		
			overlay.blend = 'multiply';
			overlay.scrollFactor.set(0,0);
			overlay.cameras = [camOverlay]; 
			
			

		
			
			

		}
		case 'cocoa' |'eggnog':
		{
			curStage = 'mall';

			defaultCamZoom = 0.60;
			var suffix:String = '';
			if (SONG.song.toLowerCase() == 'eggnog')
				suffix = '-eggnog';

			var bg:FlxSprite = new FlxSprite(-1000, -430).loadGraphic(Paths.image('christmas/bgWalls'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			upperBoppers = new FlxSprite(-480, -220);
			
			upperBoppers.frames = Paths.getSparrowAtlas('christmas/upperBop' + suffix);
			upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
			upperBoppers.antialiasing = true;
			upperBoppers.scrollFactor.set(0.3, 0.3);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.9));
			upperBoppers.updateHitbox();
			add(upperBoppers);

			bgEscalator = new FlxSprite(-700, -200);
			bgEscalator.antialiasing = true;
			bgEscalator.scrollFactor.set(0.3, 0.3);
			bgEscalator.frames = Paths.getSparrowAtlas('christmas/bgEscalator' + suffix);
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			for (i in 0...3){
			bgEscalator.animation.addByPrefix('' + i,'esc' + i, 1, false);
			}
			bgEscalator.updateHitbox();
			bgEscalator.animation.play('1');
			add(bgEscalator);

			var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('christmas/christmasTree'));
			tree.antialiasing = true;
			tree.scrollFactor.set(0.40, 0.40);
			add(tree);

			bottomBoppers = new FlxSprite(-200, 200);
			bottomBoppers.frames = Paths.getSparrowAtlas('christmas/bottomBop');
			bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
			bottomBoppers.antialiasing = true;
			bottomBoppers.scrollFactor.set(0.9, 0.9);
			bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
			bottomBoppers.updateHitbox();
			add(bottomBoppers);

			var fgSnow:FlxSprite = new FlxSprite(-600, 770).loadGraphic(Paths.image('christmas/fgSnow'));
			fgSnow.active = false;
			fgSnow.antialiasing = true;
			add(fgSnow);

			santa = new FlxSprite(-840, 220);
			santa.frames = Paths.getSparrowAtlas('christmas/santa');
			santa.animation.addByPrefix('idle', 'santa idle in fear', 24, false);
			santa.antialiasing = true;
			add(santa);
			overlay = new FlxSprite(0,0);
			overlay.loadGraphic(Paths.image('christmas/overlay_christmas'));
			overlay.setGraphicSize(Std.int(overlay.width * 3), Std.int(overlay.height));
			overlay.updateHitbox();
		
			overlay.blend = 'multiply';
			overlay.scrollFactor.set(0,0);
			overlay.cameras = [camOverlay]; 
			
			
			
			
		}
		case 'winter-horrorland':
		{
			curStage = 'mallEvil';
			var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('christmas/evilBG'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('christmas/evilTree'));
			evilTree.antialiasing = true;
			evilTree.scrollFactor.set(0.2, 0.2);
			add(evilTree);

			var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("christmas/evilSnow"));
			evilSnow.antialiasing = true;
			add(evilSnow);
			overlay = new FlxSprite(0,0);
			overlay.loadGraphic(Paths.image('christmas/overlay_poison'));
			overlay.setGraphicSize(Std.int(overlay.width * 3), Std.int(overlay.height));
			overlay.updateHitbox();
		
			overlay.blend = 'multiply';
			overlay.scrollFactor.set(0,0);
			overlay.cameras = [camOverlay]; 
		}
		case 'senpai' | 'roses':
		{
			curStage = 'school';

			// defaultCamZoom = 0.9;

			var bgSky = new FlxSprite().loadGraphic(Paths.image('weeb/weebSky'));
			bgSky.scrollFactor.set(0.1, 0.1);
			add(bgSky);

			var repositionShit = -200;

			var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('weeb/weebSchool'));
			bgSchool.scrollFactor.set(0.6, 0.90);
			add(bgSchool);

			var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('weeb/weebStreet'));
			bgStreet.scrollFactor.set(0.95, 0.95);
			add(bgStreet);

			var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('weeb/weebTreesBack'));
			fgTrees.scrollFactor.set(0.9, 0.9);
			add(fgTrees);

			var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
			var treetex = Paths.getPackerAtlas('weeb/weebTrees');
			bgTrees.frames = treetex;
			bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
			bgTrees.animation.play('treeLoop');
			bgTrees.scrollFactor.set(0.85, 0.85);
			add(bgTrees);

			var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
			treeLeaves.frames = Paths.getSparrowAtlas('weeb/petals');
			treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
			treeLeaves.animation.play('leaves');
			treeLeaves.scrollFactor.set(0.85, 0.85);
			add(treeLeaves);

			var widShit = Std.int(bgSky.width * 6);

			bgSky.setGraphicSize(widShit);
			bgSchool.setGraphicSize(widShit);
			bgStreet.setGraphicSize(widShit);
			bgTrees.setGraphicSize(Std.int(widShit * 1.4));
			fgTrees.setGraphicSize(Std.int(widShit * 0.8));
			treeLeaves.setGraphicSize(widShit);

			fgTrees.updateHitbox();
			bgSky.updateHitbox();
			bgSchool.updateHitbox();
			bgStreet.updateHitbox();
			bgTrees.updateHitbox();
			treeLeaves.updateHitbox();

			bgGirls = new BackgroundGirls(-100, 190);
			bgGirls.scrollFactor.set(0.9, 0.9);

			if (SONG.song.toLowerCase() == 'roses')
			{
				bgGirls.getScared();
			}

			bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
			bgGirls.updateHitbox();
			add(bgGirls);
		}
		case 'thorns':
		{
			curStage = 'schoolEvil';

			var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
			var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

			var posX = 400;
			var posY = 200;

			var bg:FlxSprite = new FlxSprite(posX, posY);
			bg.frames = Paths.getSparrowAtlas('weeb/animatedEvilSchool');
			bg.animation.addByPrefix('idle', 'background 2', 24);
			bg.animation.play('idle');
			bg.scrollFactor.set(0.8, 0.9);
			bg.scale.set(6, 6);
			add(bg);

		
		}
		default:
		{
			defaultCamZoom = 0.74;
			curStage = 'stage';
			var bg:FlxSprite = new FlxSprite(-1500, -1200).loadGraphic(Paths.image('stageback'));
			bg.setGraphicSize(Std.int(bg.width * 0.5));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

		

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 0.6));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.98, 0.98);
			stageFront.active = false;
			add(stageFront);

			var stageCurtains:FlxSprite = new FlxSprite(-300, -200).loadGraphic(Paths.image('stagecurtains'));
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.47));
			stageCurtains.updateHitbox();
			stageCurtains.antialiasing = true;
			stageCurtains.scrollFactor.set(1.3, 1.3);
			stageCurtains.active = false;

			add(stageCurtains);
			switch (SONG.song.toLowerCase()) {
			case 'bopeebo':

			freshCrowd = new FlxSprite(-50, 650);
			freshCrowd.frames = Paths.getSparrowAtlas('CROWD_FRESH');
			freshCrowd.animation.addByPrefix('crowdBopFresh', 'crowd', 24, true);
			freshCrowd.animation.play('crowdBopFresh', true);
			freshCrowd.antialiasing = true;
			freshCrowd.scrollFactor.set(1, 1);
			freshCrowd.setGraphicSize(Std.int(freshCrowd.width * 1.8));
			freshCrowd.updateHitbox();
			freshCrowd.visible = false;

			case 'fresh':
			freshCrowd = new FlxSprite(-180, 640);
			freshCrowd.frames = Paths.getSparrowAtlas('CROWD_FRESH');
			freshCrowd.animation.addByPrefix('crowdBopFresh', 'crowd', 24, false);
			freshCrowd.antialiasing = true;
			freshCrowd.scrollFactor.set(1.3, 1.3);
			freshCrowd.setGraphicSize(Std.int(freshCrowd.width * 1.8));
			freshCrowd.updateHitbox();
		

			case 'dadbattle':
			freshCrowd = new FlxSprite(-180, 640);
			freshCrowd.frames = Paths.getSparrowAtlas('CROWD_DADBATTLE');
			freshCrowd.animation.addByPrefix('crowdBopFresh', 'crowd 2', 24, false);
			freshCrowd.antialiasing = true;
			freshCrowd.scrollFactor.set(1.3, 1.3);
			freshCrowd.setGraphicSize(Std.int(freshCrowd.width * 1.8));
			freshCrowd.updateHitbox();
			}

		}
	}

		var gfVersion:String = 'gf';

		switch (SONG.song.toLowerCase()) {
			case 'pico' | 'philly':
				gfVersion = 'gfpico';
			case 'blammed':
				gfVersion = 'gfpico2';
		}

		switch (curStage)
		{
			case 'limo':
				gfVersion = 'gf-car';
			case 'mall':
				gfVersion = 'gf-christmas';
			case 'school' | 'schoolEvil':
				gfVersion = 'gf-pixel';
			case 'date': 
				gfVersion = 'gf-date';
			case 'mallEvil':
				gfVersion = 'gf-christmas-dead';
		}
		
		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);
		

		dad = new Character(100, 100, SONG.player2);

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'gf-date':
				dad.setPosition(722,227);
				gf.visible = false;
				camPos.x += 800;
			case "dad" | 'SHAKEYDAD':
				dad.y -= 100;
				dad.scale.set(0.8, 0.8);
			case "spooky":
				dad.y += 200;
			case "monster":
				gf.visible = false;
				dad.y += 50;
			case 'monster-christmas':
				dad.y += 130;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'senpai'| 'senpai-angry':
				dad.x += 150;
				dad.y += 360;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
		}

		boyfriend = new Boyfriend(770, 450, SONG.player1);

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 280;
				boyfriend.x += 320;
				dad.y -= 90;
				dad.x += 60;
				resetFastCar();
				add(fastCar);
				resetBillBoard();
				resetPole(); 
			case 'date':
				boyfriend.x = 1410;
				boyfriend.y = 530;
				gf.x = 722;
				gf.y = 227;
			
			case 'spooky':
				boyfriend.x += 160;
				dad.y += 25;
				
			case 'stage':
				boyfriend.y += 30;
				boyfriend.x += 235;
				
				gf.y -= 70;
				if (SONG.player2 == 'gf')
				dad.y -= 70;
				else
				dad.y += 120;
				dad.x += 30;
				
				camPos.set(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y - 200);
				camPos.x += 600;

			case 'mall':
				boyfriend.x += 200;
			case 'philly':
				gf.x -= 180;
				gf.y -= 40;
				dad.y += 40;
				dad.x -= 40;
				boyfriend.x += 90;
				boyfriend.y += 20;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 130;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'schoolEvil':
				// trailArea.scrollFactor.set();

				var evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);

				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
		}

		add(gf);

		// Shitty layering but whatev it works LOL
		if (curStage == 'limo')
			add(dodgelamp);
			add(limo);


		add(dad);
		add(boyfriend);
		if (curStage == 'stage')
		add(freshCrowd);
		if (curStage == 'spooky')
		add(overlaySpook);
		if (SONG.song.toLowerCase() == 'milf' || SONG.song.toLowerCase() == 'high'){
		add(lamp);
		add(pole);
		add(hitbox);
		add(ayoLookOut);
		ayoLookOut.cameras = [camHUD];
		}
		if (curStage == 'limo' || curStage == 'date' || curStage == 'mall' || curStage == 'mallEvil')
		add(overlay);
		

		if (SONG.song.toLowerCase() == 'blammed' && (FlxMath.roundDecimal(FlxG.sound.music.length / 1000, 2) == 92.09)){
		FlxG.log.add('BSIDES MODE ACTIVATED');
		dialogue = [
			//i did not tell Kenny about this LMAO don't snitch on me -Smokey
		':music:picoMusic3:0.9',
		':pico:angry:Chu think you doin motherfucker?',
		':pico:angry:You think you can just swap out the songs without me noticing?',
		':pico:furious:Imma whoop yo ass even harder than before now!'
		];
	}

		doof = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		doof2 = new DialogueBox(false, dialogueEnd);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof2.scrollFactor.set();
		doof2.finishThing = endReturn;

		Conductor.songPosition = -5000;

		if(Config.downscroll){
			strumLine = new FlxSprite(0, 570).makeGraphic(FlxG.width, 10);
		}
		else {
			strumLine = new FlxSprite(0, 30).makeGraphic(FlxG.width, 10);
		}
		strumLine.scrollFactor.set();

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		generateSong(SONG.song);

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.006);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;

		healthBarBG = new FlxSprite(0, Config.downscroll ? FlxG.height * 0.1 : FlxG.height * 0.875).loadGraphic(Paths.image('healthBar'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		// healthBar
		add(healthBar);

		scoreTxt = new FlxText(healthBarBG.x - 105, (FlxG.height * 0.9) + 36, 800, "", 22);
		scoreTxt.setFormat("assets/fonts/vcr.ttf", 22, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		
	
		if (Config.betterIcons)
		{
		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2)  + 200;
		
		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2) + 200;

		add(iconP1);
		add(iconP2);	
		}
		else
		{
		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		
	
		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);

		add(iconP1);
		add(iconP2);
		}	




		add(scoreTxt);	
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camDialogue];
		doof2.cameras = [camDialogue];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		//if (isStoryMode && !Config.disableCutscenes == )
		if (Config.disableCutscenes == 'everywhere' || (Config.disableCutscenes == 'story' && isStoryMode))
		{
			switch (curSong.toLowerCase())
			{
				case "winter-horrorland":
					var blackScreen:FlxSprite = new FlxSprite(0, 0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.BLACK);
					add(blackScreen);
					blackScreen.scrollFactor.set();
					camHUD.visible = false;

					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						remove(blackScreen);
						FlxG.sound.play(Paths.sound('Lights_Turn_On'));
						camFollow.y = -2050;
						camFollow.x += 200;
						FlxG.camera.focusOn(camFollow.getPosition());
						FlxG.camera.zoom = 1.5;

						new FlxTimer().start(0.8, function(tmr:FlxTimer)
						{
							camHUD.visible = true;
							remove(blackScreen);
							FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 2.5, {
								ease: FlxEase.quadInOut,
								onComplete: function(twn:FlxTween)
								{
									schoolIntro(doof);
								} 
							});
						});
					});
				default:
					if(usesDialogue){
						startCutscene(doof);
					}
					else{
						startCountdown();
						}
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				default:
					startCountdown();
			}
		}

		super.create();
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();
		var senpaiEvil:FlxSprite = new FlxSprite();
		if (SONG.song.toLowerCase()=='senpai' || SONG.song.toLowerCase()=='roses' || SONG.song.toLowerCase()=='thorns')
		{
		senpaiEvil.frames = Paths.getSparrowAtlas('weeb/senpaiCrazy');
		senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
		senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();
		}

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('idle');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	function startCutscene(dialogueBox:DialogueBox){

		inCutscene = true;
		camHUD.visible = false;
		add(dialogueBox);

	}

	function endCutscene(dialogueBox:DialogueBox){

		trace("endCutscene");
		var black:FlxSprite = new FlxSprite(-256, -256).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set(0);
		inCutscene = true;
		black.alpha = 0;
		add(black);
		camHUD.visible = false;
		FlxTween.tween(black, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
		vocals.stop();
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			add(dialogueBox);
		});

	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	function startCountdown():Void
	{

		if (SONG.song.toLowerCase() == 'high')
		skyBG.velocity.y = 2;
		inCutscene = false;
		camHUD.visible = true;

		generateStaticArrows(0);
		generateStaticArrows(1);

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			if(boyfriend.curCharacter == 'bf-spooky' || boyfriend.curCharacter == 'bf-car' || boyfriend.curCharacter == 'bf-milf')
				boyfriend.dance();
			else
				boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ready', "set", "go"]);
			introAssets.set('school', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);
			introAssets.set('schoolEvil', ['weeb/pixelUI/ready-pixel', 'weeb/pixelUI/set-pixel', 'weeb/pixelUI/date-pixel']);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			for (value in introAssets.keys())
			{
				if (value == curStage)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
				}
			}

			if (curStage == 'date')
			altSuffix = '-date';

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school'))
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school'))
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school'))
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		if (!paused)
			FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		FlxG.sound.music.onComplete = endSong;
		vocals.play();

		iconBop(1.5);

		#if desktop
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % 4);

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else {}
			}
			daBeats += 1;
		}

		var beatStepTime = 600*(100/songData.bpm);

		if (FlxMath.roundDecimal(FlxG.sound.music.length / 1000, 2) == 92.09 && curSong == 'Blammed'){
			trace('NIGGA INSTALLED B SIDES LMAO HE DONE FOR');
			shootBeats = shootBeatsBSide;
		}
		if (curSong == 'Blammed' && dad.curCharacter == "pico"){
			
		
				for (x in 0...shootBeats.length)
					{

						var warnNoteTime = shootBeats[x];
						var warnNote:Note = new Note(warnNoteTime * beatStepTime, 1, null, false, true);
						warnNote.scrollFactor.set();
						unspawnNotes.push(warnNote);
						warnNote.mustPress = true;
						warnNote.x += FlxG.width / 2; // general offset
					}
			
		}
		else
		if (curSong == 'Milf' && dad.curCharacter == "mom-car-horny"){
		for (x in 0...shootBeatsMilf.length)
			{

				var warnNoteTime = shootBeatsMilf[x];
				var warnNote:Note = new Note(warnNoteTime * beatStepTime, 2, null, false, true);
			//	trace('Notes created');
				warnNote.scrollFactor.set();
				unspawnNotes.push(warnNote);
				warnNote.mustPress = true;
				warnNote.x += FlxG.width / 2; // general offset
			}
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(50, strumLine.y);

			switch (curStage)
			{
				case 'school' | 'schoolEvil':
					babyArrow.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
					babyArrow.animation.add('green', [6]);
					babyArrow.animation.add('red', [7]);
					babyArrow.animation.add('blue', [5]);
					babyArrow.animation.add('purplel', [4]);

					babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
					babyArrow.updateHitbox();
					babyArrow.antialiasing = false;

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.add('static', [0]);
							babyArrow.animation.add('pressed', [4, 8], 12, false);
							babyArrow.animation.add('confirm', [12, 16], 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.add('static', [1]);
							babyArrow.animation.add('pressed', [5, 9], 12, false);
							babyArrow.animation.add('confirm', [13, 17], 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.add('static', [2]);
							babyArrow.animation.add('pressed', [6, 10], 12, false);
							babyArrow.animation.add('confirm', [14, 18], 12, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.add('static', [3]);
							babyArrow.animation.add('pressed', [7, 11], 12, false);
							babyArrow.animation.add('confirm', [15, 19], 24, false);
					}

				default:
					babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

					babyArrow.antialiasing = true;
					babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

					switch (Math.abs(i))
					{
						case 0:
							babyArrow.x += Note.swagWidth * 0;
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.x += Note.swagWidth * 1;
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.x += Note.swagWidth * 2;
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 3:
							babyArrow.x += Note.swagWidth * 3;
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
			}

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;

			#if desktop
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			}
			#end
		}

		super.closeSubState();
	}

	override public function onFocus():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			if (Conductor.songPosition > 0.0)
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			}
		}
		#end

		super.onFocus();
	}
	
	override public function onFocusLost():Void
	{
		#if desktop
		if (health > 0 && !paused)
		{
			DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
		}
		#end

		super.onFocusLost();
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	override public function update(elapsed:Float)
	{
		#if debug
		if (FlxG.keys.justPressed.END)
		trace(gf.getPosition());
		#end
		keyCheck();
		if (SONG.song.toLowerCase() == 'winter-horrorland' && FlxG.sound.music.playing && !inCutscene)
			health -= 0.0007 * (elapsed / (1/60));

		#if !debug
		perfectMode = false;
		#end

		if (curSong == 'High' || curSong == 'Milf'){
			hitbox.visible = false;
		hitbox.x = lamp.x + 60;
		hitbox.y = lamp.y + 320;
		}

		if (FlxG.keys.justPressed.SPACE && boyfriend.dodgetime == 0 && (SONG.song.toLowerCase() == 'milf' || SONG.song.toLowerCase() == 'high')){
			boyfriend.playAnim("dodge");
			boyfriend.dodgetime = FlxG.updateFramerate;
		}
		
		
		//COLLISION CHECK 
		if (curSong == 'Milf'|| curSong == 'High'){
			if (hitbox.overlapsPoint(boyfriend.getGraphicMidpoint()) && boyfriend.dodgetime < 12 && !gameEnd){
				persistentUpdate = false;
				persistentDraw = false;
				paused = true;
				GameOverSubstate.gofuckingdecked = true;
				vocals.stop();
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.sound("thud", "week4"));
				openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			}
		}
		if ((SONG.song.toLowerCase() == 'milf' || SONG.song.toLowerCase() == 'high') && !gameEnd){
				if (lamp.x < -2400){
					ayoLookOut.visible = false;
				}
				if (lamp.x > -2400){
					ayoLookOut.visible = true;
					if(lamp.x < -2000 && !Config.disableDodgeSound)
					FlxG.sound.play(Paths.sound("warning", "week4"),0.65);
				}
				
				if (lamp.x > 80){
					ayoLookOut.visible = false;
				}
		}
		
		
		
		
		#if debug
		if (FlxG.keys.justPressed.FOUR)
			dad.playAnim('shootThatMF');
		if (FlxG.keys.justPressed.FIVE)
			killDancers();
		
		#end

		isStressed = "";

		if (healthBar.percent <= 40 && boyfriend.curCharacter != 'bf-christmas' && boyfriend.curCharacter != 'bf-christmas-depressed' && boyfriend.curCharacter != 'bf-date'){

			isStressed = "-stressed";

		}

		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}
		
		if(gameEnd && poleTimer != null)poleTimer.active = false;

		super.update(elapsed);

		switch(Config.accuracy){
			case "none":
				scoreTxt.text = "Score:" + songScore;
			default:
				scoreTxt.text = "Score:" + songScore + " | Misses:" + misses + " | Accuracy:" + truncateFloat(accuracy, 2) + "%";
		}

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				// gitaroo man easter egg
				FlxG.switchState(new GitarooPause());
			}
			else{
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
				if (timerStop)
				poleTimer.active = false;
				
			}
		
			
			
			
			
			
			
			#if desktop
			DiscordClient.changePresence(detailsPausedText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			#end
		}

		
		/*
		 
			if(FlxG.keys.justPressed.SIX){
				var sexScene:FlxVideo = new FlxVideo(Paths.video("sexScene"));
				add(sexScene);
				sexScene.play();
			
			}
		
		
		
		
		
		
		*/
		
		
		
		if (FlxG.keys.justPressed.SEVEN)
		{
			FlxG.switchState(new ChartingState());

			#if desktop
			if (FlxG.random.bool(40))
			DiscordClient.changePresence("Shart Editor", null, null, true);
		
			else
			DiscordClient.changePresence("Chart Editor", null, null, true);	
			#end
		}

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);
	
		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;
	
		if (Config.betterIcons){
			if (healthBar.percent < 20)
			{
				iconP1.animation.curAnim.curFrame = 1;
				iconP2.animation.curAnim.curFrame = 2;
			}
			else if (healthBar.percent > 80)
			{
				iconP1.animation.curAnim.curFrame = 2;
				iconP2.animation.curAnim.curFrame = 1;
			}
			else
			{
				iconP1.animation.curAnim.curFrame = 0;
				iconP2.animation.curAnim.curFrame = 0;			
			}
		}	
		else{
			
			if (healthBar.percent < 20)
				iconP1.animation.curAnim.curFrame = 1;
			else
				iconP1.animation.curAnim.curFrame = 0;

			if (healthBar.percent > 80)
				iconP2.animation.curAnim.curFrame = 1;
			else
				iconP2.animation.curAnim.curFrame = 0;
		}
		
		if (healthBar.percent < 40)
			fuckCval = true;
			else
			fuckCval = false;

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		
		if (FlxG.keys.justPressed.EIGHT){
            if(FlxG.keys.pressed.SHIFT){
                FlxG.switchState(new AnimationDebug(SONG.player1));
            }
            else if(FlxG.keys.pressed.CONTROL){
                FlxG.switchState(new AnimationDebug(gf.curCharacter));
            }
            else{
                FlxG.switchState(new AnimationDebug(SONG.player2));
            }
        }

		//PAUSING THE TIMER HERE 
		
	
	

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}
			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			if (curBeat % 4 == 0)
			{
				// trace(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			}

			if (!PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camDoTheThing)
			{
				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (dad.curCharacter)
				{
					case 'dad':
						camFollow.y = dad.getMidpoint().y - 250;
						camFollow.x = dad.getMidpoint().x + 300;
					case 'pico':
						camFollow.x = dad.getMidpoint().x + 230;
					case 'SHAKEYDAD':
						camFollow.y = dad.getMidpoint().y - 250;
						camFollow.x = dad.getMidpoint().x + 300;
					case 'mom':
						camFollow.x = dad.getMidpoint().x + 200;
					case 'mom-car-horny':
						camFollow.x -= 400;
						camFollow.y -= 100;
					case 'senpai':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'senpai-angry':
						camFollow.y = dad.getMidpoint().y - 430;
						camFollow.x = dad.getMidpoint().x - 100;
				}

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					tweenCamIn();
				}
			}

		//	if (curSong == 'Bopeebo')
		//		freshCrowd.visible = false;
		//	if (curSong == 'Dadbattle')
		//		freshCrowd.visible = false;
		//	if (curSong == 'Tutorial')
		//		freshCrowd.visible = false;
		


			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camDoTheThing)
			{
				camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'date':
						camFollow.x = boyfriend.getMidpoint().x - 580;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'schoolEvil':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
				}

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
				}
			}
			/*
			var oldP:FlxPoint = new FlxPoint(dad.x, dad.y);
			var newP:FlxPoint = new FlxPoint(dad.x + 20, dad.y - 20);
			FlxTween.tween(sans, {x: newP.x, y: newP.y}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.quadOut,onComplete:function(){
				FlxTween.tween(sans, {x: oldP.x, y: oldP.y}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.quadIn});
			});*/
			
		}
		
		
		
		
		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}

		// RESET = Quick Game Over Screen
		if (controls.RESET && !inCutscene)
		{
			health = 0;
			trace("RESET = True");
		}

		// CHEAT = brandon's a pussy
		if (controls.CHEAT)
		{
			health += 1;
			trace("User is cheating!");
		}

		if (health <= 0)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
			
			#if desktop
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence("Game Over - " + detailsText, SONG.song + " (" + storyDifficultyText + ")", iconRPC);
			#end
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
		{
			notes.forEachAlive(function(daNote:Note)
			{
				if(Config.downscroll){
					daNote.y = (strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * (daNote.warning?1.25:1) * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
				}
				else {
					daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * (daNote.warning?1.25:1) * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
				}

				// i am so fucking sorry for this if condition
			

				if (!daNote.mustPress && daNote.wasGoodHit)
				{
					if (SONG.song != 'Tutorial')
						camZooming = true;

					var altAnim:String = "";

					if (SONG.notes[Math.floor(curStep / 16)] != null)
					{
						if (SONG.notes[Math.floor(curStep / 16)].altAnim)
							altAnim = '-alt';
					}

					if(!dad.animation.curAnim.name.startsWith("shoot")){
					switch (Math.abs(daNote.noteData))
					{
						case 0:
							dad.playAnim('singLEFT' + altAnim, true);
						case 1:
							dad.playAnim('singDOWN' + altAnim, true);
						case 2:
							dad.playAnim('singUP' + altAnim, true);
						case 3:
							dad.playAnim('singRIGHT' + altAnim, true);
					}
					}

					dad.holdTimer = 0;

					if (SONG.needsVoices)
						vocals.volume = 1;

					daNote.kill();
					notes.remove(daNote, true);
					daNote.destroy();
				}

				//MOVE NOTE TRANSPARENCY CODE BECAUSE REASONS 
				if(daNote.tooLate){

								var dangerShit = 1;
					if (daNote.alpha > 0.3){

						if(Config.newInput){
							if(!daNote.warning){
								if(!gameEnd)noteMiss(daNote.noteData, 0.055, false, true);
							}else{
								if (SONG.song.toLowerCase() == "milf"){
									GameOverSubstate.gotfuckinblown = true;
									dangerShit = 999;
								}
								if(!gameEnd)noteMiss(daNote.noteData, dangerShit, false, true);
							}
							vocals.volume = 0;
						}

						daNote.alpha = 0.3;
		
					}

				}

				//Guitar Hero Type Held Notes
				if(Config.newInput && daNote.isSustainNote && daNote.mustPress){

					if(daNote.prevNote.tooLate){
						daNote.tooLate = true;
						daNote.destroy();
					}
	
					if(daNote.prevNote.wasGoodHit){
						
						var upP = controls.UP;
						var rightP = controls.RIGHT;
						var downP = controls.DOWN;
						var leftP = controls.LEFT;
	
						switch(daNote.noteData){
							case 0:
								if(!leftP){
									noteMiss(0, 0.03, true, true);
									vocals.volume = 0;
									daNote.tooLate = true;
									daNote.destroy();
								}
							case 1:
								if(!downP){
									noteMiss(1, 0.03, true, true);
									vocals.volume = 0;
									daNote.tooLate = true;
									daNote.destroy();
								}
							case 2:
								if(!upP){
									noteMiss(2, 0.03, true, true);
									vocals.volume = 0;
									daNote.tooLate = true;
									daNote.destroy();
								}
							case 3:
								if(!rightP){
									noteMiss(3, 0.03, true, true);
									vocals.volume = 0;
									daNote.tooLate = true;
									daNote.destroy();
								}
						}
					}
				}

				// WIP interpolation shit? Need to fix the pause issue
				// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));

				if (Config.downscroll ? (daNote.y > strumLine.y + daNote.height + 50) : (daNote.y < strumLine.y - daNote.height - 50))
				{
					if(Config.newInput){
	
						if (daNote.tooLate){
									
							daNote.active = false;
							daNote.visible = false;
				
							daNote.destroy();
			
						}

					}
					else{
	
						if (daNote.tooLate || !daNote.wasGoodHit){
								
							if(daNote.warning && (SONG.song.toLowerCase() == 'blammed' ||SONG.song.toLowerCase() == 'milf')) 
								health -= 1 * Config.healthDrainMultiplier;
							else
								health -= 0.0475 * Config.healthDrainMultiplier;
							misses += 1;
							updateAccuracy();
							vocals.volume = 0;
						}
			
						daNote.active = false;
						daNote.visible = false;
			
						daNote.destroy();
	
					}
						
				}
			});
		}

		if (!inCutscene)
			keyShit();

		#if debug
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	function endSong():Void
	{
		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		if (SONG.validScore)
		{
			#if !switch
			Highscore.saveScore(SONG.song, songScore, storyDifficulty);
			#end
		}

		gameEnd = true;
		
		
		//please work
		//

		if (isStoryMode)
		{

			campaignScore += songScore;

			storyPlaylist.remove(storyPlaylist[0]);

			if (storyPlaylist.length <= 0)
			{
				
				transIn = FlxTransitionableState.defaultTransIn;
				transOut = FlxTransitionableState.defaultTransOut;

				fReturn = "story";

				// if ()
				StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;

				if (SONG.validScore)
				{
					NGio.unlockMedal(60961);
					Highscore.saveWeekScore(storyWeek, campaignScore, storyDifficulty);
				}

				FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
				FlxG.save.flush();
			}
			else
			{
				var difficulty:String = "";

				if (storyDifficulty == 0)
					difficulty = '-easy';

				if (storyDifficulty == 2)
					difficulty = '-hard';

				trace('LOADING NEXT SONG');
				trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);

				if (SONG.song.toLowerCase() == 'eggnog')
				{
					var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
						-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
					blackShit.scrollFactor.set();
					add(blackShit);
					camHUD.visible = false;

					FlxG.sound.play(Paths.sound('Lights_Shut_off'));
				}

				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				prevCamFollow = camFollow;

				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
				FlxG.sound.music.stop();

				fReturn = "play";
				
			}

			if (Config.disableCutscenes == 'everywhere' || Config.disableCutscenes == 'story'){
				if(usesEndDialogue){
					endCutscene(doof2);
				}
				else{endReturn();}
			}
			else{endReturn();}
			

		}
		else
		{
			fReturn = "free";
			if (Config.disableCutscenes == 'everywhere'){
				if(usesEndDialogue){
					endCutscene(doof2);
				}
				else{endReturn();}
			}
			else{endReturn();}
		}
	}

	var endingSong:Bool = false;

	private function popUpScore(strumtime:Float):Void
	{
		var noteDiff:Float = Math.abs(strumtime - Conductor.songPosition);
		// boyfriend.playAnim('hey');
		vocals.volume = 1;

		var placement:String = Std.string(combo);

		var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
		coolText.screenCenter();
		coolText.x = FlxG.width * 0.55;
		//

		var rating:FlxSprite = new FlxSprite();
		var score:Int = 350;

		var daRating:String = "sick";

		if (noteDiff > Conductor.safeZoneOffset * Conductor.shitZone)
			{
				daRating = 'shit';
				if(Config.accuracy == "complex") {
					totalNotesHit += 1 - Conductor.shitZone;
				}
				else {
					totalNotesHit += 1;
				}
				score = 50;
			}
		else if (noteDiff > Conductor.safeZoneOffset * Conductor.badZone)
			{
				daRating = 'bad';
				score = 100;
				if(Config.accuracy == "complex") {
					totalNotesHit += 1 - Conductor.badZone;
				}
				else {
					totalNotesHit += 1;
				}
			}
		else if (noteDiff > Conductor.safeZoneOffset * Conductor.goodZone)
			{
				daRating = 'good';
				if(Config.accuracy == "complex") {
					totalNotesHit += 1 - Conductor.goodZone;
				}
				else {
					totalNotesHit += 1;
				}
				score = 200;
			}
		if (daRating == 'sick')
			totalNotesHit += 1;
	
		//trace('hit ' + daRating);

		songScore += score;

		/* if (combo > 60)
				daRating = 'sick';
			else if (combo > 12)
				daRating = 'good'
			else if (combo > 4)
				daRating = 'bad';
		 */

		var pixelShitPart1:String = "";
		var pixelShitPart2:String = '';

		if (curStage.startsWith('school'))
		{
			pixelShitPart1 = 'weeb/pixelUI/';
			pixelShitPart2 = '-pixel';
		}

		rating.loadGraphic(Paths.image(pixelShitPart1 + daRating + pixelShitPart2));
		rating.screenCenter();
		rating.x = coolText.x - 40;
		rating.y -= 60;
		rating.acceleration.y = 550;
		rating.velocity.y -= FlxG.random.int(140, 175);
		rating.velocity.x -= FlxG.random.int(0, 10);

		var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'combo' + pixelShitPart2));
		comboSpr.screenCenter();
		comboSpr.x = coolText.x;
		comboSpr.acceleration.y = 600;
		comboSpr.velocity.y -= 150;

		comboSpr.velocity.x += FlxG.random.int(1, 10);
		add(rating);

		if (!curStage.startsWith('school'))
		{
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			rating.antialiasing = true;
			comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
			comboSpr.antialiasing = true;
		}
		else
		{
			rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
			comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
		}

		comboSpr.updateHitbox();
		rating.updateHitbox();

		var seperatedScore:Array<Int> = [];

		seperatedScore.push(Math.floor(combo / 100));
		seperatedScore.push(Math.floor((combo - (seperatedScore[0] * 100)) / 10));
		seperatedScore.push(combo % 10);

		var daLoop:Int = 0;
		for (i in seperatedScore)
		{
			var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(pixelShitPart1 + 'num' + Std.int(i) + pixelShitPart2));
			numScore.screenCenter();
			numScore.x = coolText.x + (43 * daLoop) - 90;
			numScore.y += 80;

			if (!curStage.startsWith('school'))
			{
				numScore.antialiasing = true;
				numScore.setGraphicSize(Std.int(numScore.width * 0.5));
			}
			else
			{
				numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
			}
			numScore.updateHitbox();

			numScore.acceleration.y = FlxG.random.int(200, 300);
			numScore.velocity.y -= FlxG.random.int(140, 160);
			numScore.velocity.x = FlxG.random.float(-5, 5);

			if (combo >= 10 || combo == 0)
				add(numScore);

			FlxTween.tween(numScore, {alpha: 0}, 0.2, {
				onComplete: function(tween:FlxTween)
				{
					numScore.destroy();
				},
				startDelay: Conductor.crochet * 0.002
			});

			daLoop++;
		}
		/* 
			trace(combo);
			trace(seperatedScore);
		 */

		coolText.text = Std.string(seperatedScore);
		// add(coolText);

		FlxTween.tween(rating, {alpha: 0}, 0.2, {
			startDelay: Conductor.crochet * 0.001
		});

		FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
			onComplete: function(tween:FlxTween)
			{
				coolText.destroy();
				comboSpr.destroy();

				rating.destroy();
			},
			startDelay: Conductor.crochet * 0.001
		});

		curSection += 1;
	}

	private function keyCheck():Void{

		upTime = controls.UP ? upTime + 1 : 0;
		downTime = controls.DOWN ? downTime + 1 : 0;
		leftTime = controls.LEFT ? leftTime + 1 : 0;
		rightTime = controls.RIGHT ? rightTime + 1 : 0;

		upPress = upTime == 1;
		downPress = downTime == 1;
		leftPress = leftTime == 1;
		rightPress = rightTime == 1;

		upRelease = upHold && upTime == 0;
		downRelease = downHold && downTime == 0;
		leftRelease = leftHold && leftTime == 0;
		rightRelease = rightHold && rightTime == 0;

		upHold = upTime > 0;
		downHold = downTime > 0;
		leftHold = leftTime > 0;
		rightHold = rightTime > 0;

		/*THE FUNNY 4AM CODE!
		trace((leftHold?(leftPress?"^":"|"):(leftRelease?"^":" "))+(downHold?(downPress?"^":"|"):(downRelease?"^":" "))+(upHold?(upPress?"^":"|"):(upRelease?"^":" "))+(rightHold?(rightPress?"^":"|"):(rightRelease?"^":" ")));
		I should probably remove this from the code because it literally serves no purpose, but I'm gonna keep it in because I think it's funny.
		It just sorta prints 4 lines in the console that look like the arrows being pressed. Looks something like this:
		====
		^  | 
		| ^|
		| |^
		^ |
		====*/

	}


	private function keyShit():Void
		{
			var controlArray:Array<Bool> = [leftPress, downPress, upPress, rightPress];
	
			if ((upPress || rightPress || downPress || leftPress) && !boyfriend.stunned && generatedMusic)
			{
				boyfriend.holdTimer = 0;
	
				var possibleNotes:Array<Note> = [];
	
				var ignoreList:Array<Int> = [];
	
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
					{
						// the sorting probably doesn't need to be in here? who cares lol
						possibleNotes.push(daNote);
						possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
	
						ignoreList.push(daNote.noteData);
	
						if(Config.noRandomTap && !daNote.isSustainNote)
							setCanMiss();
					}
	
				});
	
				if (possibleNotes.length > 0)
				{
					var daNote = possibleNotes[0];
	
					// Jump notes
					if (possibleNotes.length >= 2)
					{
						if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
						{
							for (coolNote in possibleNotes)
							{
								if (controlArray[coolNote.noteData])
									goodNoteHit(coolNote);
								else
								{
									var inIgnoreList:Bool = false;
									for (shit in 0...ignoreList.length)
									{
										if (controlArray[ignoreList[shit]])
											inIgnoreList = true;
									}
									if (!inIgnoreList)
										badNoteCheck();
								}
							}
						}
						else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
						{
							noteCheck(controlArray[daNote.noteData], daNote);
						}
						else
						{
							for (coolNote in possibleNotes)
							{
								noteCheck(controlArray[coolNote.noteData], coolNote);
							}
						}
					}
					else // regular notes?
					{
						noteCheck(controlArray[daNote.noteData], daNote);
					}
					/* 
						if (controlArray[daNote.noteData])
							goodNoteHit(daNote);
					 */
					// trace(daNote.noteData);
					/* 
						switch (daNote.noteData)
						{
							case 2: // NOTES YOU JUST PRESSED
								if (upP || rightP || downP || leftP)
									noteCheck(upP, daNote);
							case 3:
								if (upP || rightP || downP || leftP)
									noteCheck(rightP, daNote);
							case 1:
								if (upP || rightP || downP || leftP)
									noteCheck(downP, daNote);
							case 0:
								if (upP || rightP || downP || leftP)
									noteCheck(leftP, daNote);
						}
					 */
					if (daNote.wasGoodHit)
					{
						daNote.destroy();
					}
				}
				else
				{
					badNoteCheck();
				}
			}
	
			if ((upHold || rightHold || downHold || leftHold) && !boyfriend.stunned && generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
					{
						switch (daNote.noteData)
						{
							// NOTES YOU ARE HOLDING
							case 2:
								if (upHold)
									goodNoteHit(daNote);
							case 3:
								if (rightHold)
									goodNoteHit(daNote);
							case 1:
								if (downHold)
									goodNoteHit(daNote);
							case 0:
								if (leftHold)
									goodNoteHit(daNote);
						}
					}
				});
			}
	
			if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !upHold && !downHold && !rightHold && !leftHold)
			{
				if (boyfriend.animation.curAnim.name.startsWith('sing'))
					boyfriend.dance();
			}
	
			playerStrums.forEach(function(spr:FlxSprite)
			{
				switch (spr.ID)
				{
					case 2:
						if (upPress && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (!upHold)
							spr.animation.play('static');
					case 3:
						if (rightPress && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (!rightHold)
							spr.animation.play('static');
					case 1:
						if (downPress && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (!downHold)
							spr.animation.play('static');
					case 0:
						if (leftPress && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (!leftHold)
							spr.animation.play('static');
				}
	
				switch(spr.animation.curAnim.name){
	
					case "confirm":
	
						//spr.alpha = 1;
						spr.centerOffsets();
	
						if(!curStage.startsWith('school')){
							spr.offset.x -= 14;
							spr.offset.y -= 14;
						}
	
					/*case "static":
						spr.alpha = 0.5; //Might mess around with strum transparency in the future or something.
						spr.centerOffsets();*/
	
					default:
						//spr.alpha = 1;
						spr.centerOffsets();
	
				}
	
			});
		}

	function noteMiss(direction:Int = 1, ?healthLoss:Float = 0.04, ?playAudio:Bool = true, ?skipInvCheck:Bool = false):Void
		{
			if (!boyfriend.stunned && !startingSong && (!boyfriend.invuln || skipInvCheck) )
			{
				health -= healthLoss * Config.healthDrainMultiplier;
				if (combo > 5 && gfAnimate)
				{
					gf.playAnim('sad');
				}
				if (combo > 5 && dad.curCharacter == 'gf-date' && gfAnimate)
				{
					dad.playAnim('sad');
				}
				misses += 1;
				combo = 0;
	
				songScore -= 100;
				
				if(playAudio){
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
				}
				// FlxG.sound.play('assets/sounds/missnote1' + TitleState.soundExt, 1, false);
				// FlxG.log.add('played imss note');
	
				switch(Config.newInput){
					case true:
						setBoyfriendInvuln(0.08);
					case false:
						setBoyfriendStunned();
				}
	
				switch (direction)
				{
					case 2:
						boyfriend.playAnim('singUPmiss', true);
					case 3:
						boyfriend.playAnim('singRIGHTmiss', true);
					case 1:
						boyfriend.playAnim('singDOWNmiss', true);
					case 0:
						boyfriend.playAnim('singLEFTmiss', true);
				}
	
				updateAccuracy();
			}
		}
	
		function noteMissWrongPress(direction:Int = 1, ?healthLoss:Float = 0.0475):Void
			{
				if (!startingSong && !boyfriend.invuln)
				{
					health -= healthLoss * Config.healthDrainMultiplier;
					if (combo > 5 && gfAnimate)
					{
						gf.playAnim('sad');
					}
					combo = 0;
		
					songScore -= 25;
					
					FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
					
					// FlxG.sound.play('assets/sounds/missnote1' + TitleState.soundExt, 1, false);
					// FlxG.log.add('played imss note');
		
					setBoyfriendInvuln(0.04);
		
					switch (direction)
					{
						case 2:
							boyfriend.playAnim('singUPmiss', true);
						case 3:
							boyfriend.playAnim('singRIGHTmiss', true);
						case 1:
							boyfriend.playAnim('singDOWNmiss', true);
						case 0:
							boyfriend.playAnim('singLEFTmiss', true);
					}
				}
			}
	
		function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if(Config.noRandomTap && !canHit){}
			else{
	
				switch(Config.newInput){
					case true:
						if (leftP)
							noteMissWrongPress(0);
						if (upP)
							noteMissWrongPress(2);
						if (rightP)
							noteMissWrongPress(3);
						if (downP)
							noteMissWrongPress(1);
		
					case false:
						if (leftP)
							noteMiss(0);
						if (upP)
							noteMiss(2);
						if (rightP)
							noteMiss(3);
						if (downP)
							noteMiss(1);
	
				}
			}
		}
	
		function noteCheck(keyP:Bool, note:Note):Void
		{
			if (keyP)
				{
				goodNoteHit(note);
				}
			else
			{
				badNoteCheck();
			}
		}
	
		function setBoyfriendInvuln(time:Float = 5 / 60){
	
			invulnCount++;
			var invulnCheck = invulnCount;
	
			boyfriend.invuln = true;
	
			new FlxTimer().start(time, function(tmr:FlxTimer)
			{
				if(invulnCount == invulnCheck){
	
				
					boyfriend.invuln = false;
	
				}
				else{
					//trace("skipping invuln");
				}
				
			});
	
		}
	
		function setCanMiss(time:Float = 0.185){
	
			noMissCount++;
			var noMissCheck = noMissCount;
	
			canHit = true;
	
			new FlxTimer().start(time, function(tmr:FlxTimer)
			{
				if(noMissCheck == noMissCount){
	
					//trace("can hit off");
					canHit = false;
	
				}
				else{
					//trace("skipping can hit toggle");
				}
				
			});
	
		}
	
		function setBoyfriendStunned(time:Float = 5 / 60){
	
			boyfriend.stunned = true;
	
			new FlxTimer().start(time, function(tmr:FlxTimer)
			{
				boyfriend.stunned = false;
			});
	
		}
	
		function goodNoteHit(note:Note):Void
		{
	
			//Guitar Hero Styled Hold Notes
			if(Config.newInput && note.isSustainNote && !note.prevNote.wasGoodHit){
				noteMiss(note.noteData, 0.05, true, true);
				note.prevNote.tooLate = true;
				note.prevNote.destroy();
				vocals.volume = 0;
			}
	
			else if (!note.wasGoodHit)
			{
				if (!note.isSustainNote)
				{
					popUpScore(note.strumTime);
					combo += 1;
				}
				else
					totalNotesHit += 1;
	
				if (note.noteData >= 0){
					switch(Config.newInput){
						case true:
							health += 0.015 * Config.healthMultiplier;
						case false:
							health += 0.023 * Config.healthMultiplier;
					}
				}
				else{
					switch(Config.newInput){
						case true:
							health += 0.0015 * Config.healthMultiplier;
						case false:
							health += 0.004 * Config.healthMultiplier;
					}
				}
					
	
				switch (note.noteData)
				{
					case 2:
						boyfriend.playAnim('singUP' + isStressed, true);
						
						if (note.warning){
							boyfriend.playAnim('dodge',true);
							boyfriend.dodgetime = FlxG.updateFramerate/2;
						}
						
					case 3:
						boyfriend.playAnim('singRIGHT' + isStressed, true);
					case 1:
						boyfriend.playAnim('singDOWN' + isStressed, true);
					case 0:
						boyfriend.playAnim('singLEFT' + isStressed, true);
				}
	
				if(Config.newInput && !note.isSustainNote){
					setBoyfriendInvuln(0.02);
				}
				
	
				playerStrums.forEach(function(spr:FlxSprite)
				{
					if (Math.abs(note.noteData) == spr.ID)
					{
						spr.animation.play('confirm', true);
					}
				});
	
				note.wasGoodHit = true;
				vocals.volume = 1;
	
				note.destroy();
				
				updateAccuracy();
			}
		}

	var fastCarCanDrive:Bool = true;
	var billboardShit:Bool = true;
	var lightpolecanDoShit:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}

	
	function startBillBoard(){
		var dumbass:Int = FlxG.random.int(0,7);
		billboard.animation.play('' +dumbass);
		billboard.velocity.x = 10 * SONG.bpm;
		trace('BILLBOARD' + billboard.animation.curAnim.name);
		billboardShit = false;
		new FlxTimer().start(6, function(tmr:FlxTimer){
			resetBillBoard();
		});
	}


	
	function startPole(){
		pole.velocity.x = 20*SONG.bpm;
		lamp.velocity.x = 20*SONG.bpm;
		hitbox.velocity.x = 20*SONG.bpm;
		timerStop = true;
		lightpolecanDoShit = false;
		
		poleTimer = new FlxTimer().start(3, function(tmr:FlxTimer){
			resetPole();
		});
		
	
	}

	function resetBillBoard()
	{
	billboard.x = -2000;
	billboard.velocity.x = 0;
	billboardShit = true;
	}

	function resetPole()
		{
		//most random ass values i've seen
		pole.x = -2440;
		lamp.x = -2560;
	
		pole.velocity.x = 0;
		lamp.velocity.x = 0;
		lightpolecanDoShit = true;
		trace("Resetting lamp");
		
		
		}

		
	
			
		
		
			

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 400;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}

	function lightningStrikeShit():Void
	{
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		halloweenBG.animation.play('lightning');

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		if(curSong.toLowerCase() != "south")
			boyfriend.playAnim('scared', true);
		gf.playAnim('scared', true);
	}

	function updateAccuracy()
	{

		totalPlayed += 1;
		accuracy = totalNotesHit / totalPlayed * 100;
		//trace(totalNotesHit + '/' + totalPlayed + '* 100 = ' + accuracy);
		if (accuracy >= 100.00)
		{
				accuracy = 100;
		}
		
	}

	function truncateFloat( number : Float, precision : Int): Float 
	{
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
	}

	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}
		
		if(curSong == "Milf"){
			if (curStep == (lampMilf*4)-2){
				dodgelamp.x = -900;
				dodgepole.x = -800;
				dodgelamp.velocity.x = 4800;
				dodgepole.velocity.x = 4800;
			}
			if (curStep == (lampMilf*4) && !gameEnd){
				killDancers();
			}
		}
		
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	override function beatHit()
	{
		super.beatHit();



		if (curStage == 'limo' && curBeat % 2 == 1)
		limo.animation.play('drive', true);
		
		pubCurBeat = curBeat;

		
		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}
		
	if (curSong.toLowerCase() == 'fresh' || curSong.toLowerCase() == 'dadbattle' )
		freshCrowd.animation.play('crowdBopFresh', true);

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (dad.curCharacter != 'gf-date'){
				if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
					dad.dance();
			}
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

	
		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		//seriously why do they bop on every beat it kinda looks ass nm
		//smokey you're dumb
		//fuck you too bird man

		if (curBeat % 1 == 0){
			iconBop();
		}

		if (curStage == 'date')
			dad.dance();
			
		if (curBeat % gfSpeed == 0 && gfAnimate)
		{
			if(gf.dodgetime == 0)gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing") && boyfriend.dodgetime == 0)
		{
			boyfriend.dance();
		}

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);

			if (SONG.song == 'Bopeebo' && gfAnimate)
			{
				gf.playAnim('cheer', true);
			}
		}

		if (curSong == 'Blammed' && dad.curCharacter == "pico" && !inCutscene && !gameEnd)
		{
			if(shootBeats.contains(curBeat)){
				FlxG.sound.play(Paths.sound("shooters", "week3"), 1);
				dad.playAnim("shoot", true);
				FlxG.camera.shake(0.01, 0.15);
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{
					dad.playAnim("idle", true);
				});
			}
		}
		if (curSong == 'Milf' && dad.curCharacter == "mom-car-horny" && !inCutscene && !gameEnd)
		{
			
			if (shootBeatsMilf.contains(curBeat) && !gameEnd){
				FlxG.sound.play(Paths.sound("laser", "week4"), 1);
				dad.playAnim("shootThatMF", true);
				var camx = camFollow.x;
				FlxTween.tween(camFollow, {x: camx+100}, 0.3, {ease:FlxEase.sineOut,type:FlxTweenType.BACKWARD});
				FlxG.camera.shake(0.01, 0.15);
				FlxG.camera.scroll.x += 30;
				new FlxTimer().start(0.3, function(tmr:FlxTimer)
				{
					dad.playAnim("idle", true);
				});
			}
		}

		if(curSong == "Winter-Horrorland"){

			if(curBeat == 192){
				camDoTheThing = false;
			}
			
			if(curBeat == 194){
				camFollow.x =  gf.getMidpoint().x;
				camFollow.y =  gf.getMidpoint().y;
			}

			if(curBeat == 195){
				new FlxTimer().start(0.2, function(tmr:FlxTimer)
				{
					gfAnimate = false;
					gf.playAnim("fall", true);
					FlxG.sound.play(Paths.sound("fellOver"), 1);
					new FlxTimer().start(0.165, function(tmr:FlxTimer)
					{
						FlxG.camera.shake(0.02, 0.1);
					});	
				});	
			}

			if(curBeat == 197){
				camDoTheThing = true;
			}

		}

		switch (curStage)
		{
			case 'school':
				bgGirls.dance();
			
			
		
			case 'mall':
				
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);
				if (curBeat % 4 == 0)
				bgEscalator.animation.play('' + FlxG.random.int(0,2), true);


			case 'limo':
				if(!dancers.dead)dancers.dance('alvin');

				
				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
				if (FlxG.random.bool(10) && billboardShit)
					startBillBoard();
		
				//if (FlxG.random.bool(10) && lightpolecanDoShit)
					//startPole();

				switch (SONG.song.toLowerCase()){
				case 'high':
					switch (curBeat){
					case 10,20,42,74,106, 136:
					startPole();
					}
				case 'milf':
					switch (curBeat){
					case 8,40,48,72,78,83,104,112,138,145,168,176, 200, 212,265,275,299,308,330,340,364: 
					startPole();
					}       
				}  

			case "philly":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					phillyCityLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, phillyCityLights.length - 1);

					phillyCityLights.members[curLight].visible = true;
					// phillyCityLights.members[curLight].alpha = 1;
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
	}

	var curLight:Int = 0;

	function endReturn(){

		switch(fReturn){
			case "play":
				LoadingState.loadAndSwitchState(new PlayState());
			case "story":
			if (curSong.toLowerCase() == 'tutorial' && misses == 0 && FlxG.random.bool(20)){
			gfTiddies();
			}
			else{		
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.switchState(new StoryMenuState());
			}
			case "free":
			FlxG.switchState(new FreeplayState());
		}

	}

	function gfTiddies(){
	//tiddy code
	camHUD.visible = false;
	defaultCamZoom = 1;
	tiddies = new FlxSprite(0,0).loadGraphic(Paths.image('gf_tiddies'));
	tiddies.scrollFactor.set(0,0);
	add(tiddies);	
	FlxG.sound.play(Paths.sound('ignorethis'));
		new FlxTimer().start(1.8, function(tmr:FlxTimer)
		{
		trace("AYO FC'D TUTORIAL? DAMN");
		System.exit(0);
		});	
	}

	function iconBop(?_scale:Float = 1.25, ?_time:Float = 0.2):Void {
		iconP1.iconScale = iconP1.defualtIconScale * _scale;
		iconP2.iconScale = iconP2.defualtIconScale * _scale;

		FlxTween.tween(iconP1, {iconScale: iconP1.defualtIconScale}, _time, {ease: FlxEase.quintOut});
		FlxTween.tween(iconP2, {iconScale: iconP2.defualtIconScale}, _time, {ease: FlxEase.quintOut});
	}
	
	function killDancers(){
		FlxG.camera.shake(0.01, 0.2);
		var xxx = bgLimo.x;
		var xxxx = dancers.x;
		var yy = dancers.y;
		var camx = camFollow.x;
		dancers.dead = true;
		FlxG.sound.play(Paths.sound("dancerDie", "week4"), 0.9);
		dancers.animation.play("youseewhathemissin");
		dancers.offset.set(30,90);
		dancers.y -= 80;
		gf.playAnim("duck");
		gf.dodgetime = FlxG.updateFramerate;
		FlxTween.tween(camFollow, {x: camx+35}, 0.3, {ease:FlxEase.sineOut,type:FlxTweenType.BACKWARD});
		dancers.animation.finishCallback = removeDancers;
		
		
		new FlxTimer().start(1, function(e:FlxTimer){
			FlxTween.tween(bgLimo, {x: 1800},2,{ease:FlxEase.sineIn/*,onComplete:function(tween:FlxTween){
				
				dancers.y = yy;
				dancers.x = xxx + (xxx - xxx) + 1300;
				dancers.dead = false;
				dancers.animation.play("danceLeft");
				
				FlxTween.tween(dancers, {x: xxxx}, 1, {ease:FlxEase.sineOut});
				
				FlxTween.tween(bgLimo, {x: xxx},1,{ease:FlxEase.sineOut});
				
			}*/});
		});
		
		
	}


	function removeDancers(anim:String){
	if (anim == 'youseewhathemissin'){
		dancers.destroy();

	//tween sux
	//nvm tween cool velocity sux
	bgLimo.velocity.x = 800;
		trace('Removing the dancers');
		}
	}
}
