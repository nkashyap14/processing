class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    lifespan = 255.0;
  }
  
  void run() {
   update();
   display();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }
  
  void display() {
    fill(0);
    ellipse(location.x, location.y, 8, 8);
  }
  
  boolean isDead() {
    if(lifespan < 0.0)
      return true;
    else
      return false;
  }
}

class Confetti extends Particle {
  Confetti(PVector l) {
    super(l);
  }
  
  void display() {
    float theta = map(location.x, 0, width, 0, TWO_PI * 2);
    rectMode(CENTER);
    fill(175, lifespan);
    stroke(0, lifespan);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    rect(0, 0, 8, 8);
    popMatrix();  }
}
