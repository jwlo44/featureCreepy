package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.smallbullet__png, true, 6, 6);
		animation.add("flash", [0, 1, 2]);
		animation.play("flash");
		PlayState.bullets.add(this);
	}
	
}