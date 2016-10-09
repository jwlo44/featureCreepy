package;

import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{
	var life:Int = 120;
	public var str:Int = 30;
	
	public function new(?X:Float=0, ?Y:Float=0, ?target:FlxSprite) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.smallbullet__png, true, 6, 6);
		animation.add("flash", [0, 1, 2]);
		animation.play("flash");
		PlayState.bullets.add(this);
		if (target != null){
			FlxVelocity.moveTowardsObject(this, target, 60, 1000);
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		life--;
		if (life < 0){
			kill();
		}
		super.update(elapsed);
	}
	
}