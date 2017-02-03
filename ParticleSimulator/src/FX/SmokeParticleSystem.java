package FX;
import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PShape;

public class SmokeParticleSystem extends PApplet{
  ArrayList<SmokeParticle> particles;

  PShape particleShape;

  public SmokeParticleSystem(int n) {
    particles = new ArrayList<SmokeParticle>();
    particleShape = new PShape(PShape.GROUP);
    
    for (int i = 0; i < n; i++) {
      int col = floor(random(0,2));
      SmokeParticle p = new SmokeParticle(col);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  public void update() {
    for (SmokeParticle p : particles) {
      p.update();
    }
  }

  public void setEmitter(float x, float y) {
    for (SmokeParticle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  public void display() {
    shape(particleShape);
  }
}

