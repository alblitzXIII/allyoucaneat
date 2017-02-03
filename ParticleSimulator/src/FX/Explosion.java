package FX;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PShape;

class Explosion extends PApplet{
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