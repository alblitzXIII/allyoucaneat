/**
 * Things that fall from the sky
 */

HashMap<String, PImage[]> sheetMap;
HashMap<String, Integer> sheetDimensions;
HashMap<String, Integer> sheetDurationsMs;
HashMap<String, Integer> sheetColumns;

void setSpriteSheet(String type, PImage[] imgs, int dim, int durationMs, int columns) {
    sheetMap.put(type, imgs);
    sheetDimensions.put(type, dim);
    sheetDurationsMs.put(type, durationMs);
    sheetColumns.put(type, columns);
}

class Mover {
  String type;
  PImage img;
  boolean facingLeft;
  
  // location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector hitbox;
  
  boolean active;
  boolean moving;
  boolean isFalling;
  boolean isAnimated;
  boolean isPlayer;
  String animState;
  int animDuration;
  int animStartTime;
  int timeIntoAnim;
  
  SmokeParticleSystem sps;
  ExplosionParticleSystem eps;
  
  float mass;

  Mover(String t, PVector hb, float m, float x, float y, PVector vel, PImage staticImg) {
    type = t;
    hitbox = hb;
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(vel.x, vel.y);
    acceleration = new PVector(0, 0);
    active = true;
    moving = active;
    facingLeft = true;
    isAnimated = false;
    isFalling = true;
    isPlayer = false;
    img = staticImg;
    if (type=="meteor") {
      sps = new SmokeParticleSystem(300);
      eps = new ExplosionParticleSystem(150);
    }

    
  }

  // Newton's 2nd law: F = M * A
  // or A = F / M
  void applyForce(PVector force) {
    // Divide by mass 
    PVector f = PVector.div(force, mass);
    // Accumulate all forces in acceleration
    acceleration.add(f);
  }

  void update() {
    if (moving && active) {
      // Velocity changes according to acceleration
      velocity.add(acceleration);
      // Location changes by velocity
      location.add(velocity);
      // We must clear acceleration each frame
      
    }
    
    acceleration.mult(0);
    if(type=="meteor") {
      println("update meteor");
      sps.update();
      eps.update();
      sps.setEmitter(location.x,location.y);
      
    }
  }
  
  // Draw Mover
  void display() {
    stroke(255);
    strokeWeight(2);
    fill(255, 200);
    
    //ellipse(location.x, location.y, 16, 16);
    if (!isAnimated && null == img) {
      ellipse(location.x, location.y, 16, 16);
    }
    else {
      if (isAnimated) {
        timeIntoAnim = millis() - animStartTime;
        //println(animState);
        PImage[] thisSheet = sheetMap.get(animState);
        int duration = sheetDurationsMs.get(animState);
        int columns = sheetColumns.get(animState);
        int max = thisSheet.length;
        int totalDuration = duration * columns;
        //int howmany = min(millis(),totalDuration) / duration;
        int howmany = timeIntoAnim / duration;
        int whichFrame = howmany % max;
        //println("f=" + whichFrame);
        img = thisSheet[whichFrame];
      }
      image(img, location.x - 32, location.y - 32);
      if (type=="meteor") {
        println("display meteor");
        sps.display();
        eps.display();
      }
    }
  }
  
  void setImage(PImage newImg) {
    img = newImg; 
  }
  
  void setAnimState(String stateName) {
    isAnimated = true;
    animState = stateName; 
  }
  
  // Bounce off bottom of window
  void checkEdges() {
    if (!isFalling || isFalling
        && (location.y + hitbox.y > height)) {
      
      velocity.y = 0.0;
      moving = false;
      isFalling = false;
      if (type=="meteor") {
        println("crash meteor");
        eps.setEmitter(location.x,location.y);
      }
    }
    
    // left and right borders
    int maxX = displayWidth - int(hitbox.x);
    if (location.x < 0) {
      location.x = 0; 
    }
    else if (location.x > (maxX)) {
      location.x = maxX;
    }
  }
  
  void setDead() {
    active = false; 
  }
}