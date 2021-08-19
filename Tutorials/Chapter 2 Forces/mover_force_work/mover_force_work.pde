class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float mass;
  
  void update() {

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 15;
    mass = 10.0;
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
  
  void applyForce(PVector force) {
    PVector f = force.get(); // get a copy of the input so that i dont change the value of the input
    f.div(mass); // divide the force by the mass however doing this would affect the value of the input. as such i want to make a copy
    acceleration.add(f); // then you add the force to the acceleration. reason is acceleariton = force / mass
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
  if(mousePressed) {
    PVector wind = new PVector(0.5, 0);
    mover.applyForce(wind);
  }
  else {
    mover.applyForce(new PVector(.001, 0));
  }
  mover.update();
  mover.checkEdges();
  mover.display();
}
