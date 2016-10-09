package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class DDR extends FlxSprite 
{
	var speed:Int = -36;
	var timer:Float = 0;
	var timerMax:Float = 2;
	var textTime:Float = 0;
	var textTimeMax:Float = 1;
	var arrowIdx:Int = 0;
	var goodRange:Int = 5;
	var arrows:FlxTypedGroup<FlxSprite>;
	var textSpr:FlxSprite;
	// list of arrows
	// make one in new row
	// update y pos
	// if y is in range, watch input
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		visible = false;
	    arrows = new FlxTypedGroup<FlxSprite>();
		textSpr = new FlxSprite();
		textSpr.x = HUD.arrowX + 16;
		textSpr.y = HUD.arrowY + 16;
		PlayState.hud.add(textSpr);
	}
	override public function update(elapsed:Float):Void 
	{
		timer -= elapsed;
		if (timer < 0)
		{
			makeArrow();
			timer = timerMax;
		}
		
		if (textTime > 0)
		{
			textTime -= elapsed;
		}
		else
		{
			textSpr.visible = false;
		}
		
		// check arrows
		checkArrows();
	    super.update(elapsed);
	}
	private function makeArrow():Void
	{	
		// make an arrow at arrowIdx
		var arrow:FlxSprite = new FlxSprite(HUD.arrowX + arrowIdx * 16, FlxG.height - 16);
		arrow.loadGraphic(AssetPaths.DDRArrows__png, true, 16, 16);
		arrow.scrollFactor.set(0, 0);
		arrow.velocity.y = speed;
		arrow.animation.add("arrow " + arrowIdx, [arrowIdx], 1);
		arrow.animation.play("arrow " + arrowIdx);
		arrows.add(arrow);
		
		PlayState.hud.add(arrow);
		arrowIdx = (arrowIdx + 1) % 4;
	}
	
	private function checkArrows():Void
	{
		for (arrow in arrows)
		{
			// if we're in range for awesomeness...
			if (arrow.y <= HUD.arrowY + goodRange && arrow.y >= HUD.arrowY - goodRange)
			{
				// 0 up,1 left, 2 down, 3 right
				var arrowDir:Int = Math.floor((arrow.x - HUD.arrowX) / 16);
				var awesomeness:Bool = false;
				// and we're also hitting the right button...
				switch( arrowDir)
				{
					case 0: // up
						if (Ctrl.up)
						{
							awesomeness = true;
						}
					case 1: // left
						if (Ctrl.left)
						{
							awesomeness = true;
						}
					case 2: // down
						if (Ctrl.down)
						{
							awesomeness = true;
						}
					case 3: //right
						if (Ctrl.right)
						{
							awesomeness = true;
						}
				}
				if (awesomeness)
				{
					arrow.kill();
					arrows.remove(arrow);
					Utils.explode(arrow.x, arrow.y, 8, FlxColor.CYAN, false);
					// display awesome text
					showText(false);
				}
			}
			else if (arrow.y < HUD.arrowY - goodRange)
			{
				arrow.kill();
				arrows.remove(arrow);
				Utils.explode(textSpr.x, textSpr.y, 8, FlxColor.RED, false);
				// display bad text
				showText(true);
				// punch the crepe
				PlayState.crepe.loseHealth(60);
			}
		}
	}
	
	private function showText(isBad:Bool)
	{
		if (isBad)
		{
			textSpr.loadGraphic(AssetPaths.booText__png); 
			
		}
		else
		{
			textSpr.loadGraphic(AssetPaths.ExcellentDDRText__png);
		}	
		textTime = textTimeMax;
		textSpr.visible = true;
	}
	
}