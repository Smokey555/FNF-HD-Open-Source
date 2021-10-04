package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class Portrait extends FlxSprite
{

    private var refx:Float;
    private var refy:Float;

    private var resize = 0.35;

    public var characters:Array<String> = ["bf", "gf", "dad", "spooky", "monster", "pico", "darnell", "nene", 'mom', 'imps', 'sonic', 'super-sonic', 'sonic'];

    var posTween:FlxTween;
    var alphaTween:FlxTween;
	
    public function new(_x:Float, _y:Float, _character:String){

        super(_x, _y);

        defineCharacter(_character);
        setGraphicSize(Std.int(width * resize));
        updateHitbox();
        scrollFactor.set();
        antialiasing = true;

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

            case "noChar":
                addAnim("default", "noChar instance 1");
            case "bf":
                addAnim2("default", "Symbol 1",[11]);
                addAnim2("bfGf", "Symbol 1",[0]);
                addAnim2("confused", "Symbol 1",[5]);
                addAnim2("dazed","Symbol 1",[9]);
                addAnim2("defaultSweat", "Symbol 1",[11]);
                addAnim2("fistSweat", "Symbol 1",[15]);
                addAnim2("fist", "Symbol 1",[16]);
                addAnim2('defaultBlush', "Symbol 1",[10]);
                addAnim2('fistBlush', "Symbol 1",[14]);
                addAnim2('dreamy', "Symbol 1",[13]);
                addAnim2('blush', "Symbol 1",[4]);
                addAnim2('pant', "Symbol 1",[24]);
                addAnim2('happyCry', "Symbol 1",[19]);
                addAnim2('post-up',"Symbol 1",[25]);
                addAnim2('angry', "Symbol 1",[2]);
                addAnim2('angry2', "Symbol 1",[1]);
                addAnim2('cry', "Symbol 1",[7]);
                addAnim2('sad', "Symbol 1",[30]);
                addAnim2("flirt", "Symbol 1",[17]);
                addAnim2("kiss", "Symbol 1",[20]);
                addAnim2("nervous2", "Symbol 1",[21]);
                addAnim2("nervous", "Symbol 1",[22]);
                addAnim2("oof", "Symbol 1",[23]);
                addAnim2("questionMark","Symbol 1",[26]);
                addAnim2("reassure", "Symbol 1",[27]);
                addAnim2("scoff", "Symbol 1",[32]);
                addAnim2("happy", "Symbol 1",[35]);
                addAnim2("smile", "Symbol 1",[35]);
                addAnim2("sulk", "Symbol 1",[37]);
                addAnim2("clear", "Symbol 1",[38]);
                addAnim2("cringe", "Symbol 1",[6]);
                addAnim2("crying", "Symbol 1",[8]);
                addAnim2("scared", "Symbol 1",[31]);
                addAnim2("shocked", "Symbol 1",[34]);
                addAnim2("snap", "Symbol 1",[36]);
                addAnim2("wipe", "Symbol 1",[40]);
                 //***************////**/**/
                addAnim2("run", "Symbol 1",[28]);
                addAnim2("run-sad", "Symbol 1",[29]);
                addAnim2('giddy',"Symbol 1",[18]);
                addAnim2('wind',"Symbol 1",[39]);
                addAnim2('scratch',"Symbol 1",[33]);
                addAnim2('blush2',"Symbol 1",[3]);

                animation.play("default");
                resize = 0.5;
            case "gf":
                addAnim("default", "gf default.png");
                addAnim("angry", "gf angry.png");
                addAnim("blush", "gf blush.png");
                addAnim("confused", "gf confused.png");
                addAnim("giggle", "gf giggle.png");
                addAnim("grimace", "gf grimace.png");
                addAnim("nervous", "gf nervous.png");
                addAnim("owl", "gf owl.png");
                addAnim("pout", "gf pout.png");
                addAnim("smile", "gf smile.png");
                addAnim("surprised", "gf surprised.png");
                addAnim("wehhh", "gf wehhh.png");
                addAnim("worry", "gf worry.png");
                addAnim("nervous2", "nervous 2.png");
                addAnim('happycry', 'gf happy cry.png');
                addAnim('happycry2', 'gf happy cry 2.png');
                addAnim('count', 'gf count.png');
                addAnim('embarrassed','gf embarrassed.png');
                addAnim('angry2', 'gf angry 2.png');
                addAnim('reassure', 'gf reassure.png');
                addAnim('cry','gf cry.png');
                addAnim('think', 'gf think.png');
                addAnim('blush 2', 'gf blush 2.png');
                addAnim('hug', 'gf hug.png');
                addAnim('point', 'gf point.png');
                addAnim('reassure 2', 'gf reassure 2.png');
                addAnim('relief', 'gf relief.png');
                addAnim('sheesh', 'gf sheesh.png');
                addAnim('giddy', 'gf giddy.png');
                addAnim('eh', 'gf eh.png');
                addAnim('tired','gf tired.png');
                animation.play("default");
                resize = 0.50;
            case "dad":
                addAnim("default", "dad default.png");
                addAnim("bleed", "dad bleed 1.png");
                addAnim("bleed2", "dad bleed 2.png");
                addAnim("limit", "dad limit.png");
                addAnim("mic", "dad mic.png");
                addAnim("angry", "dad angry.png");
                addAnim("default 2", "dad default 2.png");
                addAnim("shock", "dad shock.png");
                addAnim("smile", "dad smile.png");
                animation.play("default");
                resize = 0.13;
            case "spooky":
                addAnim("default", "skump default.png");
                addAnim("happy", "skump happy.png");
                addAnim("sad", "skump sad.png");
                animation.play("default");
            case "monster":
                addAnim("default", "monster default.png");
                addAnim("laugh", "monster laugh.png");
                addAnim("smile", "monster smile.png");
                addAnim("glare", "monster glare.png");
                animation.play("default");
            case "pico":
                addAnim("default", "pico default.png");
                addAnim("angry", "pico angry.png");
                addAnim("blush", "pico blush.png");
                addAnim("choke", "pico choke.png");
                addAnim("disappearing", "pico disappearing.png");
                addAnim("furious2", "pico furious 2.png");
                addAnim("furious", "pico furious.png");
                addAnim("gloom", "pico gloom.png");
                addAnim("grimace", "pico grimace.png");
                addAnim("happy", "pico happy.png");
                addAnim("bruh", "pico bruh.png");
                addAnim("scoff", "pico scoff.png");
                addAnim("shout", "pico shout.png");
                addAnim("smile", "pico smile.png");
                animation.play("default");
                resize = 0.3;
            case "darnell":
                addAnim("default", "darnell default.png");
                addAnim("shit", "darnell shit.png");
                addAnim("shocked", "darnell shocked.png");
                addAnim("happy", "darnell happy.png");
                animation.play("default");
                resize = 0.38;
            case "nene":
                addAnim("default", "nene default.png");
                addAnim("cries", "nene cries.png");
                addAnim("disgusted", "nene disgusted.png");
                addAnim("shocked", "nene shocked.png");
                addAnim("happy", "nene happy.png");
                animation.play("default");
                resize = 0.5;
             case "mom":
                addAnim('default', 'mom default.png');
                addAnim("defaultSweat", "mom default sweat.png");
                addAnim("defaultHorny", "mom default horny.png");
                addAnim("happy", "mom happy.png");
                addAnim("crazy", "mom crazy.png");
                addAnim("laugh", "mom laugh.png");
                addAnim("point", "mom point.png");
                addAnim("seduce", "mom seduce.png");
                addAnim("smirk", "mom smirk.png");
                addAnim("angry", "mom angry.png");
                addAnim("grab", "mom grab.png");
                addAnim("horny1", "mom horny 1.png");
                addAnim("horny2", "mom horny 2.png");
                addAnim("horny3", "mom horny 3.png");
                addAnim("bore", "mom bore.png");
                animation.play("default");
                resize = 0.2;
                
            case "imps":
                addAnim('alvin', 'alvin.png');
                addAnim('bojangles', 'bojangles.png');
                addAnim('bubbles', 'bubbles.png');
                addAnim('imps', 'imps.png');
                addAnim('michael', 'michael.png');
                animation.play("alvin");
                resize = 0.4;
        
            case 'sonic':
                addAnim('blush', 'sonic blush.png');
                addAnim('default', 'sonic default.png');
                addAnim('fist', 'sonic fist.png');
                addAnim('happy', 'sonic happy.png');
                addAnim('laugh', 'sonic laugh.png');
                addAnim('run', 'sonic run.png');
            case 'super-sonic':
                addAnim('default', 'super sonic default.png');
                addAnim('reassure', 'super sonic reassure.png');
                addAnim('yikes', 'super sonic yikes.png');

        }

     

    }
    
    function addAnim(anim:String, prefix:String){
        animation.addByPrefix(anim,prefix, 0, false);
    }    
    function addAnim2(anim:String, prefix:String,indices:Array<Int>){
        animation.addByIndices(anim,prefix,indices,"", 0, false);
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

   
}
