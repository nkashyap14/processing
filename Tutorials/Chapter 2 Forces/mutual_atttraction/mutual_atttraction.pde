class Attractor {
  float mass;
  PVector location;
  float G;
  
  Attractor() {
    location = new PVector(width/2, height/2);
    mass = 20;
    G = .4;
  }
  
  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location); // get the vector describing the difference between the mover object and the attracted object
    float distance = force.mag(); // get the magnitude of the difference
    distance = constrain(distance, 5, 25); // put the distance value into certain ranges because the formula for gravitational attraction is calculated in real world units but in processing we are dealing with pixels so being .001 pixel away can cause the foe to rocket
    force.normalize(); // convert to unit vector that points to the direction we want
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength); // multiply the unit vector by the gravitational magnitude we calculated
    return force;
  }
}


class Mover {
 
  float G = .4;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
   Mover(float m, float x, float y) {
    mass = m;
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  Mover() {
    location = new PVector(30, 39);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1;
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
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location); // get the vector describing the difference between the mover object and the attracted object
    float distance = force.mag(); // get the magnitude of the difference
    distance = constrain(distance, 5, 25); // put the distance value into certain ranges because the formula for gravitational attraction is calculated in real world units but in processing we are dealing with pixels so being .001 pixel away can cause the foe to rocket
    force.normalize(); // convert to unit vector that points to the direction we want
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength); // multiply the unit vector by the gravitational magnitude we calculated
    return force;
  }
  
  void applyForce(PVector force) {
    PVector f = force.get(); // get a copy of the input so that i dont change the value of the input
    f.div(mass); // divide the force by the mass however doing this would affect the value of the input. as such i want to make a copy
    acceleration.add(f); // then you add the force to the acceleration. reason is acceleariton = force / mass
  }

}

Mover[] movers = new Mover[20];

void setup() {
  size(200, 200);
  smooth();
  for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 2), random(width), random(height));
  }
}

void draw() {
  background(255);
  
  for(int i = 0; i < movers.length; i++) {
    for(int j = 0; j < movers.length; j++) {
      if(i != j) {
        PVector force = movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
