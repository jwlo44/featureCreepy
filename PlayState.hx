package;

import flixel.FlxCamera;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.effects.chainable.FlxGlitchEffect.FlxGlitchDirection;
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
	public static var pickups:FlxTypedGroup<Pickup>;
	public static var enemies:FlxTypedGroup<Enemy>;
	public static var emitters:FlxTypedGroup<FlxEmitter>;
	public static var bullets:FlxTypedGroup<Bullet>;
	
	public static var lvl:FlxTilemap;
	public static var walls:FlxTilemap;
	
	var lvlname:String = "test";
	
	public static var ustate:String = "";
	
	public var feature:FlxSprite;
	
	public static var MOVE:Bool = false;
	public static var SURVIVE:Bool = false;
	public static var SWORD:Bool = false;
	public static var BULLETS:Bool = false;
	public static var STATS:Bool = false;
	public static var WALRUS:Bool = false;
	public static var DANCE:Bool = false;
	
	override public function create():Void
	{	
		ustate = "";
		
		bgColor = 0xFF7E9E35;
		
		crepeStuff = new FlxTypedGroup<FlxSprite>();
		hud = new FlxTypedGroup<FlxSprite>();
		misc = new FlxTypedGroup<FlxSprite>();
		pickups = new FlxTypedGroup<Pickup>();
		enemies = new FlxTypedGroup<Enemy>();
		emitters = new FlxTypedGroup<FlxEmitter>();
		bullets = new FlxTypedGroup<Bullet>();
		
		var n:Nom = new Nom(128, 60);
		
		
		var load:FlxOgmoLoader = new FlxOgmoLoader("assets/data/" + lvlname + ".oel");
		lvl = load.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		walls = load.loadTilemap(AssetPaths.walls__png, 8, 8, "walls");
		load.loadEntities(placeEntities, "entities");
		walls.visible = false;
		
		FlxG.camera.follow(crepe, FlxCameraFollowStyle.TOPDOWN_TIGHT);
		FlxG.worldBounds.set(0, 0, lvl.width, lvl.height); //set world bounds to the size of the level so collisions work
		FlxG.camera.setScrollBounds(0, lvl.width, 0, lvl.height);
			
		feature = new FlxSprite(-192, -108);
		feature.scrollFactor.set(0, 0);
		feature.loadGraphic(AssetPaths.newfeature__png, true, 640, 360);
		feature.animation.add("stuff", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 23], 18, false);
		feature.scale.set(0.4, 0.4);
		feature.visible = false;
		
		add(lvl);
		add(walls);
		add(misc);
		add(crepeStuff);
		add(enemies);
		add(pickups);
		add(emitters);
		add(bullets);
		add(hud);
		add(feature);
		
		add(new HUD());
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		FlxG.collide(crepe, walls);
		FlxG.collide(enemies, walls);
		upgrade();
		super.update(elapsed);
	}
	
	public static function addNom(c:Int){
		for (i in 0...c){
			var n:Nom = new Nom(Math.round(Math.random() * 16) * 16, Math.round(Math.random() * 9) * 16);
			pickups.add(n);
			var tx:Int = Math.round((n.x) / 16);
			var ty:Int = Math.round((n.y) / 16);
			if (walls.getTile(tx, ty) == 1 || n.x+n.width > lvl.width || n.y+n.height > lvl.height || n.x < 0 || n.y < 0){
				addNom(1);
				n.destroy();
			}
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
			case "gun":
				var g:Gun = new Gun(x, y);
			case "glitch":
				var g:Glitch = new Glitch(x, y);
		}
	}
	
	function upgrade(){
		switch(ustate){
			case "ustart":
				feature.animation.play("stuff");
				feature.visible = true;
				ustate = "uwait";
			case "uwait":
				if (feature.animation.finished){
					ustate = "utext";
					feature.visible = false;
					camera.flash();
				}
			case "utext":
				newFeature();
				ustate = "";
		}
	}
	
	var fcount:Int = 0;
	
	function newFeature(){
		fcount++;
		switch(fcount){
			case 1:
				HUD.showText("New Feature: Move around with arrow keys");
				MOVE = true;
			case 2:
				HUD.showText("New Feature: Collect food to survive");
				HUD.show("surv");
				SURVIVE = true;
			case 3:
				HUD.showText("New Feature: Swing your sword with Z");
				SWORD = true;
			case 4:
				HUD.showText("New Feature: Avoid the bullets!");
				BULLETS = true;
			case 5:
				HUD.showText("New Feature: Track your stats!");
				HUD.show("stats");
				STATS = true;
			case 6:
				HUD.showText("New Feature: Find the walrus between 6 AM - 12 PM");
				WALRUS = true;
			case 7:
				HUD.showText("New Feature: Dance Dance Dance!");
				HUD.show("arrows");
				DANCE = true;
		}
		var g:Glitch = new Glitch();
	}
}
