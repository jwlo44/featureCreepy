package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Gun extends Enemy
{
	var shootDist:Int = 0;
	
	var attacking:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		hp = 3;
		speed = 60;
		drag.x = drag.y = 400; //inertia
		loadGraphic(AssetPaths.gun__png, true, 16, 20);
		animation.add("walk", [0, 0, 1, 2, 3, 3, 2, 1], 12, true);
		animation.add("shoot", [2, 3], 12, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
	}
	
	override public function update(elapsed:Float):Void 
	{
		stun--;
		tick--;
		if (stun > 0){
			super.update(elapsed);
			return;
		}
		if (Utils.distance(getMidpoint(), PlayState.crepe.getMidpoint())<detectDist){ //looking for crpee, if it finds it then it's permanently chasing them
			tracking = true;
			target = PlayState.crepe;
		}
		animation.play("walk");
		if (!attacking && Utils.distance(getMidpoint(), PlayState.crepe.getMidpoint()) < shootDist){
			attacking = true;
			animation.play("shoot");
			if (animation.finished){
				var b:Bullet = new Bullet();
			}
		}
		if (tracking && !attacking){ //since it only bounces every few moments we have it in "bursts" of movement handled with tick
			var blind:Int = 20;
			if (getMidpoint().x < target.getMidpoint().x - blind){
				velocity.x = speed;
				facing = FlxObject.RIGHT;
			}
			if (getMidpoint().x > target.getMidpoint().x + blind){
				velocity.x = -speed;
				facing = FlxObject.LEFT;
			}
			if (getMidpoint().y < target.getMidpoint().y - blind){
				velocity.y = speed;
			}
			if (getMidpoint().y > target.getMidpoint().y + blind){
				velocity.y = -speed;
			}
		}
		super.update(elapsed);
	}
	
}