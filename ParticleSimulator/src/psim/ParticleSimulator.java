package psim;
import FX.SmokeParticleSystem;
import FX.ExplosionParticleSystem;
import FX.ExplosionSystem;
import processing.core.PApplet;
import processing.core.PImage;

public class ParticleSimulator extends PApplet {

	// subsystems 
	static SoundSystem SOUND;
	static SmokeParticleSystem sps;
	static ExplosionParticleSystem eps;
	static CountDownToApocalypse countDown;
	
    // resources 
	static PImage cometSprite1;
	static PImage backgroundSprite; // @integrate
	// game logic
	static boolean gameOver;


	public static void main(String[] args) {
		PApplet.main("ParticleSimulator");
	}
	
	public void loadSubSystems(){
		SOUND = new SoundSystem(this);
		sps = new SmokeParticleSystem(350);
		System.exit(1);
		eps = new ExplosionParticleSystem(100);
	}
	
	public void loadResources(){
		cometSprite1 = loadImage("assets/graphics/comet_1.png");
		backgroundSprite = loadImage("assets/graphics/background.png");
	}
	
	public void initGameLogic(){
		gameOver = false; // @integrate
		SOUND.playBgm("assets/sound/bgm/end_of_the_world.mp3", 1.5f);
		//initCountDown();
	}

	public void setup() {
		loadSubSystems();
		loadResources();
		initGameLogic();
		// Resolution 
		size(1024, 768, P2D);
		orientation(LANDSCAPE);
		hint(DISABLE_DEPTH_MASK);
	}

	void updateApocalypse() {
		if (countDown.isApocalypse() && !gameOver) {
			gameOver = true;
			SOUND.playBgm("assets/sound/se/bell.mp3", 1);
		}
	}

	public void draw() {
		background(255);
		//image(backgroundSprite, 0, 0);
		/*
		sps.update();
		sps.display();
		eps.update();
		eps.display();

		// ps.setEmitter(mouseX,mouseY);
		image(cometSprite1, mouseX - cometSprite1.width / 2, mouseY - cometSprite1.height / 2);
		sps.setEmitter(mouseX, mouseY);
		fill(0);
		textSize(16);
		text("Frame rate: " + (int) frameRate, 10, 20);
		countDown.update();
		countDown.display();
		*/
		//updateApocalypse();
	}

	public void initCountDown() {
		countDown = new CountDownToApocalypse(Constants.TIME_TO_APOCALYPSE_SEC);
	}

	public void mousePressed() {
		eps.setEmitter(mouseX, mouseY + 60);
		SOUND.playSE("assets/sound/se/explode1.mp3");
	}

}