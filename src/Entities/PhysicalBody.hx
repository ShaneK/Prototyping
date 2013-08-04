package entities;
 
import com.haxepunk.Entity;
import nape.phys.Body;

class PhysicalBody extends Entity
{
	private var body:Body;

    public function new(x:Int, y:Int, r = 5, mass = 0.1)
    {
        super(x, y);
    }

    public function getBody(){
    	return body;
    }
}