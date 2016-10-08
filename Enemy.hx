package;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite //generic class for enemy
{
	var hp:Int = 1;
	
	var speed:Int = 140;
	public var str:Int = 60 * 2;
	
	var detectDist:Int = 300;
	var tickRate:Int = 60;

	var stunSet:Int = 40;
	
	var tick:Int = 0;
	var tracking:Bool = false;
	var target:FlxSprite;
	var stun:Int = 0;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		PlayState.enemies.add(this);
	}
	
	public function damage(str:Int){
		if (stun > 0){
			return;
		}
		stun = stunSet;
		animation.play("hit");
		var kb:Float = speed;
		if (getMidpoint().x < target.getMidpoint().x){
			velocity.x = -kb;
		}
		if (getMidpoint().x > target.getMidpoint().x){
			velocity.x = kb;
		}
		if (getMidpoint().y < target.getMidpoint().y){
			velocity.y = -kb;
		}
		if (getMidpoint().y > target.getMidpoint().y){
			velocity.y = kb;
		}
		Utils.explode(getMidpoint().x, getMidpoint().y);
		hp -= str;
		if (hp <= 0){
			kill();
			makePickup();
		}
	}
	
	function makePickup(){
		var lucky:Float = Math.random() * 1;
		if (lucky > 0.1){
			var n:Heart = new Heart(x, y);
			PlayState.pickups.add(n);
		}
	}
	
}