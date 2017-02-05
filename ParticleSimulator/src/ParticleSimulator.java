
import FX.SmokeParticleSystem;
import components.GameLogic;
import components.ResourceManager;
import components.SubSystems;
import FX.ExplosionParticleSystem;
import FX.ExplosionSystem;
import processing.core.PApplet;
import processing.core.PImage;
import sound.SoundSystem;

public class ParticleSimulator extends PApplet {

	// subsystems
	static ResourceManager resourceManager;
	static SubSystems subSystems;
	static GameLogic gameLogic;
	CountDownToApocalypse countDown;

	public static void main(String[] args) {
		PApplet.main("ParticleSimulator");
	}

	public void gameStart() {
		gameLogic.gameOver = false;
		countDown = new CountDownToApocalypse(Constants.timeToApocalypseSec);
		subSystems.sound.playBgm("assets/sound/bgm/end_of_the_world.mp3", 1.5f);
	}

	public void settings() {
		// size(300,300);
		size(1024, 768);// P2D);
		orientation(LANDSCAPE);
		// hint(DISABLE_DEPTH_MASK);
	}

	public void setup() {
		resourceManager = new ResourceManager(this);
		resourceManager.load();
		subSystems = new SubSystems(this, resourceManager);
		gameLogic = new GameLogic();
		fill(120, 50, 240);
		gameStart();
	}

	void gameUpdate() {
		countDown.update();

		// check for game over
		if (countDown.isApocalypse() && !gameLogic.gameOver) {
			gameLogic.gameOver = true;
			subSystems.sound.playBgm("assets/sound/se/bell.mp3", 1);
		}
	}

	public void draw() {
		background(255);
		image(resourceManager.backgroundSprite, 0, 0);

		PImage cometSprite1 = resourceManager.cometSprite1;
		image(cometSprite1, mouseX - cometSprite1.width / 2, mouseY - cometSprite1.height / 2);
		subSystems.smoke.setEmitter(mouseX, mouseY);
		fill(0);
		textSize(16);
		text("Frame rate: " + (int) frameRate, 10, 20);

		subSystems.smoke.update();
		countDown.update();
		subSystems.smoke.display();
		//countDown.display();
	}

	public void mousePressed() {
		/*
		 * eps.setEmitter(mouseX, mouseY + 60);
		 * SOUND.playSE("assets/sound/se/explode1.mp3");
		 */
	}

}