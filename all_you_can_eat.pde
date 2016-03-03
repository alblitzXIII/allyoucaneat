/**
 * All You Can Eat Apocalypse
 *
 * "Yes, it is the apocalypse. But at least there is a buffet..."
 *  
 * A Berlin Mini Game Jam entry by:
 *
 *
 * Alioune (alioune.schurz@gmail.com)
 * Anastasia (anastasia.semenoff@gmail.com)
 * Jan (jlangermann@gmail.com)
 * Martin (geigermartin06@gmail.com)
 *
 */
 
 

Spawner spawner = new Spawner();
ArrayList<Mover> spawned = new ArrayList<Mover>();
CountDownToApocalypse countDown;
SoundSystem SOUND;


Lava collider;

int startTime;

PImage backgroundSprite;

Mover beast;
boolean isPlaying = false;
boolean isDead = false;
boolean gameOver = false;
int TIME_TO_APOCALYPSE_SEC = 100;

PImage[] smokeParticleSprites;
PImage[] explosionParticles;

import java.util.Map;

void initParticleSystem() {
  smokeParticleSprites = new PImage[4];
  for (int i=0; i<4;i++) {
    smokeParticleSprites[i] = loadImage("asset/graphics/particles/smoke_particle_"+i+".png");
  }
  explosionParticles = new PImage[4];
  for (int i=0; i<4;i++) {
    explosionParticles[i] = loadImage("asset/graphics/particles/explosion_particle_"+i+".png");
  }
} 

void initCountDown(){
  countDown = new CountDownToApocalypse(TIME_TO_APOCALYPSE_SEC);
}

void setup() {
  //size(1024,768);
  size(1280,960);
  startTime = millis();
  
  initParticleSystem();
  initCountDown();
  //hint(DISABLE_DEPTH_MASK);
  
  SOUND = new SoundSystem(this);
  SOUND.playBgm("asset/audio/bgm/end_of_the_world.mp3",1.5); 
  
  sheetMap = new HashMap<String, PImage[]>(6);
  sheetDimensions = new HashMap<String, Integer>(6);
  sheetDurationsMs = new HashMap<String, Integer>(6);
  sheetColumns = new HashMap<String, Integer>(6);
  
  backgroundSprite = loadImage("asset/graphics/background_1280x960.png"); 

  // collider (eat attack)
  collider = new Lava(0, 0, 0, 0, 0.1);
  
  // IMAGES
  
  PImage[] imgsMeteorIdle = {
    loadImage("asset/graphics/comet_1.png").copy(),  
    loadImage("asset/graphics/comet_2.png").copy(),
    loadImage("asset/graphics/comet_3.png").copy(),
    loadImage("asset/graphics/comet_4.png").copy(),
    loadImage("asset/graphics/comet_5.png").copy(),
  };
  setSpriteSheet("meteor_idle", imgsMeteorIdle, 256, 50, 5);
  PImage[] imgsMeteorCrash = {
    loadImage("asset/graphics/comet_1.png").copy() };
  setSpriteSheet("meteor_crash", imgsMeteorCrash, 256, 50, 5);

  spawner.setImage("amphibia1", loadImage("asset/graphics/amphibia_1.png"));
  spawner.setImage("amphibia2", loadImage("asset/graphics/amphibia_2.png"));
  spawner.setImage("fish1", loadImage("asset/graphics/fish_1.png"));
  spawner.setImage("fish2", loadImage("asset/graphics/fish_2.png"));
  spawner.setImage("fish3", loadImage("asset/graphics/fish_3.png"));
  spawner.setImage("fish4", loadImage("asset/graphics/fish_4.png"));
  
  PImage[] imgsBeastMunchL = {
    loadImage("asset/graphics/beast/munch1.png").copy(),  
    loadImage("asset/graphics/beast/munch2.png").copy(),  
    loadImage("asset/graphics/beast/munch3.png").copy(),  
    loadImage("asset/graphics/beast/munch4.png").copy(),  
    loadImage("asset/graphics/beast/munch5.png").copy(),  
    loadImage("asset/graphics/beast/munch6.png").copy(),  
    loadImage("asset/graphics/beast/munch7.png").copy(),  
    loadImage("asset/graphics/beast/munch8.png").copy() 
  };
  setSpriteSheet("beast_munch_left", imgsBeastMunchL, 256, 100, 8);
  
  PImage[] imgsBeastMunchR = {
    loadImage("asset/graphics/beast/munch1r.png").copy(),  
    loadImage("asset/graphics/beast/munch2r.png").copy(),  
    loadImage("asset/graphics/beast/munch3r.png").copy(),  
    loadImage("asset/graphics/beast/munch4r.png").copy(),  
    loadImage("asset/graphics/beast/munch5r.png").copy(),  
    loadImage("asset/graphics/beast/munch6r.png").copy(),  
    loadImage("asset/graphics/beast/munch7r.png").copy(),  
    loadImage("asset/graphics/beast/munch8r.png").copy() 
  };
  setSpriteSheet("beast_munch_right", imgsBeastMunchR, 256, 100, 8);
  
  PImage[] imgsBeastIdle = {
    loadImage("asset/graphics/beast/idle1.png").copy(),  
    loadImage("asset/graphics/beast/idle2.png").copy(),  
    loadImage("asset/graphics/beast/idle3.png").copy(),  
    loadImage("asset/graphics/beast/idle4.png").copy(),  
    loadImage("asset/graphics/beast/idle5.png").copy(),  
    loadImage("asset/graphics/beast/idle6.png").copy()
  };
  setSpriteSheet("beast_idle_left", imgsBeastIdle, 256, 100, 8);
  
  PImage[] imgsBeastIdleRight = {
    loadImage("asset/graphics/beast/idle1r.png").copy(),  
    loadImage("asset/graphics/beast/idle2r.png").copy(),  
    loadImage("asset/graphics/beast/idle3r.png").copy(),  
    loadImage("asset/graphics/beast/idle4r.png").copy(),  
    loadImage("asset/graphics/beast/idle5r.png").copy(),  
    loadImage("asset/graphics/beast/idle6r.png").copy()
  };
  setSpriteSheet("beast_idle_right", imgsBeastIdleRight, 256, 100, 8);
  
  PImage[] imgsBeastRun = {
    loadImage("asset/graphics/beast/run1.png").copy(),  
    loadImage("asset/graphics/beast/run2.png").copy(),  
    loadImage("asset/graphics/beast/run3.png").copy(),  
    loadImage("asset/graphics/beast/run4.png").copy(),  
    loadImage("asset/graphics/beast/run5.png").copy(),  
    loadImage("asset/graphics/beast/run6.png").copy(),
  };
  setSpriteSheet("beast_run_left", imgsBeastRun, 256, 100, 8);
  
  PImage[] imgsBeastRunRight = {
    loadImage("asset/graphics/beast/run1r.png").copy(),  
    loadImage("asset/graphics/beast/run2r.png").copy(),  
    loadImage("asset/graphics/beast/run3r.png").copy(),  
    loadImage("asset/graphics/beast/run4r.png").copy(),  
    loadImage("asset/graphics/beast/run5r.png").copy(),  
    loadImage("asset/graphics/beast/run6r.png").copy(),  
  };
  setSpriteSheet("beast_run_right", imgsBeastRunRight, 256, 100, 8);
  
  spawner.spawn("beast");
  
  // last spawned is the beast, get reference
  beast = spawner.getLastSpawned();
  beast.location.y = -1500;
}

