package;

import openfl.utils.AssetCache;
import flixel.FlxG;

import openfl.Assets;
import openfl.display.BitmapData;


class GraphicsCacher{

public static var theCache:AssetCache = new AssetCache();


public static function cache(toCache:String, ID:String):Void{
theCache.setBitmapData(ID,BitmapData.fromFile(toCache));
}

public static function getCache(ID:String){
theCache.enabled = true;
return theCache.getBitmapData(ID);
}

public static function checkCache(ID:String){
trace(theCache.hasBitmapData(ID));
}





}