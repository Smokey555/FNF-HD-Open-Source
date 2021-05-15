package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Engie extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("engie");
		animation.addByPrefix('Pissface', 'Pissface', 24, true);
		animation.play('Pissface');
	
	}

}
