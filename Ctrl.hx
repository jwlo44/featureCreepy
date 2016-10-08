package;
import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;

/**
 * ...
 * @author ...
 */
class Ctrl
{
	
	//attack/special
	public static var attack:Bool = false;
	public static var special:Bool = false;
	//just pressed
	public static var jattack:Bool = false;
	public static var jspecial:Bool = false;
	//just released
	public static var rattack:Bool = false;
	public static var rspecial:Bool = false;
	//directions
	public static var left:Bool = false;
	public static var right:Bool = false;
	public static var up:Bool = false;
	public static var down:Bool = false;
	//misc
	public static var pause:Bool = false;
	public static var map:Bool = false;
	
	public function new() 
	{
	}
	
	public static function update(){
		attack = FlxG.keys.anyPressed(["Z"]);
		special = FlxG.keys.anyPressed(["X"]);
		jattack = FlxG.keys.anyJustPressed(["Z"]);
		jspecial = FlxG.keys.anyJustPressed(["X"]);
		rattack = FlxG.keys.anyJustReleased(["Z"]);
		rspecial = FlxG.keys.anyJustReleased(["X"]);
		up = FlxG.keys.anyPressed(["UP"]);
		down = FlxG.keys.anyPressed(["DOWN"]);
		left = FlxG.keys.anyPressed(["LEFT"]);
		right = FlxG.keys.anyPressed(["RIGHT"]);
		pause = FlxG.keys.anyJustPressed(["P"]);
		map = FlxG.keys.anyJustPressed(["SPACE"]);
		altcontrol();
	}
	
	public static function altcontrol() {
		var gp:FlxGamepad = FlxG.gamepads.lastActive;
		if (gp == null) {
			return;
		}
		gp.deadZone = .5;
		right = right || gp.analog.value.LEFT_STICK_X>0 || gp.anyJustPressed([FlxGamepadInputID.DPAD_RIGHT]);
		up = up || gp.analog.value.LEFT_STICK_Y<0 || gp.anyJustPressed([FlxGamepadInputID.DPAD_UP]);
		left = left || gp.analog.value.LEFT_STICK_X < 0 || gp.anyJustPressed([FlxGamepadInputID.DPAD_LEFT]);
		down = down || gp.analog.value.LEFT_STICK_Y > 0 || gp.anyJustPressed([FlxGamepadInputID.DPAD_DOWN]);
		pause = pause || gp.anyJustPressed([FlxGamepadInputID.START]);
		map = map || gp.anyJustPressed([FlxGamepadInputID.BACK]);
		
		attack = attack || gp.anyPressed([FlxGamepadInputID.A]);
		jattack = jattack || gp.anyJustPressed([FlxGamepadInputID.A]);
		rattack = rattack || gp.anyJustReleased([FlxGamepadInputID.A]);
		
		special = special || gp.anyPressed([FlxGamepadInputID.X]);
		jspecial = jspecial || gp.anyJustPressed([FlxGamepadInputID.X]);
		rspecial = rspecial || gp.anyJustReleased([FlxGamepadInputID.X]);
	}
}