package;

import flixel.FlxSprite;
import flixel.addons.text.FlxTextField;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.debug.stats.Stats;
import flixel.text.FlxText;
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
	static var bottom:FlxSprite;
	static var bText:FlxText;
	static var ammo:FlxSprite;
	static var aText:FlxText;
	
	public static var arrowX:Int = 0;
	public static var arrowY:Int = 16;
	static var ddr:DDR;
	static var stats:RpgStats;
	
	static var arrows:FlxTypedGroup<FlxSprite>;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		visible = false;
		
		block = new FlxSprite();
		block.makeGraphic(FlxG.width, 12, FlxColor.BLACK);
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
		survEmpty.visible = false;
		
		surv = new FlxSprite(0, 3);
		surv.makeGraphic(48, 6, 0xFFFF9900);
		surv.scrollFactor.set(0, 0);
		surv.visible = false;
		
		bottom = new FlxSprite(0, 144 - 16);
		bottom.makeGraphic(FlxG.width, 16, FlxColor.BLACK);
		bottom.scrollFactor.set(0, 0);
		bottom.visible = false;
		
		bText = new FlxText(bottom.x, bottom.y);
		bText.text = "He's just standing there, menacingly!";
		bText.scrollFactor.set(0, 0);
		bText.visible = false;
		
		ammo = new FlxSprite(survEmpty.width*2 + 8, 3);
		ammo.loadGraphic(AssetPaths.ammocount__png);
		ammo.scrollFactor.set(0, 0);
		ammo.visible = false;
		
		aText = new FlxText(ammo.x + ammo.width + 2, -1);
		aText.text = "x5";
		aText.scrollFactor.set(0, 0);
		aText.visible = false;
		
		PlayState.hud.add(block);
		PlayState.hud.add(hp);
		PlayState.hud.add(hpEmpty);
		PlayState.hud.add(surv);
		PlayState.hud.add(survEmpty);
		PlayState.hud.add(bottom);
		PlayState.hud.add(bText);
		PlayState.hud.add(ammo);
		PlayState.hud.add(aText);
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
	
	public static function ammoSet(set:Int){
		aText.text = "x" + set;
	}
	
	static var bTick:Int = 0;
	
	public static function showText(s:String){
		bottom.visible = true;
		bText.visible = true;
		bText.text = s;
		bTick = 160;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if(PlayState.DANCE && ddr!=null){
			ddr.update(elapsed);
		}
		if(PlayState.STATS && stats!=null){
			stats.update(elapsed);
		}
		bTick--;
		if (bTick < 0){
			bText.visible = false;
			bottom.visible = false;
		}
		super.update(elapsed);
	}
	
	public static function show(s:String){
		switch(s){
			case "surv":
				surv.visible = true;
				survEmpty.visible = true;
			case "dance":
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
				for (a in arrows)
				{
					PlayState.hud.add(a);
				}
				ddr = new DDR();
			case "gun":
				ammo.visible = true;
				aText.visible = true;
			case "stats":
				stats = new RpgStats();	
		}
	}
	
}