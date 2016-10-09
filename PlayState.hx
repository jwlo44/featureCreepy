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
	
	static var russ:FlxSprite;
	
	var lvlname:String = "test";
	
	public static var ustate:String = "";
	
	public var feature:FlxSprite;
	
<<<<<<< HEAD
	public static var MOVE:Bool = false;
	public static var SURVIVE:Bool = false;
	public static var SWORD:Bool = false;
	public static var BULLETS:Bool = false;
	public static var STATS:Bool = false;
	public static var WALRUS:Bool = false;
=======
	public static var MOVE:Bool = true;
	public static var SURVIVE:Bool = true;
	public static var SWORD:Bool = true;
	public static var BULLETS:Bool = true;
	public static var STATS:Bool = true;
	public static var WALRUS:Bool = true;
	public static var walrusTime = false;
>>>>>>> 6d61efd34d28e167cdd7f84832bfb1433d2553f3
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
		
		addNom();
		addNom();
		addNom();
		
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
		
		dclear = true;
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		Ctrl.update();
		FlxG.collide(crepe, walls);
		FlxG.collide(enemies, walls);
		if (walrusTime)
		{FlxG.collide(crepe, russ);}

		upgrade();
<<<<<<< HEAD
		dlg();
=======
		checkWalrus();
>>>>>>> 6d61efd34d28e167cdd7f84832bfb1433d2553f3
		super.update(elapsed);
	}
	
	private static function checkWalrus()
	{
		if (WALRUS && Date.now().getHours() <= 12 && !walrusTime)
		{
			russ = new FlxSprite(160, 160);
			russ.loadGraphic(AssetPaths.russWiggle__png, true, 40, 32);
			russ.animation.add("wiggle", [0, 1], 2);
			russ.animation.play("wiggle");
			russ.immovable = true;
			misc.add(russ);
			walrusTime = true;
		}
		if (walrusTime && Date.now().getHours() >= 12)
		{
			walrusTime = false;
			russ.kill();
		}
	}
	
	public static function addNom(c:Int=1){
		var ncount:Int = 0;
		for (i in pickups){
			if (i.name=="nom"){
				ncount++;
			}
		}
		if (ncount > 3){
			return;
		}
		var n:Nom = new Nom(Math.round(Math.random() * (lvl.width/16)) * 16, Math.round(Math.random() * (lvl.height/16)) * 16);
		pickups.add(n);
		var tx:Int = Math.round((n.x) / 8);
		var ty:Int = Math.round((n.y) / 8);
		if (walls.getTile(tx, ty) == 1 || n.x+n.width > lvl.width || n.y+n.height > lvl.height || n.x < 0 || n.y < 0){
			addNom(1);
			n.kill();
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
				dclear = true;
				dtick = 1;
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
				HUD.showText("New Feature: Avoid the bullets! Press X to shoot.");
				BULLETS = true;
			case 5:
				HUD.showText("New Feature: Track your stats!");
				HUD.show("stats");
				STATS = true;
			case 6:
				HUD.showText("New Feature: Find the walrus between 12 AM - 12 PM");
				WALRUS = true;
			case 7:
				HUD.showText("New Feature: Dance Dance Dance!");
				HUD.show("dance");
				DANCE = true;
		}
		//var g:Glitch = new Glitch();
	}
	
	public static function addEnemy(name:String){
		var c:Int = 0;
		for (i in enemies){
			if (i.name == name){
				c++;
			}
		}
		if (c > 3){
			return;
		}
		var n:Enemy = new Enemy(0,0);
		var x:Float = Math.round(Math.random() * (lvl.width/8)) * 16;
		var y:Float = Math.round(Math.random() * (lvl.height/8)) * 16;
		switch(name){
			case "mushroom": n = new Mushroom(x, y);
			case "gun": n = new Gun(x, y);
		}
		var tx:Int = Math.round((n.x) / 8);
		var ty:Int = Math.round((n.y) / 8);
		if (walls.getTile(tx, ty) == 1 || n.x+n.width > lvl.width || n.y+n.height > lvl.height || n.x < 0 || n.y < 0){
			addEnemy(name);
			n.kill();
		}
	}
	
	var dtick:Int = -1;
	var dphase:Int = 0;
	static var dclear:Bool = false;
	public function dlg(){
		if(dclear){
			dtick++;
		}
		if (dtick % 180 == 0){
			dphase++;
			var t:String = "";
			switch(dphase){
				case 1: t = "Okay so we got a character, right?";
				case 2: t = "Yea, uh, what do they do? Move? Uh. Okay.";
				case 3: t = "glitch";
				case 4: t = "1";
				case 5: t = "2";
				case 6: t = "glitch";
				case 7: t = "1";
				case 8: t = "2";
				case 9: t = "glitch";
				case 10: t = "1";
				case 11: t = "2";
				case 12: t = "glitch";
				case 13: t = "1";
				case 14: t = "2";
				case 15: t = "glitch";
				case 16: t = "1";
				case 17: t = "2";
				case 18: t = "glitch";
				case 19: t = "1";
				case 20: t = "2";
				case 21: t = "glitch";
				case 22: t = "1";
				case 23: t = "2";
				case 24: t = "glitch";
				case 25: t = "1";
				case 26: t = "2";
				case 28: t = "glitch";
			}
			if (t == "glitch"){
				dtick = 1;
				var g:Glitch = new Glitch(0, 0);
				dclear = false;
			}else{
				HUD.showText(t);
			}
		}
	}
}
