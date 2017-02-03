package FX;
import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PShape;
import processing.core.PVector;

class SmokeParticle extends PApplet {

  PVector velocity;
  float lifespan = 255;
  PShape part;
  float partSize;
  PVector gravity = new PVector(0,-0.1f);
  
  static PImage[] smokeParticleSprites;
  static PImage[] explosionParticles;

  SmokeParticle(int col) {
	  
	initParticleSprites(); // runs only once  
	  
    if(!(col>=0 && col<4)){
      col=0;
      System.out.println("Error: particle color doesn't exist");
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
  
  void initParticleSprites(){
	  if(smokeParticleSprites == null){
		  smokeParticleSprites = new PImage[4];
		  for(int i=0; i<4;i++){
		    smokeParticleSprites[i] = loadImage("assets/graphics/smoke_particle_"+i+".png");
		  }
	  }
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5f,4);
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