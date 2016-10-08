package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class HUD extends FlxSprite
{
	static var block:FlxSprite;
	static var hpEmpty:FlxSprite;
	static var hp:FlxSprite;
	static var survEmpty:FlxSprite;
	static var surv:FlxSprite;
	public static var arrowX:Int = 0;
	public static var arrowY:Int = 16;
	var ddr:DDR;
	
	static var arrows:FlxTypedGroup<FlxSprite>;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		ddr = new DDR();
		
		visible = false;
			
		block = new FlxSprite();
		block.makeGraphic(FlxG.width, 16, FlxColor.BLACK);
		block.scrollFactor.set(0, 0);
		
		hpEmpty = new FlxSprite(2, 2);
		hpEmpty.loadGraphic(AssetPaths.hpbar__png);
		hpEmpty.scrollFactor.set(0, 0);
		
		hp = new FlxSprite(0, 3);
		hp.makeGraphic(48, 6, FlxColor.RED);
		hp.scrollFactor.set(0, 0);
		
		survEmpty = new FlxSprite(hpEmpty.width + 5, 2);
		survEmpty.loadGraphic(AssetPaths.survivalbar__png);
		survEmpty.scrollFactor.set(0, 0);
		
		surv = new FlxSprite(0, 3);
		surv.makeGraphic(48, 6, 0xFFFF9900);
		surv.scrollFactor.set(0, 0);
		
		arrows = new FlxTypedGroup<FlxSprite>();
		var i:Int = 0;
		while ( i < 4)
	    {
			var spr:FlxSprite = new FlxSprite(arrowX + i*16, arrowY);
			spr.loadGraphic(AssetPaths.DDRArrows__png, true, 16, 16);
			spr.scrollFactor.set(0, 0);
			spr.animation.add("arrow " + i, [4 + i], 1);
			spr.animation.play("arrow " + i);
			arrows.add(spr);
			i++;
		}
		
		PlayState.hud.add(block);
		PlayState.hud.add(hp);
		PlayState.hud.add(hpEmpty);
		PlayState.hud.add(surv);
		PlayState.hud.add(survEmpty);
		for (a in arrows)
		{PlayState.hud.add(a); }
	}
	
	public static function hpSet(set:Float){
		if (set > 0.01){
			hp.visible = true;
			hp.setGraphicSize(Math.round(set * 48), Math.round(hp.height));
			hp.x = Math.round(set * 48) / 2 - 12;
		}else{
			hp.visible = false;
		}
	}
	
	public static function survSet(set:Float){
		if (set > 0.01){
			surv.visible = true;
			surv.setGraphicSize(Math.round(set * 48), Math.round(surv.height));
			surv.x = Math.round(set * 48) / 2 + 50;
		}else{
			surv.visible = false;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		ddr.update(elapsed);
		super.update(elapsed);
	}
	
}