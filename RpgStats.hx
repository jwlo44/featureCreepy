package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;

/**
 * ...
 * @author ...
 */
class RpgStats extends FlxSprite 
{
	private var squanch:Float;
	private var walrus:Bool = false;
	private var strengrth:Int = 1;
	private var Z:Int;
	private var text:FlxText;
	public static var textX:Float;
	public static var textY:Float = 16;
	private var score:Int = 0;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		visible = false;
		textX = FlxG.width * 2 / 3;
		text = new FlxText(textX, textY);
		text.scrollFactor.set(0, 0);
		PlayState.hud.add(text);
		super(X, Y);
	}
	override public function update(elapsed:Float):Void 
	{
		squanch = (Math.fround((Z / Math.PI + 7.11 + PlayState.bullets.countLiving()) * PlayState.crepe.health / 6 * 1000))%10000;
		if (Ctrl.jattack)
		{
			Z++;
		}
		walrus = PlayState.WALRUS;
		updateText();
		super.update(elapsed);
	}
	private function updateText()
	{
		text.text = 
		"Strengrth: " + strengrth 
		+ "\nSquanch: " + squanch
		+ "\nWalrus: " + walrus
		+ "\nZ: " + Z
		+ "\nscore: " + score++;
	}
	
}