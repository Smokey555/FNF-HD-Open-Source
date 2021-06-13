package;


import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;


class Week4Stage extends FlxSprite
{


	public function new(x:Float, y:Float, anim:String)
	{

		super(x, y);

		frames = Paths.getSparrowAtlas("limo/week4ShitIdk");
        animation.addByPrefix('rails', "railing instance 1", 24);
		animation.addByPrefix('road', "street instance 1", 24);
        animation.addByPrefix('bglimo', "BG limo instance 1", 24);
        antialiasing = true;

      animation.play(anim);

		
	}

	
}
