package FX;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.core.PShape;
import components.ResourceManager;

public class SmokeParticleSystem {
	ArrayList<SmokeParticle> particles;
	PApplet sketch;
	PShape particleShape;

	public SmokeParticleSystem(PApplet sketch, ResourceManager rm, int n) {
		this.sketch = sketch;
		particles = new ArrayList<SmokeParticle>();
		particleShape = new PShape(PShape.GROUP);

		for (int i = 0; i < n; i++) {
			int col = sketch.floor(sketch.random(0, 2));
			SmokeParticle p = new SmokeParticle(rm,col);
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
		sketch.shape(particleShape);
	}
}
