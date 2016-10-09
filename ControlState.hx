package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class ControlState extends FlxState
{
	var prettyImage:FlxSprite;
	var wait:Int = 5;
	override public function create():Void
	{
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.controlScreenTilesheet__png, true, 256, 144);
		prettyImage.animation.add("controls", [0, 1, 2, 3], 5, true);
		prettyImage.animation.play("controls");
		add(prettyImage);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		if (wait > 0)
		{
			wait--;
		}
		else if (Ctrl.anyJustPressed)
		{
			// go to menu state
			FlxG.switchState(new PlayState());
		}
		super.update(elapsed);
	}
}
