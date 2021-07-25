//hi, asset of splash should be in shared if you dunno where to put it smokey.
package;

import flixel.FlxG;
import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
	public function new(X:Float, Y:Float, ?note:Int)
	{
		super(X, Y);
		if (note == null)
			note = 0;
		frames = Paths.getSparrowAtlas('noteSplashes', 'shared');
		animation.addByPrefix("splash1-0", "note impact 1  blue", 24, false);
		animation.addByPrefix("splash2-0", "note impact 1 green", 24, false);
		animation.addByPrefix("splash0-0", "note impact 1 purple", 24, false);
		animation.addByPrefix("splash3-0", "note impact 1 red", 24, false);

		animation.addByPrefix("splash1-1", "note impact 2 blue", 24, false);
		animation.addByPrefix("splash2-1", "note impact 2 green", 24, false);
		animation.addByPrefix("splash0-1", "note impact 2 purple", 24, false);
		animation.addByPrefix("splash3-1", "note impact 2 red", 24, false);
		if (note != null)
			setupNoteSplash(X, Y, note);
		else//so it wont crash ig?
			setupNoteSplash(X, Y);
	}

	public function setupNoteSplash(xPos:Float, yPos:Float, ?note:Int)
	{
		if (note == null)
			note = 0;//just to make sure
		setPosition(xPos, yPos);
		alpha = 0.7;
		animation.play("splash" + note + "-" + FlxG.random.int(0, 1), true);
		animation.curAnim.frameRate = 24;
		updateHitbox();
		// dont remove updateHitbox smh
		offset.set(0.3 * width, 0.3 * height);
	}

	override public function update(elapsed)
	{
		if (animation.curAnim.finished){
			// remove()
			// zack youre fuking stupid.
			//:(
			kill();
			// trace('the die.');
		}
		super.update(elapsed);
	}
}
