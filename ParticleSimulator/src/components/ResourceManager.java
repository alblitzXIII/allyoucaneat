package components;
import processing.core.PApplet;
import processing.core.PImage;

public class ResourceManager {

	PApplet sketch;
	public PImage cometSprite1;
	public PImage backgroundSprite;
	public PImage[] smokeParticleSprites;

	boolean loaded = false;

	public ResourceManager(PApplet sketch) {
		this.sketch = sketch;
	}

	public boolean isLoaded(){
		return loaded;
	}
	
	public void load() {
		if (!loaded) {
			cometSprite1 = sketch.loadImage("assets/graphics/comet_1.png");
			backgroundSprite = sketch.loadImage("assets/graphics/background.png");
			smokeParticleSprites = new PImage[4];
			for (int i = 0; i < 4; i++) {
				smokeParticleSprites[i] = sketch.loadImage("assets/graphics/smoke_particle_" + i + ".png");
			}
		}
		loaded = true;
	}
}
