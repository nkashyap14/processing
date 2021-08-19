class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(-0.001, 0.01);
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
