package;

import flixel.util.FlxDestroyUtil;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import animateatlas.AtlasFrameMaker;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	public var dodgetime:Float = 0;

	public var trueX:Float;
	public var trueY:Float;
	var connectedParent:FlxSprite;
	var connectedOffsets:Array<Array<Float>>;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{

			case 'gf-eggman':
				frames = AtlasFrameMaker.construct('EGGMAN');
				animation.addByIndices('danceLeft', 'Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				playAnim('danceRight');
				setGraphicSize(Std.int(width * 0.8));
				updateHitbox();

				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

			case 'gf':
				// GIRLFRIEND CODE
				frames = AtlasFrameMaker.construct('FULL_GF',
				['GF Dance Beat','Sad','Cheer','Left','Down','Up','Right','Fear']
				);
				//frames = tex;
				animation.addByPrefix('cheer', 'Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByIndices('sad', 'Sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dance Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dance Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'Fear', 24);

				addOffset('cheer', 2, -28);
				addOffset('sad', -8, -16);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				addOffset("singUP", 2, -28);
				addOffset("singRIGHT", 2, -20);
				addOffset("singLEFT", 3, -14);
				addOffset("singDOWN", 3, -44);
				addOffset('hairBlow', 35, -31);
				addOffset('hairFall', -9, -12);

				addOffset('scared', 1, -22);

				playAnim('danceRight');

			case 'gf-date':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/gfDate', 'shared');
				frames = tex;

				setGraphicSize(Std.int(width * 1.1));
				updateHitbox();

				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByPrefix('sad', 'GF Laugh', 24, false);

				addOffset('sad', -47, -23);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				playAnim('danceRight');

			case 'gfpico':
				// GIRLFRIEND CODE
				//tex = AtlasFrameMaker.construct('assets/images/TextureAtlas/PICO_GF')
				frames = AtlasFrameMaker.construct('FULL_GF',
				['GF Dance Beat 2','Sad 2','GF Dancing Beat Hair Blowing 2','GF Dancing Beat Hair Landing 2']);
				animation.addByPrefix('sad', 'Sad 2', 24, false);
				animation.addByIndices('danceLeft', 'GF Dance Beat 2', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dance Beat 2', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair Blowing 2", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing 2", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('sad', 2, -24);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				addOffset('hairBlow', -9, -59);
				addOffset('hairFall', -10, -35);

				playAnim('danceRight');

			case 'gfpico2':
				// GIRLFRIEND CODE
			
				frames = AtlasFrameMaker.construct('FULL_GF',
				['GF Dance Beat 3','Sad 3','GF Dancing Beat Hair Blowing 3','GF Dancing Beat Hair Landing 3']);
				// frames = tex;
				 animation.addByIndices('sad', 'Sad 3', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dance Beat 3', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dance Beat 3', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair Blowing 3", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing 3", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
			

				addOffset('sad', 4, -25);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				addOffset('hairBlow', -12, -61);
				addOffset('hairFall', -7, -37);

				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -10, -64);
				addOffset('danceLeft', 0, -59);
				addOffset('danceRight', 0, -59);

				playAnim('danceRight');

			case 'gf-christmas-dead':
				tex = Paths.getSparrowAtlas('characters/gfChristmas');
				frames = tex;
				animation.addByPrefix('fall', 'GF Dancing Beat Fall', 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Dead', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Dead', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('fall', 0, -132);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

			case 'gf-car':
				frames = Paths.getSparrowAtlas('characters/gfCar');
				//frames = tex;
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);
				animation.addByPrefix('duck', 'Duck', 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('duck', -7, -20);

				playAnim('danceRight');

			case 'dad':
				// DAD ANIMATION LOADING CODE
				frames = AtlasFrameMaker.construct('DAD');
				animation.addByPrefix('idle', 'Idle',24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singDOWN', 'Down',24);
				animation.addByPrefix('singLEFT', 'Left',24);
				animation.addByPrefix('singRIGHT', 'Right',24);


				addOffset('idle', 0, 170);
				addOffset("singUP", 6, 192);
				addOffset("singRIGHT", -3, 144);
				addOffset("singLEFT", 54, 140);
				addOffset("singDOWN", 3, 113);

				playAnim('idle');

			case 'SHAKEYDAD':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/SHAKEYDAD_assets');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle', 0, 170);
				addOffset("singUP", 6, 187);
				addOffset("singRIGHT", -2, 144);
				addOffset("singLEFT", 58, 142);
				addOffset("singDOWN", 3, 117);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);
				animation.addByPrefix('YEAH!', 'YEAH!', 24, false);
				// animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);
				setGraphicSize(Std.int(width * 0.94));

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 56);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);
				addOffset("YEAH!", 68, 56);

				playAnim('danceRight');
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');

			case 'mom-car':
				frames = AtlasFrameMaker.construct('HD_MOM');

				animation.addByPrefix('idle', "Idle", 24, false);
				animation.addByPrefix('singUP', "Up", 24, false);
				animation.addByPrefix('singDOWN', "Down", 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Right', 24, false);

				addOffset('idle');
				addOffset("singUP", 35, 105);
				addOffset("singRIGHT", 58, -35);
				addOffset("singLEFT", 230, 37);
				addOffset("singDOWN", 20, -176);

				playAnim('idle');

			case 'mom-car-horny':
				tex = Paths.getSparrowAtlas('characters/momCar_Horny');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Pose Left', 24, false);
				animation.addByPrefix('shootThatMF', 'MOM BEAM', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Left Pose', 24, false);

				addOffset('idle');
				addOffset('shoot');
				addOffset("singUP", 35, 105);
				addOffset("singRIGHT", 38, -55);
				addOffset("singLEFT", 172, 27);
				addOffset("shootThatMF", -31, 8);
				addOffset("singDOWN", 19, -216);

				playAnim('idle');
			case 'super-sonic':
				frames = AtlasFrameMaker.construct('SUPER_SONIC');
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);

				addOffset('idle');
				addOffset("singUP", -40, 20);
				addOffset("singRIGHT", -31, 19);
				addOffset("singLEFT", 20, 10);
				addOffset("singDOWN", 34, 13);
				
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle', 0, 0);
				addOffset("singUP", -60, 150);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -47, 15);
				addOffset("singDOWN", -75, -79);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -40, -94);
				playAnim('idle');
			case 'pico':
			
				frames = AtlasFrameMaker.construct('PICO');
				animation.addByPrefix('idle','Idle',24,false);
				animation.addByPrefix('singUP','Up',24,false);
				animation.addByPrefix('singRIGHT','Left',24,false);
				animation.addByPrefix('singLEFT','Right',24,false);
				animation.addByPrefix('singDOWN','Down',24,false);
				animation.addByPrefix('shoot','Shoot',24,false);

				animation.addByPrefix('idle-cracked','Cracked Idle',24,false);
				animation.addByPrefix('singUP-cracked','Cracked Up',24,false);
				animation.addByPrefix('singRIGHT-cracked','Cracked Left',24,false);
				animation.addByPrefix('singLEFT-cracked','Cracked Right',24,false);
				animation.addByPrefix('singDOWN-cracked','Cracked Down',24,false);
				animation.addByPrefix('shoot-cracked','Cracked Shoot',24,false);
				
		
				// frameWidth = Std.int(frames.getByIndex(0).parent.width / 2);
				// frameHeight = Std.int(frames.getByIndex(0).parent.height / 2);

				addOffset('idle', 0, 0);

				addOffset("singUP", -24, 102);

				addOffset("singLEFT", 60, 1);

				addOffset("singRIGHT", -41, -5);

				addOffset("singDOWN", 118, 3);

				addOffset("shoot", 128, 116);

				addOffset('idle-cracked', 0, 0);

				addOffset("singUP-cracked", -24, 102);

				addOffset("singLEFT-cracked", 60, 1);

				addOffset("singRIGHT-cracked", -41, -5);

				addOffset("singDOWN-cracked", 118, 3);

				addOffset("shoot-cracked", 128, 116);


				playAnim('idle');

				flipX = true;

			case 'bf':
				//var tex = Paths.getSparrowAtlas('characters/BOYFRIEND');
				frames = AtlasFrameMaker.construct('HD_BF');

				animation.addByPrefix('idle','Idle',24,false);
				animation.addByPrefix('idle-stressed', 'Stressed Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singUP-stressed', 'Stressed Up', 24, false);
				animation.addByPrefix('singLEFT','Left',24, false);
				animation.addByPrefix('singLEFT-stressed', 'Stressed Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singRIGHT-stressed', 'Stressed Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singDOWN-stressed', 'Stressed Down', 24, false);
				animation.addByPrefix('singUPmiss', 'Miss Up', 24, false);
				animation.addByPrefix('singUPmiss-stressed', 'Miss Up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Miss Left', 24, false);
				animation.addByPrefix('singLEFTmiss-stressed', 'Miss Left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Miss Right', 24, false);
				animation.addByPrefix('singRIGHTmiss-stressed', 'Miss Right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Miss Down', 24, false);
				animation.addByPrefix('singDOWNmiss-stressed', 'Miss Down', 24, false);
				animation.addByPrefix('hey', 'HEY!!', 24, false);

				animation.addByPrefix('scared', 'Shaking', 24);
				setGraphicSize(Std.int(width * 0.94));
				updateHitbox();

				addOffset('idle', -5);
				addOffset("singUP", -49, 92);
				addOffset("singRIGHT", -62, 9);
				addOffset("singLEFT", -14, 4);
				addOffset("singDOWN", -8, -38);

				addOffset("singUPmiss", -63, -56);
				addOffset("singRIGHTmiss", -66, -59);
				addOffset("singLEFTmiss", -39, -54);
				addOffset("singDOWNmiss", -51, -92);

				addOffset('idle-stressed', -5);
				addOffset("singUP-stressed", -49, 92);
				addOffset("singRIGHT-stressed", -62, 9);
				addOffset("singLEFT-stressed", -14, 4);
				addOffset("singDOWN-stressed", -8, -38);

				//addOffset("singUPmiss-stressed", -45, 54);
				//addOffset("singRIGHTmiss-stressed", -42, 54);
				//addOffset("singLEFTmiss-stressed", 1, 17);
				//addOffset("singDOWNmiss-stressed", -32, -43);

				//addOffset("hey", -1, -1);
				//addOffset('scared', -5, 9);

				playAnim('danceLeft');
				// color = FlxColor.BLACK;

				flipX = true;

			case 'bf-date':
				var tex = Paths.getSparrowAtlas('characters/bfDate');
				frames = tex;


				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('idle-stressed', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset('idle-stressed', -5);
				addOffset("singUP", -37, 102);
				addOffset("singRIGHT", -56, 5);
				addOffset("singLEFT", -33, 1);
				addOffset("singDOWN", -31, -45);

				addOffset("singUPmiss", -37, 88);
				addOffset("singRIGHTmiss", -66, 1);
				addOffset("singLEFTmiss", 0, 13);
				addOffset("singDOWNmiss", -36, -60);
				animation.play('idle');
				flipX = true;

			case 'bf-death':
				var tex = Paths.getSparrowAtlas('characters/GAME_OVER');
				frames = tex;
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				setGraphicSize(Std.int(width * 0.94));
				updateHitbox();
				flipX = true;

				addOffset('firstDeath', -3, 13);
				addOffset('deathLoop', -20, 8);
				addOffset('deathConfirm', -24, 76);

			case 'bf-date-gameover':
				var tex = Paths.getSparrowAtlas('characters/GAME_OVER_DATE');
				frames = tex;
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				setGraphicSize(Std.int(width * 0.94));
				updateHitbox();
				flipX = true;

				addOffset('firstDeath', -3, 13);
				addOffset('deathLoop', -20, 8);
				addOffset('deathConfirm', -24, 76);

			case 'bf-spooky':
				var tex = Paths.getSparrowAtlas('characters/bfSpooky');
				frames = tex;
				animation.addByPrefix('singUP', 'Sing Up', 24, false);
				animation.addByPrefix('singUP-stressed', 'Stressed Up', 24, false);
				animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
				animation.addByPrefix('singLEFT-stressed', 'Stressed Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
				animation.addByPrefix('singRIGHT-stressed', 'Stressed Right', 24, false);
				animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
				animation.addByPrefix('singDOWN-stressed', 'Stressed Down', 24, false);
				animation.addByPrefix('singUPmiss', 'Miss Up', 24, false);
				animation.addByPrefix('singUPmiss-stressed', 'Miss Stress Up', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Miss Left', 24, false);
				animation.addByPrefix('singLEFTmiss-stressed', 'Miss Stress Left', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Miss Right', 24, false);
				animation.addByPrefix('singRIGHTmiss-stressed', 'Miss Stress Right', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Miss Down', 24, false);
				animation.addByPrefix('singDOWNmiss-stressed', 'Miss Stress Down', 24, false);

				animation.addByIndices('danceLeft', 'BF-spooky instance 1', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
				animation.addByIndices('danceRight', 'BF-spooky instance 1', [8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);

				setGraphicSize(Std.int(width * 0.94));
				updateHitbox();

				addOffset('idle', -5);
				addOffset("singUP", -45, 51);
				addOffset("singRIGHT", -46, 0);
				addOffset("singLEFT", -8, -7);
				addOffset("singDOWN", -34, -63);

				addOffset('danceLeft', -10, -15);
				addOffset('danceRight', -10, -15);

				addOffset("singUPmiss", -48, 41);
				addOffset("singRIGHTmiss", -38, 1);
				addOffset("singLEFTmiss", -1, -1);
				addOffset("singDOWNmiss", -35, -50);

				addOffset('idle-stressed', -5);
				addOffset("singUP-stressed", -27, 48);
				addOffset("singRIGHT-stressed", -43, 5);
				addOffset("singLEFT-stressed", -3, 0);
				addOffset("singDOWN-stressed", -32, -49);

				addOffset("singUPmiss-stressed", -45, 44);
				addOffset("singRIGHTmiss-stressed", -48, 11);
				addOffset("singLEFTmiss-stressed", -4, 5);
				addOffset("singDOWNmiss-stressed", -37, -56);

				addOffset("hey", -1, -1);

				addOffset('scared', -9, -4);

				playAnim('danceLeft');

				flipX = true;

			case 'bf-christmas':
				frames= Paths.getSparrowAtlas('characters/bfChristmas');
				
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('idle-stressed', 'BF idle dance', 24, false);
				
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5, -130);
				addOffset('idle-stressed', -5, -130);
				addOffset("singUP", -48, -58);
				addOffset("singRIGHT", -36, -134);
				addOffset("singLEFT", -1, -133);
				addOffset("singDOWN", 16, -180);
				addOffset("singUPmiss", -29, -86);
				addOffset("singRIGHTmiss", -30, -141);
				addOffset("singLEFTmiss", 12, -140);
				addOffset("singDOWNmiss", -11, -190);

				playAnim('idle');

				flipX = true;
			case 'bf-christmas-depressed':
				var tex = Paths.getSparrowAtlas('characters/bfDepressed');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('idle-stressed', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset('idle-stressed', -5);
				addOffset("singUP", -48, 86);
				addOffset("singRIGHT", -56, -4);
				addOffset("singLEFT", -37, -5);
				addOffset("singDOWN", -22, -37);
				addOffset("singUPmiss", -69, 45);
				addOffset("singRIGHTmiss", -70, -13);
				addOffset("singLEFTmiss", -18, -16);
				addOffset("singDOWNmiss", -11, -19);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				//var tex = Paths.getSparrowAtlas('characters/bfCar');
				frames = AtlasFrameMaker.construct('HD_BF_CAR');
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('idle-stressed', 'Stressed Idle', 24, false);
				animation.addByIndices('singUP', 'Up',[0,1,2,3],"", 24, false);
				animation.addByIndices('singUP-stressed', 'Stressed Up',[0,1,2,3],"", 24, false);
				animation.addByIndices('singLEFT', 'Left',[0,1,2,3],"", 24, false);
				animation.addByIndices('singLEFT-stressed', 'Stressed Left',[0,1,2,3],"", 24, false);
				animation.addByIndices('singRIGHT', 'Right',[0,1,2,3],"", 24, false);
				animation.addByIndices('singRIGHT-stressed', 'Stressed Right',[0,1,2,3],"", 24, false);
				animation.addByIndices('singDOWN', 'Down',[0,1,2,3],"", 24, false);
				animation.addByIndices('singDOWN-stressed', 'Stressed Down',[0,1,2,3],"", 24, false);
				animation.addByPrefix('singUPmiss', 'Up Miss', 24, false);
				animation.addByPrefix('singUPmiss-stressed', 'Up Miss', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Left Miss', 24, false);
				animation.addByPrefix('singLEFTmiss-stressed', 'Left Miss', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Right Miss', 24, false);
				animation.addByPrefix('singRIGHTmiss-stressed', 'Right Miss', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Miss Down', 24, false);
				animation.addByPrefix('singDOWNmiss-stressed', 'Miss Down', 24, false);
				animation.addByPrefix('dodge', 'Dodge', 24, false);
				addOffset('idle', -5);
				addOffset("singUP", -17, 24);
				addOffset("singRIGHT", -20, -4);
				addOffset("singLEFT", 12, -15);
				addOffset("singDOWN", -16, -79);
				addOffset("singUPmiss", -20, 15);
				addOffset("singRIGHTmiss", -15, -21);
				addOffset("singLEFTmiss", 9, -21);
				addOffset("singDOWNmiss", -11, -69);
				addOffset('idle-stressed', 12, 4);
				addOffset("singUP-stressed", 0, 14);
				addOffset("singRIGHT-stressed", -21, 0);
				addOffset("singLEFT-stressed", -10, -6);
				addOffset("singDOWN-stressed", -27, -47);
				addOffset("singUPmiss-stressed", -74, 66);
				addOffset("singRIGHTmiss-stressed", -14, 6);
				addOffset("singLEFTmiss-stressed", -18, -9);
				addOffset("singDOWNmiss-stressed", -37, -61);
				addOffset('dodge', 52, -37);
				playAnim('idle');

				flipX = true;

			case 'bf-milf':
				frames = Paths.getSparrowAtlas('characters/bfCar_MILF');
				//frames = AtlasFrameMaker.construct('HD_BF_CAR');
				animation.addByIndices('danceLeft', 'BF idle MILF',[0,1,2,3,4,5,6],"", 24, false);
				animation.addByIndices('danceLeft-stressed', 'BF idle MILF',[0,1,2,3,4,5,6],"", 24, false);
				animation.addByIndices('danceRight', 'BF idle MILF',[7,8,9,10,11,12,13],"", 24, false);
				animation.addByIndices('danceRight-stressed', 'BF idle MILF',[7,8,9,10,11,12,13],"", 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singUP-stressed', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singLEFT-stressed', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singRIGHT-stressed', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singDOWN-stressed', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singUPmiss-stressed', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singLEFTmiss-stressed', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss-stressed', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singDOWNmiss-stressed', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge', 24, false);
				addOffset('danceLeft', -100,50);
				addOffset('danceRight', -5,50);
				addOffset("singUP", -17, 24);
				addOffset("singRIGHT", -20, -4);
				addOffset("singLEFT", -4, -15);
				addOffset("singDOWN", -16, -79);
				addOffset("singUPmiss", -20, 5);
				addOffset("singRIGHTmiss", -15, -21);
				addOffset("singLEFTmiss", 9, -21);
				addOffset("singDOWNmiss", -11, -69);
				addOffset("singUP-stressed", 0, 14);
				addOffset("singRIGHT-stressed", -21, 0);
				addOffset("singLEFT-stressed", -10, -6);
				addOffset("singDOWN-stressed", -16, -64);
				addOffset("singUPmiss-stressed", -24, 13);
				addOffset("singRIGHTmiss-stressed", -14, 6);
				addOffset("singLEFTmiss-stressed", 9, 1);
				addOffset("singDOWNmiss-stressed", -14, -65);
				addOffset('dodge', 48, -10);
				playAnim('danceLeft');

				flipX = true;

			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'bf-death-street':
				tex = Paths.getSparrowAtlas('characters/STREETLIGHT_DEATH');
				frames = tex;
				animation.addByPrefix('deathConfirm', 'bf hat confirm instance 1', 24, false);
				animation.addByPrefix('deathLoop', 'BF dead 3 loop instance 1', 24, true);
				animation.addByPrefix('firstDeath', 'BF dead 3 instance 1', 24, false);

				addOffset('firstDeath', 500);
				addOffset('deathLoop', 500);
				addOffset('deathConfirm', 500);

				playAnim('firstDeath');
				flipX = true;
			case 'bf-sonic-death':
				frames = Paths.getSparrowAtlas('characters/bfSonicDead');
				animation.addByPrefix('firstDeath', 'BF SONIC DEAD', 12, false);
				playAnim('firstDeath');

			case 'bf-sonic-death-2':
				frames = AtlasFrameMaker.construct('SONIC');
				animation.addByPrefix('firstDeath', 'DEAD', 12, false);
				playAnim('firstDeath');

			case 'bf-fucking-dies':
				frames = Paths.getSparrowAtlas('characters/EVISCERATION');
				animation.addByPrefix('deathConfirm', 'BF dead 2 confirm instance 1', 24, false);
				animation.addByPrefix('deathLoop', 'BF dead 2 loop instance 1', 24, true);
				animation.addByPrefix('firstDeath', 'BF dies 2 instance 1', 24, false);
				addOffset('firstDeath');
				addOffset('deathLoop', -37, 30);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				flipX = true;

			case 'senpai':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				frames = Paths.getSparrowAtlas('characters/senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				addOffset('idle');
				addOffset("singUP", 5, 37);
				addOffset("singRIGHT");
				addOffset("singLEFT", 40);
				addOffset("singDOWN", 14);
				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/s');
				
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);
				
				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -73, 36);
				addOffset("singRIGHT", -1, 4);
				addOffset("singLEFT", 0, 6);
				addOffset("singDOWN", -38, -1);
				addOffset("singUP-alt", -43, 27);
				addOffset("singRIGHT-alt", 0, 0);
				addOffset("singLEFT-alt", -3, 7);
				addOffset("singDOWN-alt", -40, -15);
				
				antialiasing = true;

				playAnim('idle');

			case 'parents-christmas-atlas':
				frames = AtlasFrameMaker.construct('PARENTS_CHRISTMAS');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Up Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Down Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Left Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Right Dad', 24, false);
				animation.addByPrefix('singUP-alt', 'Up Mom', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Down Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Left Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Right Mom', 24, false);

				addOffset('idle');
				addOffset("singUP", -73, 36);
				addOffset("singRIGHT", -1, 4);
				addOffset("singLEFT", 0, 6);
				addOffset("singDOWN", -38, -1);
				addOffset("singUP-alt", -43, 27);
				addOffset("singRIGHT-alt", 0, 0);
				addOffset("singLEFT-alt", -3, 7);
				addOffset("singDOWN-alt", -40, -15);

				playAnim('idle');

			case 'sonic-run':
				frames = Paths.getSparrowAtlas('characters/SONIC_RUN');
				animation.addByPrefix('idle', 'SONIC RUNNING HEAD0', 0, false);
				animation.addByPrefix('singUP', 'SONIC RUNNING HEAD UP', 24, false);
				animation.addByPrefix('singDOWN', 'SONIC RUNNING HEAD DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'SONIC RUNNING HEAD LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'SONIC RUNNING HEAD RIGHT', 24, false);

				addOffset('idle');
				addOffset("singUP", -30, -10);
				addOffset("singRIGHT", -30, -15);
				addOffset("singLEFT", -25, 10);
				addOffset("singDOWN", 10, 20);

				playAnim('idle');

			case 'bf-run':
				frames = Paths.getSparrowAtlas('characters/HD_BF_SONIC');
				animation.addByPrefix('idle', 'BF TOP0', 0, false);
				animation.addByPrefix('singUP', 'BF TOP NOTE UP', 24, false);
				animation.addByPrefix('singDOWN', 'BF TOP NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BF TOP NOTE LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BF TOP NOTE RIGHT', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF TOP INVISIBLE', 24, false);

				addOffset('idle');
				addOffset("singUP", -7, 19);
				addOffset("singRIGHT", -16, 7);
				addOffset("singLEFT", -1, 10);
				addOffset("singDOWN", -3, -3);
				addOffset("singUPmiss", -30, 10);
				addOffset("singRIGHTmiss", -30, -15);
				addOffset("singLEFTmiss", -25, 10);
				addOffset("singDOWNmiss", 10, 20);

				playAnim('idle');
				
				flipX = true;

			case 'bf-run-super':
				frames = Paths.getSparrowAtlas('characters/bfSuperRunningTop');
				animation.addByPrefix('idle', 'BF TOP0', 0, false);
				animation.addByPrefix('singUP', 'BF TOP NOTE UP', 24, false);
				animation.addByPrefix('singDOWN', 'BF TOP NOTE DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'BF TOP NOTE LEFT', 24, false);
				animation.addByPrefix('singRIGHT', 'BF TOP NOTE RIGHT', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF TOP INVISIBLE', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF TOP INVISIBLE', 24, false);

				addOffset('idle');
				addOffset("singUP", -7, 19);
				addOffset("singRIGHT", -16, 7);
				addOffset("singLEFT", -1, 10);
				addOffset("singDOWN", -3, -3);
				addOffset("singUPmiss", -30, 10);
				addOffset("singRIGHTmiss", -30, -15);
				addOffset("singLEFTmiss", -25, 10);
				addOffset("singDOWNmiss", 10, 20);

				playAnim('idle');
				
				flipX = true;

			case 'sonic':
				var tex = AtlasFrameMaker.construct('SONIC');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('fuckyoukenny','WOO!',24,false);
				animation.addByPrefix('firstDeath', 'DEAD', 12, false);

				addOffset('idle');
				addOffset("singUP", 83, 43);
				addOffset("singRIGHT", -1, 49);
				addOffset("singLEFT", 150, -40);
				addOffset("singDOWN", 34, 43);
				addOffset("fuckyoukenny", 11, 12);
				addOffset("firstDeath", 11, 12);

			case 'omochao':
				var tex = AtlasFrameMaker.construct('OMOCHAO');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);

				addOffset('idle');
				addOffset("singUP", 2, 35);
				addOffset("singRIGHT", 1, 18);
				addOffset("singLEFT", 18, 21);
				addOffset("singDOWN", 10, -3);

				case 'bf-sonic':
				var tex = AtlasFrameMaker.construct('SONIC_PLAYABLE');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				
				animation.addByPrefix('idle-stressed', 'Idle', 24, false);

				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Right', 24, false);
				animation.addByPrefix('singRIGHT', 'Left', 24, false);

				animation.addByPrefix('singUPmiss', 'Miss Up', 24, false);
				animation.addByPrefix('singDOWNmiss', 'Miss Down', 24, false);
				animation.addByPrefix('singLEFTmiss', 'Miss Right', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'Miss Left', 24, false);

				animation.addByPrefix('singUP-stressed', 'Up', 24, false);
				animation.addByPrefix('singDOWN-stressed', 'Down', 24, false);
				animation.addByPrefix('singLEFT-stressed', 'Right', 24, false);
				animation.addByPrefix('singRIGHT-stressed', 'Left', 24, false);

				animation.addByPrefix('singUPmiss-stressed', 'Miss Up', 24, false);
				animation.addByPrefix('singDOWNmiss-stressed', 'Miss Down', 24, false);
				animation.addByPrefix('singLEFTmiss-stressed', 'Miss Right', 24, false);
				animation.addByPrefix('singRIGHTmiss-stressed', 'Miss Left', 24, false);
				
				animation.addByPrefix('fuckyoukenny','WOO!',24,false);
	
				addOffset('idle');
				addOffset("singUP", 3, 43);
				addOffset("singRIGHT", 29, 9);
				addOffset("singLEFT", -8, 69);
				addOffset("singDOWN", 34, 35);

				addOffset("singUPmiss", 3, 43);
				addOffset("singRIGHTmiss", 29, 9);
				addOffset("singLEFTmiss", -8, 59);
				addOffset("singDOWNmiss", 14, 45);

				addOffset('idle-stressed');
				addOffset("singUP-stressed", 3, 43);
				addOffset("singRIGHT-stressed", 29, 9);
				addOffset("singLEFT-stressed", -8, 69);
				addOffset("singDOWN-stressed", 34, 35);

				addOffset("singUPmiss-stressed", 3, 43);
				addOffset("singRIGHTmiss-stressed", 29, 9);
				addOffset("singLEFTmiss-stressed", -8, 59);
				addOffset("singDOWNmiss-stressed", 14, 45);

				addOffset("fuckyoukenny", 11, 12);

		}

		trace(character);
		
		dance('');

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!isPlayer)
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (dodgetime > 0)
			dodgetime--;
		
		if (!isPlayer)
		{
			//if (animation.curAnim.name.startsWith('sing'))
			//{
			//	holdTimer += elapsed;
			//}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance('');
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf' | 'gfpico' | 'gfpico2':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'mom-car' | 'bf-car':
				if (animation.curAnim.name == 'idle' && animation.curAnim.finished)
					playAnim('idle', false, false, 11);
		}

		if(connectedParent != null){

			if(!animation.curAnim.name.contains("idle")){
				x = trueX + connectedOffsets[connectedParent.animation.curAnim.curFrame % connectedOffsets.length][0];
				y = trueY + connectedOffsets[connectedParent.animation.curAnim.curFrame % connectedOffsets.length][1];
			}
			else{
				x = trueX;
				y = trueY;
				animation.curAnim.curFrame = connectedParent.animation.curAnim.curFrame % animation.curAnim.numFrames;
			}

		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance(huh:String)
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gfpico' | 'gfpico2' | 'gf-date' | 'gf-christmas-dead' | 'gf-eggman':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = PlayState.beats % 2 == 0;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'mom-car':
					if (danced)
						playAnim('idle', true);
					danced = !danced;

				case 'spooky' | 'bf-spooky' | 'bf-milf':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				case 'bf':
					var suffix:String = "";
					if (PlayState.fuckCval)
						suffix = '-stressed';
					else
						suffix = '';

					playAnim('idle' + suffix);
				case 'bf-car':
					var suffix:String = "";
					if (PlayState.fuckCval)
						suffix = '-stressed';
					else
						suffix = '';
					if (!danced)
						playAnim('idle' + suffix, true);
					danced = !danced;
				default:
					playAnim('idle' + huh);
					//This is so fucking braindead
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		
		animOffsets[name] = [x, y];
	}

	public function connectToSprite(_parent:FlxSprite, _posArray:Array<Array<Float>>){

		connectedParent = _parent;
		connectedOffsets = _posArray;

		trueX = x;
		trueY = y;

	}

	public function disconnectFromSprite(){

		connectedParent = null;
		connectedOffsets = null;

		x = trueX;
		y = trueY;

	}

}
