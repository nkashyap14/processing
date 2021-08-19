class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  void update() {
    acceleration = PVector.random2D();
    //acceleration = acceleration.mult(.5); //scaling the aceleraiton by a constant value
    acceleration.mult(random(2)); // scaling the acceleration to a random value
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
