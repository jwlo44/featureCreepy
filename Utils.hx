package;

import flixel.FlxObject;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Utils
{

	public function new() 
	{
		
	}
	
	public static function distance(P1:FlxPoint, P2:FlxPoint):Float //gets distance between two points
	{
		var XX:Float = P2.x - P1.x;
		var YY:Float = P2.y - P1.y;
		return Math.sqrt( XX * XX + YY * YY );
	}
	
	public static function explode(x:Float = 0, y:Float = 0, count:Int = 10, color:Int = FlxColor.WHITE) //makes an explosion, defaults to white pixels
	{
		var e:FlxEmitter = new FlxEmitter(x, y);
		for (i in 0...count){
			var p:FlxParticle = new FlxParticle();
			p.makeGraphic(2, 2, color);
			
			p.velocity.x = p.velocity.x * 3;
			p.velocity.y = p.velocity.y * 3;
			p.elasticity = 0.3;
			
			e.add(p);
		}
		
		PlayState.emitters.add(e);
		
		e.allowCollisions = FlxObject.ANY;
		e.acceleration.set(0,300,0,300);
		e.speed.set( -200, -200, 200, 200);
		e.start();
	}
}