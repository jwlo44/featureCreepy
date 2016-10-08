package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Nom extends FlxSprite
{

	public var nomval:Int = 60 * 10;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.nom__png);
		PlayState.noms.add(this);
	}
	
	override function kill(){
		PlayState.addNom(1);
		super.kill();
	}
	
}