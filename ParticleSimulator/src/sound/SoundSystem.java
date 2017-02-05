package sound;

import java.util.ArrayList;

import ddf.minim.*;

public class SoundSystem{
  
  private Minim mMinim;

  private AudioPlayer mCurrentPlayer;
  private AudioPlayer mOtherPlayer;
  private ArrayList<AudioPlayer> mAudioPlayers;
  Object sketchPath;
  
  public SoundSystem(Object sketchPath){
    this.sketchPath = sketchPath;
    mMinim = new Minim(sketchPath);
    mAudioPlayers = new ArrayList<AudioPlayer>();
  }
  
  public void playBgm(String file,float fade_s){
    System.out.println("Playing "+file);
    int fade_ms = (int)(fade_s * 1000);
   
    
    if(mCurrentPlayer != null){
      float gain = mCurrentPlayer.getGain();
      float lowGain = gain-70;
      mCurrentPlayer.shiftGain(gain,lowGain,fade_ms);
      mOtherPlayer = mMinim.loadFile(file);
      AudioPlayer tmp = mCurrentPlayer;
      mCurrentPlayer = mOtherPlayer;
      mOtherPlayer = tmp;
    }
    
    if(mCurrentPlayer==null){      
      mCurrentPlayer = mMinim.loadFile(file);
    }

    if(fade_ms>0){
      float gain = mCurrentPlayer.getGain();
      float lowGain = gain-70;
      mCurrentPlayer.setGain(lowGain);
      mCurrentPlayer.shiftGain(lowGain,gain,fade_ms);
    }
    mCurrentPlayer.play();
    mCurrentPlayer.loop();
  }
  
  public void fadeOutBgm(float fade_s){
    int fade_ms = (int)(fade_s * 1000);
    if(mCurrentPlayer!=null){
      float gain = mCurrentPlayer.getGain();
      mCurrentPlayer.shiftGain(gain,gain-70,fade_ms);
    }
  }
  
  public void fadeInBgm(float fade_s){
    int fade_ms = (int)(fade_s * 1000);
    if(mCurrentPlayer!=null){
      float gain = mCurrentPlayer.getGain();
      mCurrentPlayer.shiftGain(gain,0,fade_ms);
    }
  }
  
  public void pauseBgm(){
    if(mCurrentPlayer != null){
      mCurrentPlayer.pause();
    }
  }
  
  public void playBgm(){
    if(mCurrentPlayer!=null){
      mCurrentPlayer.play();
    }
  }
  
  public void playSE(String file){
    for(AudioPlayer audioP : mAudioPlayers){
      if(!audioP.isPlaying()){
        audioP = mMinim.loadFile(file);
        audioP.play();  
        return;
      }
    }
    AudioPlayer newAP = mMinim.loadFile(file);
    mAudioPlayers.add(newAP);
    newAP.play();
  }
  
  
  
}