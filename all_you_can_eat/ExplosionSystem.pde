// ======================
class ExplosionSystem{
  
  private ArrayList<Explosion> allExplosions;
  
   ExplosionSystem(){
     allExplosions = new ArrayList<Explosion>();
   }

  void explode(float x,float y){
    for(Explosion expl : allExplosions){
      if(expl.isFinished()){
        expl.setEmitter(x,y);
        println("Reused explosion");
        SOUND.playSE("explode.wav");
        return;
      }
    }
    println("New explosion created");
    Explosion expl = new Explosion(100);
    expl.setEmitter(x,y);
    allExplosions.add(expl);
    SOUND.playSE("explode.wav");
  }

 void update(){
   for(Explosion expl : allExplosions){
       expl.update();
   }
 }
 
 void display(){
   for(Explosion expl : allExplosions){
       expl.display();
   }   
 }
}

// ======================
class ExplosionParticleSystem{
  ArrayList<ExplosionParticle> particles;

  PShape particleShape;

  ExplosionParticleSystem(int n) {
    particles = new ArrayList<ExplosionParticle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      int col = floor(random(0,2));
      ExplosionParticle p = new ExplosionParticle(col);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (ExplosionParticle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y) {
    for (ExplosionParticle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  void display() {
    shape(particleShape);
  }
}

// ======================

class Explosion{
  ArrayList<ExplosionParticle> particles;

  PShape particleShape;

  Explosion(int n) {
    particles = new ArrayList<ExplosionParticle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      int col = floor(random(0,2));
      ExplosionParticle p = new ExplosionParticle(col);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (ExplosionParticle p : particles) {
      p.update();
    }
  }

  void setEmitter(float x, float y) {
    for (ExplosionParticle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }
  
  boolean isFinished(){
    for (ExplosionParticle p : particles) {
      if (!p.isDead()) {
        return false;
      }
    }
    return true;
  }

  void display() {
    shape(particleShape);
  }
}

// ================
class ExplosionParticle {
  
  PVector velocity;
  float lifespan = 0;
  PShape part;
  
  float partSize;

  ExplosionParticle(int col){
    partSize = random(30,50);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    PImage sprite = explosionParticles[col];
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