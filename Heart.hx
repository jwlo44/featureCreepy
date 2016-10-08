package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Heart extends Pickup
{

	public var nomval:Int = 60 * 10;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		name = "heart";
		loadGraphic(AssetPaths.heart__png);
		PlayState.misc.add(this);
	}
	
	override function kill(){
		super.kill();
	}
	
}