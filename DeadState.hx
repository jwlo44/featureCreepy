package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class DeadState extends FlxState
{
	var prettyImage:FlxSprite;
	var blinkingText:FlxSprite;
	var timer:Int = 0;
	var wait:Int = 5;
	override public function create():Void
	{
		camera.fade(FlxColor.BLACK, 3, true);
		SoundPlayer.stopMusic();
		SoundPlayer.playsound("gameover");
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.deadScreenAnimation__png, true, 256, 144);
		prettyImage.animation.add("dead", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 7, true);
		prettyImage.animation.play("dead");
		add(prettyImage);
		
		blinkingText = new FlxSprite();
		blinkingText.loadGraphic(AssetPaths.dead_pressKey__png);
		blinkingText.x = FlxG.width / 2 - blinkingText.width / 2;
		blinkingText.y = FlxG.height * 4 / 5;
		add(blinkingText);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		timer = (timer + 1) % 20;
		if (timer == 0)
		{
			blinkingText.visible = !blinkingText.visible;
		}
		if (wait > 0)
		{
			wait--;
		}
		else if (Ctrl.jattack)
		{
			// go to menu state
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}
}
