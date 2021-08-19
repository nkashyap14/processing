class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    
    dir.normalize(); // normalize the delta vector to be a unit vector of length 1
    dir.mult(.5); // scaling the vector
    
    acceleration = dir;
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display() {
    float angle = atan2(velocity.y,velocity.x); // use atan2 in ordre to account for all possible directions 
    stroke(0);
    fill(175);
    pushMatrix();
    rectMode(CENTER);
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, 30, 10);
    popMatrix();
  }
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    topspeed = 10;
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    }
    else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    }
    else if (location.y < 0) {
      location.y = height;
    }
  }

}

Mover mover;

void setup() {
  size(200, 200);
  smooth();
  mover = new Mover();
}

void draw() {
  background(255);
  mover.update();
  mover.checkEdges();
  mover.display();
}
