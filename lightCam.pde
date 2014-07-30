/*
 * This application serves as an educational tool to visualize 
 * lightcurves and demonstrate the formation of planetary transits.
 */
 
import processing.video.*; 
Capture cam;

int fps = 30; 
int x, y, plot_interval, tick;
int WID, HEI;

ArrayList<Point> points;

public void setup() {
  size(640, 480); // set canvas dimensions
  
  // capture dimensions
  WID = 160;
  HEI = 120;
  
  // allow resizing
  if (frame != null)
    frame.setResizable(true);
  
  plot_interval = 20;
  
  // initialize webcam
  cam = new Capture(this, WID, HEI, fps);
  cam.start();
  
  // drawing settings
  smooth();
  fill(255, 255, 0);
  stroke(200, 200, 0);
  strokeWeight(1.5f);
  
  points = new ArrayList<Point>();
}

public void draw(){
  if(cam.available()){
    cam.read();
    tick = tick + plot_interval;
    if (tick > width) { // reset
      points.clear();
      tick = 0;
    }
  }
  
  // display image
  cam.filter(GRAY);
  cam.filter(BLUR,5);
  
  background(0);
  stretchImageToSize(cam, width, height);
  image( cam, 0, 0);
  drawPoints();
}

public void drawPoints(){
  float sum = 0;
  for (int i = 0; i < cam.pixels.length; i++)
    sum = sum + brightness(cam.pixels[i]);

  x = tick;
  y = round( map(255-sum/cam.pixels.length, 0, 255, 0, height) );
  
  // OUTPUT TEXT
  println("AVG BRIGHTNESS: ", y);

  points.add(new Point(x, y));

  for (int i = 0; i < points.size (); i++ ) {
   if (i == 0)
      continue;
    pushStyle();
    strokeWeight(1.5f);
    fill(255,255,0);
    line(points.get(i-1).x, points.get(i-1).y, points.get(i).x, points.get(i).y);
    if(plot_interval >= 10) // prevent crowding points
      ellipse(points.get(i).x, points.get(i).y, 5, 5);
    popStyle();
  }
  pushStyle();
  stroke(200,100,20);
  strokeWeight(2);
  ellipse(x, y, 10, 10);
  popStyle(); 
}

public boolean stretchImageToSize(PImage img, int target_wid, int target_hei){
  if( img.width >= target_wid || img.height >= target_hei )
    return false;
    
  int ellipse_wid = round( target_wid/img.width );
  int ellipse_hei = round( target_hei/img.height );
  int value = 0;
  img.loadPixels();
  for( int j=0; j<img.height; j++){
    for(int i=0; i<img.width; i++){
      value = img.pixels[i+j*img.width];
      pushStyle();
      fill(value);
      noStroke();
      ellipse(i*ellipse_wid,j*ellipse_hei,ellipse_wid,ellipse_hei);
      popStyle();
    } 
  }
  return true;
}

class Point {
  int x, y;
  Point(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

