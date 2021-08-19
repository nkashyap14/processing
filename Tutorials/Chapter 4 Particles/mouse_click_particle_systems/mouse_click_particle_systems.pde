import java.util.Iterator;

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

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector location) {
    particles = new ArrayList<Particle>();
    origin = location;
  }
  
  void addParticle() {
    particles.add(new Particle(origin));
  }
  
  void run() {
     Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.run();
      if(p.isDead()) {
        it.remove();
      }
    }
  }
}

ArrayList<ParticleSystem> systems;

void setup() {
  size(600, 200);
  systems = new ArrayList<ParticleSystem>();
}

void mousePressed() {
  systems.add(new ParticleSystem(new PVector(mouseX, mouseY)));
}

void draw() {
  background(255);
  for (ParticleSystem ps: systems) {
    ps.run();
    ps.addParticle();
  }
}
