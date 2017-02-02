import FX.SmokeParticleSystem;
import FX.ExplosionParticleSystem;
import FX.ExplosionSystem;
import processing.core.PApplet;
import processing.core.PImage;

public class AllYouCanEat extends PApplet {
		
	static boolean gameOver = false; //@integrate
	static SoundSystem SOUND = new SoundSystem("");
	static SmokeParticleSystem sps = new SmokeParticleSystem(350);
	static ExplosionParticleSystem eps = new ExplosionParticleSystem(100);
	static CountDownToApocalypse countDown;
	static PImage cometSprite1;
	static PImage backgroundSprite; //@integrate

	  
    public static void main(String[] args) {
        PApplet.main("AllYouCanEat");
    }

    public void settings(){
        size(300,300);
    }

    public void setup(){
	  size(1024,768, P2D);
	  orientation(LANDSCAPE);
	  hint(DISABLE_DEPTH_MASK);
	  cometSprite1 = loadImage("comet_1.png");
	  backgroundSprite = loadImage("background.png");
	  SOUND = new SoundSystem(this);
	  SOUND.playBgm("end_of_the_world.mp3",1.5f);
	  initCountDown();

    }
    
    void updateApocalypse(){
    	  if(countDown.isApocalypse() && ! gameOver){
    	    gameOver = true;
    	    SOUND.playBgm("se/bell.mp3",1);
    	  }
	}

    public void draw(){
    	  background(255);
    	  image(backgroundSprite,0,0);
    	  sps.update();
    	  sps.display();
    	  eps.update();
    	  eps.display();
    	  
    	  //ps.setEmitter(mouseX,mouseY);
    	  image(cometSprite1,mouseX-cometSprite1.width/2,mouseY-cometSprite1.height/2);
    	  sps.setEmitter(mouseX,mouseY);
    	  fill(0);
    	  textSize(16);
    	  text("Frame rate: " + (int)frameRate, 10, 20);
    	  countDown.update();
    	  countDown.display();
    	  updateApocalypse();
	  }
    
    public void initCountDown(){
    	  countDown = new CountDownToApocalypse(Constants.TIME_TO_APOCALYPSE_SEC);
	}
    
    public void mousePressed(){
    	  eps.setEmitter(mouseX,mouseY+60);
    	  SOUND.playSE("se/explode1.mp3");
	}

}