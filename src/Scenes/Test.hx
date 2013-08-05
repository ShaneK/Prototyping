package scenes;

import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
 
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.space.Space;
import nape.util.BitmapDebug;
import nape.util.Debug;
import nape.phys.Material;


class Test extends Scene
{
    private var space:Space;
    private var floor:Entity;
    private var floorBody:Body;
    private var dragging:entities.Circle;

    public function new()
    {
        super();
        var gravity:Vec2 = new Vec2(0, 300); // units are pixels/second/second
        space = new Space(gravity);

        var floor = new entities.Block(0, HXP.height, HXP.width, 1);
        addObjectToSpace(floor);

        var leftWall = new entities.Block(-1, 0, 1, HXP.height);
        addObjectToSpace(leftWall);

        var rightWall = new entities.Block(HXP.width+1, 0, 1, HXP.height);
        addObjectToSpace(rightWall);

        for(i in 0...200){
            var circle = new entities.Circle(Math.floor(HXP.width * HXP.random), Math.floor(HXP.height * HXP.random), Math.ceil(15*HXP.random), Math.ceil(5*HXP.random));
            addObjectToSpace(circle);
        }

        for(k in 0...3){
            var block = new entities.Block(Math.floor(HXP.width * HXP.random), Math.floor(HXP.height * HXP.random), 80, 20);
            addObjectToSpace(block);
        }
    }
    
    public function addObjectToSpace(e:entities.PhysicalBody){
        add(e);
        space.bodies.add(e.getBody());
    }

    public override function begin()
    {

    }
 
    public override function update()
    {
        if(HXP.elapsed > 0){
            space.step(HXP.elapsed);
        }

        if(Input.mousePressed){
            var collision = collidePoint("circle", Input.mouseX, Input.mouseY);
            if(collision != null){
                var circle = cast(collision, entities.Circle);
                dragging = circle;
            }else{
                var circle = new entities.Circle(Math.floor(Input.mouseX), Math.floor(Input.mouseY), Math.ceil(15*HXP.random), Math.ceil(5*HXP.random));
                addObjectToSpace(circle);
                dragging = circle;
            }
        }

        if(dragging != null){
            dragging.setXY(Input.mouseX, Input.mouseY);
        }

        if(Input.mouseReleased){
            dragging = null;
        }

        super.update();
    }
 
}