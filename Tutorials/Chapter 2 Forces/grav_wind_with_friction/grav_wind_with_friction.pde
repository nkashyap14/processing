class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  void update() {

    velocity.add(acceleration); // velocity depends on acceleeration
    
    location.add(velocity); //location depends on veloctiy
    
    acceleration.mult(0); // clear the acceleration every time otherwise the force effects compound.
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass * 16, mass * 16);
  }
  
  Mover() {
    location = new PVector(30,30);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1;
  }
  
  Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    }
    else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    
    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
  
  void applyForce(PVector force) {
    //PVector f = force.get(); // get a copy of the input so that i dont change the value of the input
    PVector f = PVector.div(force, mass); // divide the force by the mass however doing this with the input instance would alter the inputs value. as such I create a new vector and use the static method
    acceleration.add(f); // then you add the force to the acceleration. reason is acceleariton = force / mass
  }

}

Mover[] movers = new Mover[100];

void setup() {
  size(2000, 2000);
  smooth();
  for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
}

void draw() {
  background(255);
  
  
  for (int i = 0; i < movers.length; i++) {
    
    float c = 0.01; // friction coefficient
    PVector friction = movers[i].velocity.get(); //start with velocity vector for friction
    
    friction.mult(-1); // reverse direction as firction applies opposite direction to velocity
    friction.normalize(); // normalize to unit vector
    friction.mult(c); // scale by friction coefficient. this is assuming normal force = 1
    
    PVector wind = new PVector(0.01, 0);
    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1 * m);
    
    movers[i].applyForce(friction);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
