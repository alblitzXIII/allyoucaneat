// ============================
class SmokeParticleSystem{
  ArrayList<SmokeParticle> particles;

  PShape particleShape;

  SmokeParticleSystem(int n) {
    particles = new ArrayList<SmokeParticle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      int col = floor(random(0,2));
      SmokeParticle p = new SmokeParticle(col);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (SmokeParticle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y) {
    for (SmokeParticle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  void display() {
    shape(particleShape);
  }
}

// ============================

class SmokeParticle {

  PVector velocity;
  float lifespan = 255;
  
  PShape part;
  float partSize;
  
  PVector gravity = new PVector(0,-0.1);


  SmokeParticle(int col) {
    if(!(col>=0 && col<4)){
      col=0;
      println("Error: particle color doesn't exist");
    }
    PImage sprite = smokeParticleSprites[col];
    partSize = random(10,60);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
    
    rebirth(-20,-20);

    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
    part.translate(x, y); 
  }
  
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
  

  public void update() {
    lifespan = lifespan - 1;
    velocity.add(gravity);
    
    part.setTint(color(255,lifespan));
    part.translate(velocity.x, velocity.y);
  }
}