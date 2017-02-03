package FX;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PShape;

public class ExplosionParticleSystem extends PApplet{
  ArrayList<ExplosionParticle> particles;

  PShape particleShape;

  public ExplosionParticleSystem(int n) {
    particles = new ArrayList<ExplosionParticle>();
    particleShape = createShape(PShape.GROUP);

    for (int i = 0; i < n; i++) {
      int col = floor(random(0,2));
      ExplosionParticle p = new ExplosionParticle(col);
      particles.add(p);
      particleShape.addChild(p.getShape());
    }
  }

  public void update() {
    for (ExplosionParticle p : particles) {
      p.update();
    }
  }

  public void setEmitter(float x, float y) {
    for (ExplosionParticle p : particles) {
      if (p.isDead()) {
        p.rebirth(x, y);
      }
    }
  }

  public void display() {
    shape(particleShape);
  }
}