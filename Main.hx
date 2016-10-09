package;

import flixel.FlxGame;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var flash:Bool = false;
	
	public function new()
	{
		super();
		#if flash
		flash = true;
		#end
		addChild(new FlxGame(256, 144, CreditsState, 1, 60, 60, true, false));
	}
}
