SoundSystem SOUND; //@integrate
CountDownToApocalypse countDown; //@integrate
SmokeParticleSystem sps;
ExplosionParticleSystem eps;

int TIME_TO_APOCALYPSE_SEC = 10;//@integrate

boolean gameOver = false; //@integrate
PImage backgroundSprite; //@integrate
PImage[] smokeParticleSprites;  //@integrate
PImage[] explosionParticles; //@integrate
PImage cometSprite1;

//@integrate
void initParticleSystem(){
  backgroundSprite = loadImage("background.png");
  smokeParticleSprites = new PImage[4];
  for(int i=0; i<4;i++){
    smokeParticleSprites[i] = loadImage("smoke_particle_"+i+".png");
  }
  explosionParticles = new PImage[4];
  for(int i=0; i<4;i++){
    explosionParticles[i] = loadImage("explosion_particle_"+i+".png");
  }
  sps = new SmokeParticleSystem(350);
  eps = new ExplosionParticleSystem(100);
 
  println("initialized particle system");
}


//@integrate
void initCountDown(){
  countDown = new CountDownToApocalypse(TIME_TO_APOCALYPSE_SEC);
}

void updateApocalypse(){
  if(countDown.isApocalypse() && ! gameOver){
    gameOver = true;
    SOUND.playBgm("se/bell.mp3",1);
  }
}

void setup(){
  size(1024,768, P2D);
  orientation(LANDSCAPE);
  // init particle sprites 
  initParticleSystem();
  initCountDown();
  hint(DISABLE_DEPTH_MASK);
  
  SOUND = new SoundSystem(this);
  SOUND.playBgm("end_of_the_world.mp3",1.5);
  
  cometSprite1 = loadImage("comet_1.png");
  
}

void draw(){
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
  text("Frame rate: " + int(frameRate), 10, 20);
  countDown.update();
  countDown.display();
  updateApocalypse();
}

void mousePressed(){
  eps.setEmitter(mouseX,mouseY+60);
  SOUND.playSE("se/explode1.mp3");
}