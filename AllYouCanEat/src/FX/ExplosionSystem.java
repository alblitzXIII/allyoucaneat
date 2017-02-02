package FX;

import processing.core.PApplet;
import java.util.ArrayList;

public class ExplosionSystem extends PApplet{
  
  private ArrayList<Explosion> allExplosions;
  
   ExplosionSystem(){
     allExplosions = new ArrayList<Explosion>();
   }

  void explode(float x,float y){
    for(Explosion expl : allExplosions){
      if(expl.isFinished()){
        expl.setEmitter(x,y);
        println("Reused explosion");
        //SOUND.playSE("explode.wav");
        return;
      }
    }
    println("New explosion created");
    Explosion expl = new Explosion(100);
    expl.setEmitter(x,y);
    allExplosions.add(expl);
   //SOUND.playSE("explode.wav");
  }

 void update(){
   for(Explosion expl : allExplosions){
       expl.update();
   }
 }
 
 void display(){
   for(Explosion expl : allExplosions){
       expl.display();
   }   
 }
}