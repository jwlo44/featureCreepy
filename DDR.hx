package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class DDR extends FlxSprite 
{
	var speed:Int = -25;
	var timer:Float = 0;
	var timerMax:Float = 10;
	var arrowIdx:Int = 0;
	var arrows:FlxTypedGroup<FlxSprite>;
	// list of arrows
	// make one in new row
	// update y pos
	// if y is in range, watch input
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		visible = false;
	    arrows = new FlxTypedGroup<FlxSprite>();
	}
	override public function update(elapsed:Float):Void 
	{
		timer -= elapsed;
		if (timer < 0)
		{
			makeArrow();
			timer = timerMax;
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
		trace("made arrow at " + arrow.x + ", " + arrow.y);
		arrowIdx = (arrowIdx + 1) % 4;
	}
	
	private function checkArrows():Void
	{
		for (arrow in arrows)
		{
			// if we're in range for awesomeness...
			if (arrow.y <= 3 && arrow.y >= -3)
			{
				trace("arrow in range");
				// 0 up,1 left, 2 down, 3 right
				var arrowDir:Int = Math.floor((arrow.x - 132) / 16);
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
					trace("yay!");
					arrow.kill();
					// display awesome text
				}
			}
			else if (arrow.y < -3)
			{
				arrow.kill();
				arrows.remove(arrow);
				trace("booo!");
				// display bad text
			}
		}
	}
	
}