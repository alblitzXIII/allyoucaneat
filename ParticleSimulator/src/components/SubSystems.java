package components;
import FX.ExplosionParticleSystem;
import FX.SmokeParticleSystem;
import processing.core.PApplet;
import sound.SoundSystem;

public class SubSystems {

	public SoundSystem sound;
	public SmokeParticleSystem smoke;
	public ExplosionParticleSystem explosion;

	public SubSystems(PApplet sketch,ResourceManager rm) {
		sound = new SoundSystem(sketch);
		smoke = new SmokeParticleSystem(sketch,rm,10);
	}
}
