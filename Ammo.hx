package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Ammo extends Pickup
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		name = "ammo";
		loadGraphic(AssetPaths.ammo__png);
		PlayState.pickups.add(this);
	}
	
	override function kill(){
		super.kill();
	}
	
}