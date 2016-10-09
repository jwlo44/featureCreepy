package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Nom extends Pickup
{

	public var nomval:Int = 60 * 12;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		name = "nom";
		loadGraphic(AssetPaths.nom__png);
		PlayState.pickups.add(this);
		visible = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (PlayState.SURVIVE){
			visible = true;
		}
		super.update(elapsed);
	}
	
	override function kill(){
		PlayState.addNom(1);
		PlayState.pickups.remove(this, true);
		super.kill();
	}
	
}