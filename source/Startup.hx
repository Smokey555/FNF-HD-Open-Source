package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import sys.FileSystem;
import sys.io.File;
import flixel.FlxG;

using StringTools;

class Startup extends MusicBeatState
{
    var musicDone:Bool = false;
    var portraitsDone:Bool = false;
   
	var Cacher:GraphicsCacher;
    var loadingText:FlxText;

	override function create()
	{

        FlxG.mouse.visible = false;

        

        loadingText = new FlxText(5, FlxG.height - 30, 0, "Preloading Assets...", 24);
        loadingText.setFormat("assets/fonts/vcr.ttf", 24, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(loadingText);

        new FlxTimer().start(1.1, function(tmr:FlxTimer)
        {
            FlxG.sound.play("assets/sounds/splashSound.ogg");   
        });
        sys.thread.Thread.create(() -> {
            preloadPortraits();
        });
        sys.thread.Thread.create(() -> {
            preloadMusic();
        });
        super.create();
        
    }

    override function update(elapsed) 
    {
        
      
       if (musicDone && portraitsDone)
        {
        loadingText.text = "Done!";
        FlxG.sound.play(Paths.sound('confirmMenu'));
        FlxG.switchState(new TitleState());
        }
         
        
        
        super.update(elapsed);

    }

    function preloadPortraits():Void{
	//	var characters = [];
        var portraits = [];
        var music = [];
        
		// for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		// 	{
		// 		if (!i.endsWith(".png"))
		// 			continue;
		// 		characters.push(i);
		// 	}
        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/dialogue/images/portrait")))
			{
				if (!i.endsWith(".png"))
					continue;
				portraits.push(i);
			}
        // for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
        //         {
        //             music.push(i);
        //         }


        // for (i in characters)
        //     {
        //          var replaced = i.replace(".png","");
        //          GraphicsCacher.cache('assets/shared/images/characters/' + i, replaced);
        //          trace("cached character " + replaced);
        //     }
        for (i in portraits)
            {
                 var replaced = i.replace(".png","");
                GraphicsCacher.cache('assets/dialogue/images/portrait/' + i, replaced);
                 trace("cached portrait " + replaced);
            }
        // for (i in music)
        //     {
        //         FlxG.sound.cache(Paths.inst(i));
        //         FlxG.sound.cache(Paths.voices(i));
        //         trace("cached " + i);
               
        //     }
     
        portraitsDone = true;
        

    }

    function preloadMusic():Void{
        var music = [];
        for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
            {
                music.push(i);
            }
        for (i in music)
            {
                FlxG.sound.cache(Paths.inst(i));
                FlxG.sound.cache(Paths.voices(i));
                trace("cached " + i);
                
            }
        musicDone = true;
    }
}
