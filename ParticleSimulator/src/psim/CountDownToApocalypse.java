package psim;


import processing.core.PApplet;

public class CountDownToApocalypse extends PApplet{
  
 int totalTime; 
 int initialTime;
 int remainingTime;
 
 CountDownToApocalypse(int time_s){
   totalTime = time_s*1000;
   
 }
  
 public void start(){
   initialTime = millis();
 }
 
 void update(){
   remainingTime = totalTime-(millis()-initialTime);
 }
 
 void display(){
  fill(0);
  textSize(24);
  int t = remainingTime/1000;
  t = t<0 ? 0 : t;
  text("Time before apocalypse: " + t, 550, 50);
 }
 
 boolean isApocalypse(){
   return remainingTime<0;
 }
  
}