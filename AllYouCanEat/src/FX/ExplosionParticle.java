package FX;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PShape;
import processing.core.PVector;

class ExplosionParticle extends PApplet {
  
  PVector velocity;
  float lifespan = 0;
  PShape part;
  
  float partSize;
  
  static PImage[] explosionSprites;
  

  ExplosionParticle(int col){
	initExplosionSprites();
    partSize = random(30,50);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    PImage sprite = explosionSprites[col];
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
    
    part.translate(-10, -10);
    
    rebirth(-20,-20);
    lifespan = random(100);    
  }

  void initExplosionSprites(){
	  if(explosionSprites == null){
		  explosionSprites = new PImage[4];
		  for(int i=0; i<4;i++){
			  explosionSprites[i] = loadImage("explosion_particle_"+i+".png");
		  }
	  }
  }
  
  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y) {
    float a = random(PI);
    float speed = random(6,10);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(-speed);
    lifespan = 60;   
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
    part.setTint(color(255,round(lifespan/100*255)));
    part.translate(velocity.x, velocity.y);
  }
}