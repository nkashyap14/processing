import java.util.Iterator;

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float lifespan;
  
  Particle(PVector l) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    location = l.get();
    mass = 1.0;
    lifespan = 255.0;
  }
  
  void run() {
   update();
   display();
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
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
  
  void applyForce(PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
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

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particle>();
  }
  
  void addParticle() {
    float r = random(1);
    if (r < 0.5)
      particles.add(new Particle(origin));
    else
      particles.add(new Confetti(origin));
  }
  
  void run() {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if (p.isDead()) {
        it.remove();
      }
    }
  }
  
  void applyForce(PVector f) {
    for (Particle p : particles) {
       p.applyForce(f);
    }
  }
}
