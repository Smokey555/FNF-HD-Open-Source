package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	public var dodgetime:Float = 0;

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
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer', 2, -35);
				addOffset('sad', -9, -14);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				addOffset("singUP", 3, 10);
				addOffset("singRIGHT", 1, -7);
				addOffset("singLEFT", 1, -2);
				addOffset("singDOWN", 1, 3);
				addOffset('hairBlow', 0, 1);
				addOffset('hairFall', 2, -9);

				addOffset('scared', -9, -3);

				playAnim('danceRight');

			case 'gfpico':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets_pico');
				frames = tex;
				animation.addByIndices('sad', 'gf sad 2', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat 2', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat 2', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing 2", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing 2", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);

				addOffset('sad', 2, -16);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);

				addOffset('hairBlow', 2, 1);
				addOffset('hairFall', 2, -13);

				playAnim('danceRight');

			case 'gfpico2':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('GF_assets_pico2');
				frames = tex;
				animation.addByIndices('sad', 'gf sad 2', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat 3', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat 3', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing 3", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing 3", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
	
				addOffset('sad', -11, -32);
				addOffset('danceLeft', 2, -11);
				addOffset('danceRight', 2, -11);
	
				addOffset('hairBlow', 2, 1);
				addOffset('hairFall',  2, 1);
	
				playAnim('danceRight');

			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('christmas/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

			case 'gf-car':
				tex = Paths.getSparrowAtlas('limo/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('sad', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('idle', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,false);
				animation.addByPrefix('duck', 'GF Duck',24,false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);
				addOffset('duck', -7,-20);

				playAnim('danceRight');
				

			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note right', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'dad sing note LEFT', 24);

				addOffset('idle', 0, 170);
				addOffset("singUP", -7, 163);
				addOffset("singRIGHT", -3, 134);
				addOffset("singLEFT", 20, 140);
				addOffset("singDOWN", 5, 82);

				playAnim('idle');
				
			case 'SHAKEYDAD':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('SHAKEYDAD_assets');
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
				tex = Paths.getSparrowAtlas('spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);
				setGraphicSize(Std.int(width * 0.94));

				addOffset('danceLeft');
				addOffset('danceRight');

				addOffset("singUP", -20, 56);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);

				playAnim('danceRight');
		//shes useless

			case 'mom-car':
				tex = Paths.getSparrowAtlas('momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 35, 105);
				addOffset("singRIGHT", 58, -35);
				addOffset("singLEFT", 230, 37);
				addOffset("singDOWN", 20, -176);

				playAnim('idle');

			case 'mom-car-horny':
				tex = Paths.getSparrowAtlas('momCar_Horny');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('shootThatMF', 'MOM BEAM', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset('shoot');
				addOffset("singUP", 35, 105);
				addOffset("singRIGHT", 38, -55);
				addOffset("singLEFT", 172, 27);
				addOffset("shootThatMF", -31, 8);
				addOffset("singDOWN", 19, -216);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('Monster_Assets');
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
				tex = Paths.getSparrowAtlas('christmas/monsterChristmas');
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
				tex = Paths.getSparrowAtlas('Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note', 24, false);
				animation.addByPrefix('singLEFT', 'Pico Note Right', 24, false);
				animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT', 24, false);
				animation.addByPrefix('shoot', 'Pico-shoot', 24, false);
				setGraphicSize(Std.int(width * 0.94));
				

				addOffset('idle');
				addOffset("singUP", -32, 40);
				addOffset("singRIGHT", -56, -7);
				addOffset("singLEFT",  53, -2);
				addOffset("singDOWN", -29, -71);
				addOffset("shoot", -44, -22);

				playAnim('idle');

				flipX = true;

			case 'bf':
				var tex = Paths.getSparrowAtlas('BOYFRIEND');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('idle-stressed', 'Stressed Idle', 24, false);
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
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				setGraphicSize(Std.int(width * 0.94));
				updateHitbox();

				addOffset('idle', -5);
				addOffset("singUP", -46, 29);
				addOffset("singRIGHT", -44, 3);
				addOffset("singLEFT", -25, -11);
				addOffset("singDOWN", -23, -65);

			
				addOffset("singUPmiss", -44, 17);
				addOffset("singRIGHTmiss", -38, 1);
				addOffset("singLEFTmiss", -10, -7);
				addOffset("singDOWNmiss", -27, -52);

				addOffset('idle-stressed', -5);
				addOffset("singUP-stressed", -24, 61);
				addOffset("singRIGHT-stressed", -37, 20);
				addOffset("singLEFT-stressed", -4,11);
				addOffset("singDOWN-stressed", -19, -43);

				addOffset("singUPmiss-stressed", -45, 54);
				addOffset("singRIGHTmiss-stressed", -42, 54);
				addOffset("singLEFTmiss-stressed", 1, 17);
				addOffset("singDOWNmiss-stressed", -32, -43);

				addOffset("hey", -1, -1);
				addOffset('firstDeath', -3, 13);
				addOffset('deathLoop', -20, 8);
				addOffset('deathConfirm', -24, 76);
				addOffset('scared', -5, 9);

				playAnim('danceLeft');
				//color = FlxColor.BLACK;

				flipX = true;

				case 'bf-death':
				var tex = Paths.getSparrowAtlas('GAME_OVER');
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
				var tex = Paths.getSparrowAtlas('bfSpooky');
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
				var tex = Paths.getSparrowAtlas('christmas/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('idle-stressed', 'Stressed Idle', 24, false);
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
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', 'boyfriend dodge instance 1', 24, false);
				addOffset('idle', -5);
				addOffset("singUP", -17, 24);
				addOffset("singRIGHT", -20, -4);
				addOffset("singLEFT", -4, -15);
				addOffset("singDOWN", -16, -79);
				addOffset("singUPmiss", -20, 5);
				addOffset("singRIGHTmiss", -15, -21);
				addOffset("singLEFTmiss", 9, -21);
				addOffset("singDOWNmiss", -11, -69);
				addOffset('idle-stressed', 12,4);
				addOffset("singUP-stressed", 0, 14);
				addOffset("singRIGHT-stressed", -21, 0);
				addOffset("singLEFT-stressed", -10, -6);
				addOffset("singDOWN-stressed", -16, -64);
				addOffset("singUPmiss-stressed", -24, 13);
				addOffset("singRIGHTmiss-stressed", -14, 6);
				addOffset("singLEFTmiss-stressed", 9, 1);
				addOffset("singDOWNmiss-stressed", -14, -65);
				addOffset('dodge', 48, 3);
				playAnim('idle');

				flipX = true;


				case 'bf-milf':
					var tex = Paths.getSparrowAtlas('bfCar_MILF');
					frames = tex;
					animation.addByPrefix('idle', 'Idle', 24, false);
					animation.addByPrefix('idle-stressed', 'Stressed Idle', 24, false);
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
					animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
					animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

					animation.addByIndices('danceLeft', 'bf limo dance', [0, 1, 2, 3, 4, 5, 6,7, 8], "", 24, false);
					animation.addByIndices('danceRight', 'bf limo dance', [9 ,10, 11, 12, 13, 14, 15, 16, 17], "", 24, false);
					animation.addByPrefix('dodge', 'boyfriend dodge', 12, false);
					addOffset("dodge", 46, -30);
					
	
					addOffset('idle', -5);
					addOffset('danceLeft', 35,40);
					addOffset('danceRight', 165,50);
					addOffset("singUP", -20, 8);
					addOffset("singRIGHT", -18, -11);
					addOffset("singLEFT", 2, -23);
					addOffset("singDOWN", 0, -85);
					addOffset("singUPmiss", -19, 5);
					addOffset("singRIGHTmiss", -20, -27);
					addOffset("singLEFTmiss", 13, -25);
					addOffset("singDOWNmiss", -2, -79);
					
					addOffset("singUP-stressed", -20, 8);
					addOffset("singRIGHT-stressed", -18, -11);
					addOffset("singLEFT-stressed", 2, -23);
					addOffset("singDOWN-stressed", 0, -85);
					addOffset("singUPmiss-stressed", -19, 5);
					addOffset("singRIGHTmiss-stressed", -20, -27);
					addOffset("singLEFTmiss-stressed", 13, -25);
					addOffset("singDOWNmiss-stressed", -2, -79);
					playAnim('danceLeft');
	
					flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('weeb/bfPixel');
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
				frames = Paths.getSparrowAtlas('weeb/bfPixelsDEAD');
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
				tex = Paths.getSparrowAtlas('STREETLIGHT_DEATH');
				frames = tex;
				animation.addByPrefix('deathConfirm', 'bf hat confirm instance 1', 24, false);
				animation.addByPrefix('deathLoop', 'BF dead 3 loop instance 1', 24, true);
				animation.addByPrefix('firstDeath', 'BF dead 3 instance 1', 24, false);
	
				addOffset('firstDeath', 500);
				addOffset('deathLoop', 500);
				addOffset('deathConfirm', 500);

				playAnim('firstDeath');
				flipX = true;

			case 'bf-fucking-dies':
				frames = Paths.getSparrowAtlas('EVISCERATION');
				animation.addByPrefix('deathConfirm', 'BF dead 2 confirm instance 1', 24, false);
				animation.addByPrefix('deathLoop', 'BF dead 2 loop instance 1', 24, true);
				animation.addByPrefix('firstDeath', 'BF dies 2 instance 1', 24, false);
				addOffset('firstDeath');
				addOffset('deathLoop', -37, 30);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				flipX = true;


			case 'senpai':
				frames = Paths.getSparrowAtlas('weeb/senpai');
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
				frames = Paths.getSparrowAtlas('weeb/senpai');
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
				frames = Paths.getPackerAtlas('weeb/spirit');
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
				frames = Paths.getSparrowAtlas('christmas/mom_dad_christmas_assets');
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
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
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
		if (dodgetime > 0) dodgetime --;
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf' | 'gfpico' | 'gfpico2':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case 'mom-car' | 'bf-car':
				if(animation.curAnim.name == 'idle' && animation.curAnim.finished)
					playAnim('idle',false,false,11);
		
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			

			
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gfpico' | 'gfpico2':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'mom-car':
					if(danced)
						playAnim('idle',true);
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
					//not sure if this else is needed so uh, delete it if its unnecessary
					playAnim('idle' + suffix);
				case 'bf-car':
					var suffix:String = "";
					if (PlayState.fuckCval)
					suffix = '-stressed';
					else
					suffix = '';
					if(!danced)
						playAnim('idle' + suffix ,true);
					danced = !danced;	
				default:
					playAnim('idle');
				
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
}
