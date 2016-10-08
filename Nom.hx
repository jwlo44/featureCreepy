package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Nom extends Pickup
{

	public var nomval:Int = 60 * 10;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		name = "nom";
		loadGraphic(AssetPaths.nom__png);
		PlayState.pickups.add(this);
	}
	
	override function kill(){
		PlayState.addNom(1);
		super.kill();
	}
	
}