package;
import flixel.FlxG;
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
	
	var name:String = "enemy";

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		PlayState.enemies.add(this);
		makeGraphic(1, 1);
	}
	
	override public function update(elapsed:Float):Void 
	{
		target = PlayState.crepe;
		FlxG.overlap(this, PlayState.bullets, damageB);
		super.update(elapsed);
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
			PlayState.addEnemy(name);
			makePickup();
		}
	}
	
	public function damageB(c:Enemy, b:Bullet){
		if (b.team==2){
			return;
		}
		stun = stunSet;
		animation.play("hit");
		var kb:Float = speed;
		if (getMidpoint().x < b.getMidpoint().x){
			velocity.x = -kb;
		}
		if (getMidpoint().x > b.getMidpoint().x){
			velocity.x = kb;
		}
		if (getMidpoint().y < b.getMidpoint().y){
			velocity.y = -kb;
		}
		if (getMidpoint().y > b.getMidpoint().y){
			velocity.y = kb;
		}
		Utils.explode(getMidpoint().x, getMidpoint().y);
		hp -= 2;
		b.kill();
		if (hp <= 0){
			kill();
			PlayState.addEnemy(name);
			makePickup();
		}
	}
	
	function makePickup(){
		var lucky:Float = Math.random() * 1;
		if (lucky > 0.2 && lucky<0.6){
			var n:Heart = new Heart(x, y);
			PlayState.pickups.add(n);
		}
		if (lucky > 0.6 && lucky<1 && PlayState.BULLETS){
			var n:Ammo = new Ammo(x, y);
			PlayState.pickups.add(n);
		}
	}
	
}