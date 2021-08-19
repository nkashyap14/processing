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
  
  void applyRepeller(Repeller r) {
    for(Particle p: particles) {
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }
}

class Repeller {
  PVector location;
  float r = 10;
  float strength = 500;
  
  Repeller(float x, float y) {
    location = new PVector(x, y);
  }
  
  void display() {
    stroke(255);
    fill(255);
    ellipse(location.x, location.y, r*2, r*2);
  }
  
  PVector repel(Particle p)  {
    PVector dir = PVector.sub(location, p.location);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d, 5, 100);
    float force = -1 * strength / (d * d);
    dir.mult(force);
    return dir;
  }
  
  
}

ParticleSystem ps;
Repeller repeller;

void setup() {
  size(200, 200);
  smooth();
  ps = new ParticleSystem(new PVector(width/2, 50));
  repeller = new Repeller(width/2 - 20, height/2);
}

void draw() {
  background(100);
  ps.addParticle();
  PVector gravity = new PVector(0, 0.1);
  ps.applyForce(gravity);
  ps.applyRepeller(repeller);
  ps.run();
  repeller.display();
}
