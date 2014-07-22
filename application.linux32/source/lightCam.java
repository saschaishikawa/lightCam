import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class lightCam extends PApplet {

/*
 * This application serves as an educational tool to visualize 
 * lightcurves and to demonstrate the formation of planetary transits.
 */
 

Capture cam;

int fps = 30; 
int tick = 0; 
float b_avg = 0;
int x, y, interval;
ArrayList<Point> points;

public void setup() {
  size(320, 240);
  frameRate(fps);
  interval = 1; // sets plotting interval (e.g. 1 for one point per frame)
  
  // initialize webcam
  cam = new Capture(this, 320, 240, fps);
  cam.start();
  
  // drawing settings
  smooth();
  fill(255, 255, 0);
  stroke(0, 0, 0);
  strokeWeight(1.5f);
  
  points = new ArrayList<Point>();
}

public void draw(){
  if(cam.available()){
    cam.read();
    tick = tick + interval;
    if (tick > 320) { // reset
      points.clear();
      tick = 0;
    }
  }
  cam.filter(BLUR, 60); // blur image (more realistic lightcurve)  
  image(cam, 0, 0);

  float sum = 0;
  for (int i = 0; i < cam.pixels.length; i++) {
    sum = sum + brightness(cam.pixels[i]);
  }
  println("AVG BRIGHTNESS: ", sum/cam.pixels.length);

  x = tick;
  y = 255-round(sum/cam.pixels.length);

  points.add(new Point(x, y));
  for (int i = 0; i < points.size (); i++ ) {
   if (i == 0)
      continue;
      
    pushStyle();
    strokeWeight(1.5f);
    fill(255,255,0);
    popStyle();
    line(points.get(i-1).x, points.get(i-1).y, points.get(i).x, points.get(i).y);
    if(interval >= 10) // prevent crowding points
      ellipse(points.get(i).x, points.get(i).y, 5, 5);
  }
  ellipse(x, y, 10, 10);
}

class Point {
  int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "lightCam" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
