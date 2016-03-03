/**
 * collider class
 */
 
 // Lava class 
 class Lava {

  // Liquid is a rectangle
  float x,y,w,h;
  // Coefficient of drag
  float c;

  Lava(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  // Is the Mover in the Lava?
  boolean contains(Mover m) {
    PVector l = m.location;
    if (l.x > x && l.x < x + w && l.y > y && l.y < y + h) {
      return true;
    }  
    else {
      return false;
    }
  }
  
  // Calculate drag force
  PVector drag(Mover m) {
    if (m.moving) {
      // Magnitude is coefficient * speed squared
      float speed = m.velocity.mag();
      float dragMagnitude = c * speed * speed;
  
      // Direction is inverse of velocity
      PVector drag = m.velocity.copy();
      drag.mult(-1);
      
      // Scale according to magnitude
      drag.setMag(dragMagnitude);
      return drag;
    }
    else 
      return new PVector(0,0);
  }
  
  void display() {
    //noStroke();
    //fill(orange);
    //rect(x,y,w,h);
  }

}