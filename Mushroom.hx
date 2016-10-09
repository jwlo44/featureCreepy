package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;

/**
 * ...
 * @author ...
 */
class Mushroom extends Enemy
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		hp = 3;
		drag.x = drag.y = 400; //inertia
		loadGraphic(AssetPaths.mushroom__png, true, 18, 20);
		animation.add("idle", [0]);
		animation.add("jump", [1, 2, 2, 2, 1, 0], 12, false);
		animation.add("hit", [3]);
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		visible = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (!PlayState.SWORD){
			return;
		}
		visible = true;
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
		if (tick<=2){
			animation.play("jump");
		}
		if (tracking && tick <= 0){ //since it only bounces every few moments we have it in "bursts" of movement handled with tick
			var blind:Int = 20;
			tick = tickRate;
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