class Liquid {
  float x, y, w, h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x,y,w,h);
  }
}

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
  
  boolean isInside(Liquid l) {
    if (location.x > l.x && location.x < l.x + l.w && location.y > l.y && location.y < l.y+l.h)
       return true;
    else
      return false;
  }
  
  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed;
    
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    
    drag.mult(dragMagnitude);
    applyForce(drag);
  }
  
  void applyForce(PVector force) {
    //PVector f = force.get(); // get a copy of the input so that i dont change the value of the input
    PVector f = PVector.div(force, mass); // divide the force by the mass however doing this with the input instance would alter the inputs value. as such I create a new vector and use the static method
    acceleration.add(f); // then you add the force to the acceleration. reason is acceleariton = force / mass
  }

}

Liquid liquid;
Mover[] movers = new Mover[100];

void setup() {
  size(640 , 240);
  smooth();
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
  for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
}

void draw() {
  background(255);
  
  liquid.display();
  
  
  for (int i = 0; i < movers.length; i++) {
   
    
    PVector wind = new PVector(0.01, 0);
    float m = movers[i].mass * .1;
    PVector gravity = new PVector(0, m);
    
    if (movers[i].isInside(liquid)) {
      movers[i].drag(liquid);
    }
    
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
