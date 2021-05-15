package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Portrait extends FlxSprite
{

    private var refx:Float;
    private var refy:Float;

    private var resize = 0.35;

    private var characters:Array<String> = ["bf", "gf", "dad", "spooky", "monster", "pico", "darnell", "nene"];

    var posTween:FlxTween;
    var alphaTween:FlxTween;
	
    public function new(_x:Float, _y:Float, _character:String){

        super(_x, _y);

        defineCharacter(_character);
        setGraphicSize(Std.int(width * resize));
        updateHitbox();
        scrollFactor.set();

        refx = x;
        refy = y + height;

        playFrame();
        posTween = FlxTween.tween(this, {x: x}, 0.1);
        alphaTween = FlxTween.tween(this, {alpha: alpha}, 0.1);
        hide();

    }

    function defineCharacter(_character){

        _character = characters.contains(_character) ? _character : "bf";

        frames = Paths.getSparrowAtlas("portrait/" + _character, "dialogue");

        switch(_character){

            case "bf":
                animation.addByPrefix("default", "bf default.png", 0, false);
                animation.addByPrefix("bfGf", "bf and gf default.png", 0, false);
                animation.addByPrefix("confused", "bf confused.png", 0, false);
                animation.addByPrefix("dazed", "bf dazed.png", 0, false);
                animation.addByPrefix("defaultSweat", "bf default sweaty.png", 0, false);
                animation.addByPrefix("fistSweat", "bf fist sweat.png", 0, false);
                animation.addByPrefix("fist", "bf fist.png", 0, false);
                animation.addByPrefix("flirt", "bf flirt.png", 0, false);
                animation.addByPrefix("kiss", "bf kiss.png", 0, false);
                animation.addByPrefix("nervous2", "bf nervous 2.png", 0, false);
                animation.addByPrefix("nervous", "bf nervous.png", 0, false);
                animation.addByPrefix("oof", "bf oof.png", 0, false);
                animation.addByPrefix("questionMark", "bf question mark.png", 0, false);
                animation.addByPrefix("reassure", "bf reassure.png", 0, false);
                animation.addByPrefix("scoff", "bf scoff.png", 0, false);
                animation.addByPrefix("smile", "bf smile.png", 0, false);
                animation.addByPrefix("sulk", "bf sulk.png", 0, false);
                animation.addByPrefix("clear", "bf week clear.png", 0, false);
                animation.play("default");
                resize = 0.4;
            case "gf":
                animation.addByPrefix("default", "gf default.png", 0, false);
                animation.addByPrefix("angry", "gf angry.png", 0, false);
                animation.addByPrefix("blush", "gf blush.png", 0, false);
                animation.addByPrefix("confused", "gf confused.png", 0, false);
                animation.addByPrefix("giggle", "gf giggle.png", 0, false);
                animation.addByPrefix("grimace", "gf grimace.png", 0, false);
                animation.addByPrefix("nervous", "gf nervous.png", 0, false);
                animation.addByPrefix("owl", "gf owl.png", 0, false);
                animation.addByPrefix("pout", "gf pout.png", 0, false);
                animation.addByPrefix("smile", "gf smile.png", 0, false);
                animation.addByPrefix("surprised", "gf surprised.png", 0, false);
                animation.addByPrefix("wehhh", "gf wehhh.png", 0, false);
                animation.addByPrefix("worry", "gf worry.png", 0, false);
                animation.addByPrefix("nervous2", "nervous 2.png", 0, false);
                animation.play("default");
                resize = 0.50;
            case "dad":
                animation.addByPrefix("default", "dad default.png", 0, false);
                animation.addByPrefix("bleed", "dad bleed 1.png", 0, false);
                animation.addByPrefix("bleed2", "dad bleed 2.png", 0, false);
                animation.addByPrefix("limit", "dad limit.png", 0, false);
                animation.addByPrefix("mic", "dad mic.png", 0, false);
                animation.play("default");
            case "spooky":
                animation.addByPrefix("default", "skump default.png", 0, false);
                animation.addByPrefix("happy", "skump happy.png", 0, false);
                animation.addByPrefix("sad", "skump sad.png", 0, false);
                animation.play("default");
            case "monster":
                animation.addByPrefix("default", "monster default.png", 0, false);
                animation.addByPrefix("laugh", "monster laugh.png", 0, false);
                animation.addByPrefix("smile", "monster smile.png", 0, false);
                animation.play("default");
            case "pico":
                animation.addByPrefix("default", "pico default.png", 0, false);
                animation.addByPrefix("angry", "pico angry.png", 0, false);
                animation.addByPrefix("blush", "pico blush.png", 0, false);
                animation.addByPrefix("choke", "pico choke.png", 0, false);
                animation.addByPrefix("disappearing", "pico disappearing.png", 0, false);
                animation.addByPrefix("furious2", "pico furious 2.png", 0, false);
                animation.addByPrefix("furious", "pico furious.png", 0, false);
                animation.addByPrefix("gloom", "pico gloom.png", 0, false);
                animation.addByPrefix("grimace", "pico grimace.png", 0, false);
                animation.addByPrefix("happy", "pico happy.png", 0, false);
                animation.addByPrefix("bruh", "pico bruh.png", 0, false);
                animation.addByPrefix("scoff", "pico scoff.png", 0, false);
                animation.addByPrefix("shout", "pico shout.png", 0, false);
                animation.addByPrefix("smile", "pico smile.png", 0, false);
                animation.play("default");
                resize = 0.3;
            case "darnell":
                animation.addByPrefix("default", "darnell default.png", 0, false);
                animation.addByPrefix("shit", "darnell shit.png", 0, false);
                animation.addByPrefix("shocked", "darnell shocked.png", 0, false);
                animation.play("default");
                resize = 0.38;
            case "nene":
                animation.addByPrefix("default", "nene default.png", 0, false);
                animation.addByPrefix("cries", "nene cries.png", 0, false);
                animation.addByPrefix("disgusted", "nene disgusted.png", 0, false);
                animation.addByPrefix("shocked", "nene shocked.png", 0, false);
                animation.play("default");
                resize = 0.5;
                

        }

    }

    public function playFrame(?_frame:String = "default"){

        visible = true;

        animation.play(_frame);
        flipX = false;
        updateHitbox();

        x = refx;
        y = refy - height;

    }

    public function hide(){

        alphaTween.cancel();
        posTween.cancel();
        alpha = 1;
        visible = false;

    }

    public function effectFadeOut(?time:Float = 1){

        alphaTween.cancel();
        alpha = 1;
        alphaTween = FlxTween.tween(this, {alpha: 0}, time);

    }

    public function effectFadeIn(?time:Float = 1){

        alphaTween.cancel();
        alpha = 0;
        alphaTween = FlxTween.tween(this, {alpha: 1}, time);

    }

    public function effectExitStageLeft(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: 0 - width}, time, {ease: FlxEase.circIn});

    }

    public function effectExitStageRight(?time:Float = 1){

        posTween.cancel();
        posTween = FlxTween.tween(this, {x: FlxG.width}, time, {ease: FlxEase.circIn});

    }

    public function effectFlipRight(){

        x = FlxG.width - refx - width;
        y = refy - height;

    }

    public function effectFlipDirection(){
        
        flipX = true;

    }

    public function effectEnterStageLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = 0 - width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});

    }

    public function effectEnterStageRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = FlxG.width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});
    }

    public function effectToRight(?time:Float = 1){
        
        posTween.cancel();
        var finalX = FlxG.width - refx - width;
        x = refx;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }

    public function effectToLeft(?time:Float = 1){
        
        posTween.cancel();
        var finalX = refx;
        x = FlxG.width - refx - width;
        y = refy - height;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.quintOut});
    }

    /*public function effectShake(?time:Float = 1){
        
        posTween.cancel();
        var finalX = x;
        x = FlxG.width;
        posTween = FlxTween.tween(this, {x: finalX}, time, {ease: FlxEase.circOut});
    }*/

}
