package;
import flash.display.InterpolationMethod;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Crepe extends FlxSprite
{
	var speed:Int = 70;
	public var hp:Int = 10;
	var hpMax:Int = 60 * 10;
	var survMax:Int = 60 * 30;
	var attackRate:Int = 30;
	var str:Int = 1;
	var stunSet:Int = 40;
	var bSpeed:Int = 200;
	
	var surv:Int = 0;
	var attacking:Bool = false;
	var attackTime:Int = 0;
	var stun:Int = 0;
	
	var knife:FlxSprite;
	var gun:FlxSprite;
	
	var ammo:Int = 5;
	
	public function new(?X:Float = 0, ?Y:Float = 0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.crepe__png, true, 16, 18);
		var fps:Int = 8;
		//walk
		animation.add("wdown", [0, 1, 0, 2], fps, true);
		animation.add("wup", [3, 4, 3, 5], fps, true);
		animation.add("wright", [6, 7, 6, 8], fps, true);
		animation.add("wleft", [9, 10, 9, 11], fps, true);
		//attack
		animation.add("adown", [2], fps);
		animation.add("aup", [14], fps);
		animation.add("aleft", [12], fps);
		animation.add("aright", [13], fps);
		//idle
		animation.add("idown", [0], fps);
		animation.add("iup", [3], fps);
		animation.add("iright", [6], fps);
		animation.add("ileft", [9], fps);
		//hit
		animation.add("hdown", [15], fps);
		animation.add("hup", [16], fps);
		animation.add("hright", [17], fps);
		animation.add("hleft", [18], fps);
		
		animation.play("idown");
		
		hp = hpMax;
		surv = survMax;
		
		knife = new FlxSprite();
		knife.loadGraphic(AssetPaths.Knife__png);
		
		gun = new FlxSprite();
		gun.loadGraphic(AssetPaths.Knife__png);
		
		PlayState.crepeStuff.add(this);
		PlayState.crepeStuff.add(knife);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (!attacking && stun <= 0){
			FlxG.overlap(this, PlayState.enemies, takeDamage);
			FlxG.overlap(this, PlayState.bullets, bulletDamage);
		}
		if (stun >= 0){
			stun--;
			alpha = 0.5;
			if(stun>=20){
				super.update(elapsed);
				return;
			}
		}else{
			alpha = 1;
		}
		attack();
		fireGun();
		move();
		survival();
		animPick();
		FlxG.overlap(this, PlayState.pickups, pickuphandler);
		HUD.hpSet(hp/hpMax);
		super.update(elapsed);
	}
		
	function attack(){
		if (!PlayState.SWORD){
			return;
		}
		attackTime--;
		if (Ctrl.attack && attackTime <= 0){
			SoundPlayer.playsound("sword");
			knife.visible = true;
			velocity.x = velocity.y = 0;
			attackTime = attackRate;
			PlayState.crepeStuff.remove(this); PlayState.crepeStuff.remove(knife);
			switch(animation.name.substr(1)){
				case "up": knife.x = x + 10; knife.y = y - 6; animate("aup"); knife.angle = 0;
				PlayState.crepeStuff.add(knife); PlayState.crepeStuff.add(this);
				case "down": knife.x = x + 9; knife.y = y + 15; animate("adown"); knife.angle = 180;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(knife);
				case "left": knife.x = x - 8; knife.y = y + 6; animate("aleft"); knife.angle = 270;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(knife);
				case "right": knife.x = x + 20; knife.y = y + 7; animate("aright"); knife.angle = 90;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(knife);
			}
		}
		if (attackTime > 10){
			attacking = true;
		}
		if (attackTime <= 10 && attacking){
			knife.x = -90;
			knife.y = -90;
			attacking = false;
			knife.visible = false;
			switch(animation.name.substr(1)){
				case "up": animate("iup");
				case "down": animate("idown");
				case "left": animate("ileft");
				case "right": animate("iright");
			}
		}
		if (attacking){
			FlxG.overlap(knife, PlayState.enemies, damageEnemy);
			FlxG.overlap(this, PlayState.enemies, damageEnemy);
		}
	}
	
	function fireGun(){
		if (!PlayState.BULLETS){
			return;
		}
		attackTime--;
		if (Ctrl.special && attackTime <= 0 && ammo > 0){
			SoundPlayer.playsound("fire");
			ammo--;
			gun.visible = true;
			velocity.x = velocity.y = 0;
			attackTime = attackRate;
			PlayState.crepeStuff.remove(this); PlayState.crepeStuff.remove(gun);
			switch(animation.name.substr(1)){
				case "up": gun.x = x + 10; gun.y = y - 6; animate("aup"); gun.angle = 0;
				PlayState.crepeStuff.add(gun); PlayState.crepeStuff.add(this);
				var b:Bullet = new Bullet(gun.x, gun.y, 1, null, 0, -bSpeed);
				case "down": gun.x = x + 9; gun.y = y + 15; animate("adown"); gun.angle = 180;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(gun);
				var b:Bullet = new Bullet(gun.x, gun.y, 1, null, 0, bSpeed);
				case "left": gun.x = x - 8; gun.y = y + 6; animate("aleft"); gun.angle = 270;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(gun);
				var b:Bullet = new Bullet(gun.x, gun.y, 1, null, -bSpeed, 0);
				case "right": gun.x = x + 20; gun.y = y + 7; animate("aright"); gun.angle = 90;
				PlayState.crepeStuff.add(this); PlayState.crepeStuff.add(gun);
				var b:Bullet = new Bullet(gun.x, gun.y, 1, null, bSpeed, 0);
			}
		}
		if (attackTime > 10){
			attacking = true;
		}
		if (attackTime <= 10 && attacking){
			gun.x = -90;
			gun.y = -90;
			attacking = false;
			gun.visible = false;
			switch(animation.name.substr(1)){
				case "up": animate("iup");
				case "down": animate("idown");
				case "left": animate("ileft");
				case "right": animate("iright");
			}
		}
		if (attacking){
			FlxG.overlap(this, PlayState.enemies, damageEnemy);
		}
		HUD.ammoSet(ammo);
	}
	
	function move(){
		if (!PlayState.MOVE){
			return;
		}
		if (attacking){
			return;
		}
		velocity.x = 0;
		velocity.y = 0;
		if (Ctrl.right){
			velocity.x = speed;
		}
		if (Ctrl.left){
			velocity.x = -speed;
		}
		if (Ctrl.up){
			velocity.y = -speed;
		}
		if (Ctrl.down){
			velocity.y = speed;
		}
	}
	
	function survival(){
		if (!PlayState.SURVIVE){
			return;
		}
		surv -= 2;
		if (surv <= 0){
			hp--;
		}
		if (hp <= 0){
			loseHealth(5);
		}
		if (surv > survMax){
			surv = survMax;
		}
		HUD.survSet(surv/survMax);
	}
	
	function pickuphandler(p:Crepe, n:Pickup){
		switch(n.name){
			case "nom": 
				surv += cast(n, Nom).nomval;
				SoundPlayer.playsound("food");
			case "heart":
				hp += 60 * 2;
				if (hp > hpMax){
					hp = hpMax;
				}
				SoundPlayer.playsound("heart");
			case "ammo":
				ammo += 2;
				SoundPlayer.playsound("ammo");
		}
		n.kill();
		
	}
	
	function animPick(){
		if (attacking){
			return;
		}
		var walkpick:Bool = false;
		if (Ctrl.up && !walkpick){
			animate("wup");
			walkpick = true;
		}
		if (Ctrl.down && !walkpick){
			animate("wdown");
			walkpick = true;
		}
		if (Ctrl.right && !walkpick){
			animate("wright");
			walkpick = true;
		}
		if (Ctrl.left && !walkpick){
			animate("wleft");
			walkpick = true;
		}
		if (!walkpick){
			switch(animation.name){
				case "wright": animation.play("iright");
				case "wleft": animation.play("ileft");
				case "wup": animation.play("iup");
				case "wdown": animation.play("idown");
			}
		}
	}
	
	function animate(anim:String){
		if (animation.name != anim){
			animation.play(anim);
		}
	}
	
	function damageEnemy(p:FlxSprite, e:Enemy){
		e.damage(str);
	}
	
	function takeDamage(p:FlxSprite, e:Enemy){
		if (stun > 0||e.name=="mushroom"&&!PlayState.SWORD||e.name=="gun"&&!PlayState.BULLETS){
			return;
		}
		SoundPlayer.playsound("hit");
		stun = stunSet;
		animation.play("h"+animation.name.substr(1));
		var kb:Float = speed;
		if (getMidpoint().x < e.getMidpoint().x){
			velocity.x = -kb;
		}
		if (getMidpoint().x > e.getMidpoint().x){
			velocity.x = kb;
		}
		if (getMidpoint().y < e.getMidpoint().y){
			velocity.y = -kb;
		}
		if (getMidpoint().y > e.getMidpoint().y){
			velocity.y = kb;
		}
		loseHealth(e.str);
	}
	
	function bulletDamage(p:FlxSprite, e:Bullet){
		if (stun > 0||e.team==1){
			return;
		}
		stun = Math.round(stunSet*.5);
		animation.play("h"+animation.name.substr(1));
		var kb:Float = speed;
		if (getMidpoint().x < e.getMidpoint().x){
			velocity.x = -kb;
		}
		if (getMidpoint().x > e.getMidpoint().x){
			velocity.x = kb;
		}
		if (getMidpoint().y < e.getMidpoint().y){
			velocity.y = -kb;
		}
		if (getMidpoint().y > e.getMidpoint().y){
			velocity.y = kb;
		}
		e.kill();
		loseHealth(e.str);
	}
	
	public function loseHealth(damage:Int):Void
	{
		Utils.explode(getMidpoint().x, getMidpoint().y, 10, FlxColor.RED);
		hp -= damage;
		if (hp <= 0){
			FlxG.switchState(new DeadState());
		}
		HUD.hpSet(hp/hpMax);
	}
	
}