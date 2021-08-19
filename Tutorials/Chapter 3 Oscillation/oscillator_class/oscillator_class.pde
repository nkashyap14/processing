class Oscillator {

  PVector angle; // Using PVector to track two angeles
  PVector velocity;  // Using PVector to track two velocities for the angles of rotation
  PVector amplitude; // Using PVector to track two different amplitudes for the two different axis
  
  Oscillator() {
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(width/2), random(height/2));
  }
  
  void oscillate() {
    angle.add(velocity);
  }
  
  void display() {
    float x = sin(angle.x) * amplitude.x;
    float y = sin(angle.y) * amplitude.y;
    
    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    fill(175);
    
    line(0,0, x, y);
    ellipse(x, y, 16, 16);
    popMatrix();
  }
}

Oscillator[] osc = new Oscillator[20];

void setup() {
  size(200, 200);
  smooth();
  for(int i = 0; i < osc.length; i++)
    osc[i] = new Oscillator();
}

void draw() {
  background(255);
  for(int i = 0; i < osc.length; i++) {
    osc[i].oscillate();
    osc[i].display();
  }
}
