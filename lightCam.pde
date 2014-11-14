/*
 * This application serves as an educational tool to visualize 
 * lightcurves and demonstrate the formation of planetary transits.
 */
 
import processing.video.*; 
Capture cam;

int fps = 30; 
int x, y, point_dist, ellipse_rad, stroke_weight, tick;
int WID, HEI;

ArrayList<Point> points;

public void setup() {
  size(640, 480); // set canvas dimensions
  smooth(); // anti-aliasing

  // capture dimensions
  WID = 160;
  HEI = 120;
  
  // allow resizing
  if (frame != null)
    frame.setResizable(true);
    
  // initialize webcam
  cam = new Capture(this, WID, HEI, fps);
  cam.start();
    
  points = new ArrayList<Point>();
}

public void draw(){
  if(cam.available()){
    cam.read();
    
    // calculate dynamic styles
    ellipse_rad = round(0.005*width);
    stroke_weight = round(0.002*width);
    point_dist = round(0.01*width);
    
    tick = tick + point_dist;
    if (tick > width) { // reset plot
      points.clear();
      tick = 0;
    }
  }
  
  cam.filter(GRAY);
  cam.filter(BLUR, 5);
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
    strokeWeight(stroke_weight);
    fill(255,255,0);
    stroke(255,255,0);
    line(points.get(i-1).x, points.get(i-1).y, points.get(i).x, points.get(i).y);
    if(point_dist >= 10) // prevent crowding points
      ellipse(points.get(i).x, points.get(i).y, ellipse_rad, ellipse_rad);
    popStyle();
  }
  pushStyle();
  fill(255, 255, 0);
  stroke(200,100,20);
  strokeWeight(stroke_weight);
  ellipse(x, y, 2*ellipse_rad, 2*ellipse_rad);
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
