class Particle  {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle(PVector l) {
    location = l.get();
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1,1), random(-2, 0));
    lifespan = 255;
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
  }
  
  void display() {
    stroke(0, lifespan);
    fill(0, lifespan); // assigns lifespan to alpha as its scales from 255 - 0. casues it to fade from screne
    ellipse(location.x, location.y, 8, 8);
  }
  
  void run() {
    update();
    display();
  }
  
  boolean isDead() {
    if(lifespan < 0.0)
      return true;
    else
      return false;
  }
}

Particle p;

void setup() {
  size(200,200);
  p = new Particle(new PVector(width/2, 10));
  smooth();
}

void draw() {
  background(255);
  p.run();
  if(p.isDead()) {
    println("Particle Dead");
  }
}
