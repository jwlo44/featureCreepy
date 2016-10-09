package;

import flixel.addons.display.FlxSliceSprite;
import flixel.math.FlxRect;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class RpgStats extends FlxSliceSprite 
{

	public function new(Graphic:FlxGraphicAsset, SliceRect:FlxRect, Width:Float, Height:Float) 
	{
		visible = false;
		super(Graphic, SliceRect, Width, Height);
		
	}
	
}