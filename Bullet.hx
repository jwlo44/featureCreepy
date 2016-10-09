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
	public var team:Int = 0;
	
	public function new(?X:Float = 0, ?Y:Float = 0, Team:Int = 1, ?target:FlxSprite, velX:Int = 0, velY:Int = 0) 
	{
		super(X, Y);
		team = Team;
		loadGraphic(AssetPaths.smallbullet__png, true, 6, 6);
		if (team == 1){
			loadGraphic(AssetPaths.goodbullet__png, true, 6, 6);
		}
		animation.add("flash", [0, 1, 2]);
		animation.play("flash");
		PlayState.bullets.add(this);
		velocity.x = velX;
		velocity.y = velY;
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
	
	override public function kill():Void 
	{
		PlayState.bullets.remove(this, true);
		super.kill();
	}
	
}