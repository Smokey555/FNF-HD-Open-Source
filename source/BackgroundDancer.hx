package;

import flixel.math.FlxRandom;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class BackgroundDancer extends FlxSprite
{

	var animationSuffix:String;
	public function new(x:Float, y:Float)
	{

		super(x, y);

		frames = Paths.getSparrowAtlas("limo/limoDancers");
		animation.addByIndices('danceLeft-alvin', 'alvin', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight-alvin', 'alvin', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.addByIndices('danceLeft-bojangles', 'bojangles', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight-bojangles', 'bojangles', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.addByIndices('danceLeft-bubbles', 'bubbles', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight-bubbles', 'bubbles', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.addByIndices('danceLeft-michael', 'michael', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight-michael', 'michael', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.play('danceLeft');
		antialiasing = true;

		
	}

	var danceDir:Bool = false;

	public function dance(danceName:String):Void
	{
		danceDir = !danceDir;
		switch (danceName){
		case 'alvin':
		animationSuffix = '-alvin';
		case 'bojangles':
		animationSuffix = '-bojangles';
		case 'michael':
		animationSuffix = '-michael';
		case 'bubbles':
		animationSuffix = '-bubbles';
		}
		if (danceDir)
			animation.play('danceRight' + animationSuffix, true);
		else
			animation.play('danceLeft' + animationSuffix, true);
	}
}
