package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Glitch extends FlxSprite
{
	var target:FlxSprite;
	var tracking:Bool = false;
	var speed:Int = 80;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.glitch__png, true, 16, 16);
		animation.add("glitchy", [0, 1, 2, 3, 4, 5], 8);
		animation.play("glitchy");
		PlayState.misc.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{	
		target = PlayState.crepe;
		var blind:Int = 0;
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
		if (FlxG.overlap(this, PlayState.crepe)){
			PlayState.ustate = "ustart";
			Utils.explode(x, y, 30, FlxColor.BLUE);
			SoundPlayer.playsound("glitch");
			kill();
		}
		super.update(elapsed);
	}
	
}