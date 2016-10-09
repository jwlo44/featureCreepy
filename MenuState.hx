package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	var prettyImage:FlxSprite;
	var blinkingText:FlxSprite;
	var timer:Int = 0;
	// I can't fix the key just pressed bug, so we'll just force you to wait a bit when the scene loads
	var wait:Int = 5;
	
	override public function create():Void
	{
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.titleScreenAnimation__png, true, 256, 144);
		prettyImage.animation.add("title", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10, true);
		prettyImage.animation.play("title");
		add(prettyImage);
		
		blinkingText = new FlxSprite();
		blinkingText.loadGraphic(AssetPaths.insertcoin__png);
		blinkingText.x = FlxG.width / 2 - blinkingText.width / 2;
		blinkingText.y = FlxG.height * 3 / 4;
		add(blinkingText);
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		timer = (timer + 1) % 20;
		if (timer == 0)
		{
			blinkingText.visible = !blinkingText.visible;
		}
		Ctrl.update();
				if (wait > 0)
		{
			wait--;
		}
		else if (Ctrl.anyJustPressed)
		{
		// go to play state
		FlxG.switchState(new PlayState());
		}
		super.update(elapsed);
	}
}
