class Particle  {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector l) {
    location = l.get();
    acceleration = new PVector();
    velocity = new PVector();
    lifespan = 255;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }
  
  void display() {
    stroke(0);
    fill(175, lifespan); // assigns lifespan to alpha as its scales from 255 - 0. casues it to fade from screne
    ellipse(location.x, location.y, 8, 8);
  }
  
  boolean isDead() {
    if(lifespan < 0.0)
      return true;
    else
      return false;
  }
}
