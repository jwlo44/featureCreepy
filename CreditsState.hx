package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class CreditsState extends FlxState
{
	var prettyImage:FlxSprite;
	var wait:Int = 5;
	var trashImg:FlxSprite;
	override public function create():Void
	{
		prettyImage = new FlxSprite();
		prettyImage.loadGraphic(AssetPaths.creditsAnimation__png, true, 256, 144);
		prettyImage.animation.add("credits", [0, 0, 1, 1, 2, 2, 3, 3], 1, true);
		prettyImage.animation.play("credits");
		add(prettyImage);
		
		trashImg = new FlxSprite(-20, -20);
		trashImg.loadGraphic(AssetPaths.oldCrepeTrash__png);
		trashImg.velocity.x = 3;
		trashImg.velocity.y = 5;
		add(trashImg);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		trashImg.x %= FlxG.width + 20;
		trashImg.y %= FlxG.height + 20;
		if (wait > 0)
		{
			wait--;
		}
		else if (Ctrl.anyJustPressed)
		{
			// go to menu state
			FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}
}
