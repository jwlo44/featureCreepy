package;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.effects.particles.FlxEmitter;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	public static var crepe:Crepe;
	
	public static var crepeStuff:FlxTypedGroup<FlxSprite>;
	public static var hud:FlxTypedGroup<FlxSprite>;
	public static var misc:FlxTypedGroup<FlxSprite>;
	public static var noms:FlxTypedGroup<Nom>;
	public static var enemies:FlxTypedGroup<Enemy>;
	public static var emitters:FlxTypedGroup<FlxEmitter>;
	
	public static var lvl:FlxTilemap;
	public static var walls:FlxTilemap;
	
	var lvlname:String = "test";
	
	override public function create():Void
	{	
		bgColor = 0xFF7E9E35;
		
		crepeStuff = new FlxTypedGroup<FlxSprite>();
		hud = new FlxTypedGroup<FlxSprite>();
		misc = new FlxTypedGroup<FlxSprite>();
		noms = new FlxTypedGroup<Nom>();
		enemies = new FlxTypedGroup<Enemy>();
		emitters = new FlxTypedGroup<FlxEmitter>();
		
		var n:Nom = new Nom(128, 60);
		
		FlxG.camera.follow(crepe, FlxCameraFollowStyle.TOPDOWN_TIGHT);
		
		var load:FlxOgmoLoader = new FlxOgmoLoader("assets/data/" + lvlname + ".oel");
		lvl = load.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		walls = load.loadTilemap(AssetPaths.walls__png, 8, 8, "walls");
		load.loadEntities(placeEntities, "entities");
		walls.visible = false;
		
		FlxG.worldBounds.set(0, 0, lvl.width, lvl.height); //set world bounds to the size of the level so collisions work
		FlxG.camera.setScrollBounds(0, lvl.width, 0, lvl.height);
		
		add(lvl);
		add(walls);
		add(misc);
		add(crepeStuff);
		add(enemies);
		add(noms);
		add(emitters);
		add(hud);
		
		add(new HUD());
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		FlxG.collide(crepe, walls);
		FlxG.collide(enemies, walls);
		super.update(elapsed);
	}
	
	public static function addNom(c:Int){
		for (i in 0...c){
			var n:Nom = new Nom(Math.round(Math.random() * 16) * 16, Math.round(Math.random() * 9) * 16);
			noms.add(n);
		}
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void //places entities everywhere
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		switch(entityName){
			case "player":
				crepe = new Crepe(x, y);
			case "mushroom":
				var m:Mushroom = new Mushroom(x, y);
		}
	}
}
