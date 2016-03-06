package allyoucaneat;
import processing.core.*;

public class Sketch extends PApplet {

	public void settings(){
		size(200, 200);
	}
	
	public void setup() {
		background(0);
	}

	public void draw() {
		stroke(255);
		if (mousePressed) {
			line(mouseX, mouseY, pmouseX, pmouseY);
		}
	}

}
