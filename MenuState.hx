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
	override public function create():Void
	{
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.titleScreenAnimation__png, true, 256, 144);
		prettyImage.animation.add("title", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 10, true);
		prettyImage.animation.play("title");
		add(prettyImage);
		super.create();
	}
	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
	if (Ctrl.anyJustPressed )
	{
		// go to play state
		FlxG.switchState(new PlayState());
	}
		super.update(elapsed);
	}
}
