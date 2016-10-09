package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class DeadState extends FlxState
{
	var prettyImage:FlxSprite;
	override public function create():Void
	{
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.deadScreenAnimation__png, true, 256, 144);
		prettyImage.animation.add("dead", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 30, true);
		prettyImage.animation.play("dead");
		add(prettyImage);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		if (Ctrl.anyJustPressed)
		{
			// go to menu state
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}
}
