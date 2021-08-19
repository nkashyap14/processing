class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
        
    aAcceleration = acceleration.x / 10.0;
    
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -.1, .1);
    angle += aVelocity;
    acceleration.mult(0);

    
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    rectMode(CENTER);
    pushMatrix();
    
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, 16,  16);
    popMatrix();
  }
  
  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
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
  mover = new Mover();
}

void draw() {
  background(255);
  if(mousePressed)
  {
    mover.applyForce(new PVector(.25, 0));
  }
  else
    mover.applyForce(new PVector(-.25, 0));
  mover.update();
  mover.checkEdges();
  mover.display();
}
