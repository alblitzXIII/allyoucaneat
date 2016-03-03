import java.util.Map;



class Spawner
{
  HashMap<String, PImage> imageMap;

  
  int maxSpawned;
  
  Spawner() {
    maxSpawned = 1000;
    imageMap = new HashMap<String, PImage>(12);
    
  }
  
  void setImage(String type, PImage img) {
    imageMap.put(type,img); 
  }
  
  
  
  void spawn(String type) {
    if (spawned.size() < maxSpawned) {
      
      float baseSpeedX = 0.0;
      float varSpeedX = 0.5;
      float baseSpeedY = 2.0;
      float varSpeedY = 1.0;
      float baseRotate = 0.0;
      float varRotate = 0.0;
      float baseSpin = 0.0;
      float mass = 1;
      boolean isAnimated = false;
      int w = 256;// hitbox width from center
      int h = 256;// hitbox height to floor below from center
      if (type == "beast") {
        mass = 4;
        w = 256;
        h = 236;
      }
      else if (type == "meteor") {
        mass = 2;
        isAnimated = false;
      }
      else if (type == "fish1"
              || type == "fish2"
              || type == "fish3") {
        
        
      }
      else if (type == "amphibia1"
              || type == "amphibia2") {
        
        
      }
      
      SOUND.playSE("asset/audio/se/spawn.mp3");
      
      PImage img = imageMap.get(type);
      //PImage img = imageMap.get("meteor");
      
      Mover mover = new Mover(
                    type,
                    new PVector(w,h),
                    mass,
                    random(0,1024), 
                    random(-128,-64), 
                    new PVector(baseSpeedX, baseSpeedY+random(0,varSpeedY)),
                    img);
      if (type == "beast") {
        mover.setAnimState("beast_idle_left");
        mover.isPlayer = true;
      } else if (type == "meteor") {
        mover.setAnimState("meteor_idle"); 
      }
      //println("spawned " + type);
      spawned.add(mover);

    }
    
    
    
  }
  
  Mover getLastSpawned() {
      return spawned.get(spawned.size()-1);
  }
  
}