void updateApocalypse(){
  if (countDown.isApocalypse() && ! gameOver) {
    gameOver = true;
    SOUND.playBgm("asset/audio/se/bell.mp3",1);
  }
}

void draw() {
  background(yellow);
  image(backgroundSprite,0,0); 

  keyPressed();
  
  // update collider with beast position x y w h
  int biteOffset = 100;
  collider.x = beast.location.x - biteOffset;
  if (!beast.facingLeft) {
    collider.x += 2 * biteOffset; 
  }
  collider.y = beast.location.y;
  collider.w = 200;
  collider.h = 200;

  for (Mover mover : spawned) {
    if (mover.active) {
      /*
      if (lava.contains(mover)) {
        if (mover.isFalling) {
          // Calculate drag force
          PVector drag = lava.drag(mover);
          // Apply drag force to Mover
          mover.applyForce(drag);
        }
      }
      */
      
      if ("beast_munch_left" == beast.animState
          || "beast_munch_right" == beast.animState) {
            
        if (collider.contains(mover)) {
          onEat(mover);
          mover.setDead();
        }
      }
  
      if (mover.isFalling) {
        PVector gravity = new PVector(0, 0.1*mover.mass);
        mover.applyForce(gravity);
      }
      
      mover.update();
      if (!mover.isPlayer) {
        mover.display();
      }
      mover.checkEdges();      
    }
  }
  beast.display();
  
  
  int passedTime = millis() - startTime; 

  // Random spawn in intervals

  if (0 == (passedTime % 150)) {
    
    addSpawn(1);
  }
  
  
  countDown.update();
  countDown.display();
  updateApocalypse();
}

void onEat(Mover mover) {
  println("onEat");
  SOUND.playSE("asset/audio/se/eat.mp3");
  addSpawn(2);
  
}

void onDeath() {
  println("onDeath");
  isDead = true;
}

// spawn some
void addSpawn(int howmany) {
  String[] whatFalls = {
    "meteor", 
    "amphibia1", 
    "amphibia2", 
    "fish1", 
    "fish2", 
    "fish3",
    "fish4"
  };
  for (int i = 0; i < howmany; i++) {
    int rndIndex = int(random(0, whatFalls.length));
    spawner.spawn(whatFalls[rndIndex]);    
  }
}

void keyPressed() {
  if (key == CODED) {
    String oldAnimState = beast.animState;
    if (keyCode == LEFT) {
      beast.setAnimState("beast_run_left"); 
      beast.facingLeft = true;
      beast.location.x -= 2;
    } else if (keyCode == RIGHT) {
      beast.setAnimState("beast_run_right");
      beast.facingLeft = false;
      beast.location.x += 2;
    } else if (keyCode == CONTROL) {
      if (beast.facingLeft) {
        beast.setAnimState("beast_munch_left");
      } else {
        beast.setAnimState("beast_munch_right");
      }
    } else {
      if (beast.facingLeft) {
        beast.setAnimState("beast_idle_left");
      } else {
        beast.setAnimState("beast_idle_right");
      }
    }
    if (oldAnimState != beast.animState) {
      beast.animStartTime = millis(); 
    }
  } 
}