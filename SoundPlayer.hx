package;
import flixel.FlxG;
import flixel.system.FlxSound;
/**
 * ...
 * @author ...
 */
class SoundPlayer
{
	static var mute:Bool = false;
	public function new() 
	{
	}
	
	public static function music(name:String) {
		if (mute) {
			return;
		} 
		FlxG.sound.playMusic("assets/music/"+name+".mp3", 1, true);
	}
	
	public static function stopMusic() {
		FlxG.sound.pause();
	}
	
	public static function playsound(name:String) {
		if (mute) {
			return;
		}
		var sound:FlxSound = FlxG.sound.load("assets/sounds/" + name+".wav");
		sound.play();
	}
	
}