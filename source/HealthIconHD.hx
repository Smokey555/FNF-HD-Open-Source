package;

import flixel.FlxSprite;

class HealthIconHD extends FlxSprite
{
	/**
	 * UNUSED IGNORE 
	 */
	public var sprTracker:FlxSprite;
	

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		//I known this is retarded dont even tell me
		super();
		loadGraphic(Paths.image('iconGridHD'), true, 1000, 1000);

			animation.add('bf', [0, 1], 0, false, isPlayer);
			animation.add('bf-car', [0, 1], 0, false, isPlayer);
			animation.add('mom-car', [0, 1], 0, false, isPlayer);
			animation.add('bf-spooky', [0, 1], 0, false, isPlayer);
			animation.add('spooky', [5, 6], 0, false, isPlayer);
			animation.add('pico', [8, 9], 0, false, isPlayer);
			animation.add('dad', [2, 3], 0, false, isPlayer);
			animation.add('SHAKEYDAD', [2, 3], 0, false, isPlayer);
			animation.add('monster', [11, 12], 0, false, isPlayer);
			animation.add('gf', [10, 10, 10], 0, false, isPlayer);
		
			updateHitbox();

			
			
		
			
		antialiasing = true;
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
