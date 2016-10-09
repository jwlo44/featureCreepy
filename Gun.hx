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
	var shootDist:Int = 100;
	
	var attacking:Bool = false;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		hp = 2;
		speed = 60;
		drag.x = drag.y = 400; //inertia
		loadGraphic(AssetPaths.gun__png, true, 16, 20);
		animation.add("walk", [0, 0, 1, 2, 3, 3, 2, 1], 12, true);
		animation.add("shoot", [4, 4, 4, 5, 4, 4, 4, 4, 4, 4], 20, false);
		animation.add("hit", [0]);
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
		if (!attacking){
			animation.play("walk");
		}
		if (Utils.distance(getMidpoint(), PlayState.crepe.getMidpoint()) < shootDist){
			attacking = true;
			if(animation.name!="shoot"){
				animation.play("shoot");
			}
			if (animation.finished){
				animation.play("shoot");
				if(facing == FlxObject.RIGHT){
					var b:Bullet = new Bullet(x+width, y, target);
				}else{
					var b:Bullet = new Bullet(x, y, target);
				}
			}
		}else{
			if(attacking&&animation.finished){
				attacking = false;
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