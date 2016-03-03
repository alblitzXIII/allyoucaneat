/**
 * collider class
 */
 
 class Collider {

  // rectangle
  float x,y,w,h;

  Collider(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
  // Is the Mover in the Lava?
  boolean contains(Mover m) {
    PVector l = m.location;
    println("x="+ x + " y=" + y + " w=" + w + " h=" + h + " -- " + "mx="+ l.x + " my=" + l.y);  

    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      println("contained");
      return true;
    }  
    else {
      return false;
    }
  }
  
}