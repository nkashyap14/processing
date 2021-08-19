class Spring {
  PVector anchor; 
  
  float len;
  float k = .1; //constant for spring force
  
  Spring(float x, float y, int l) {
    anchor = new PVector(x, y);
    len = l;  // length at rest
  }
  
  void connect (Bob b) {
    PVector force = PVector.sub(b.position, anchor); // get vector pointing from anchor to bob location
    float d = force.mag(); // get the length of that vector
    float stretch = d - len; // distance between displacement and rest length 
    
    force.normalize(); // turn into unit vector that gives only direction
    force.mult(-1 * k * stretch); // apply formula to calculate spring force
    
    b.applyForce(force); //apply spring force on bob 
  }
  
  void display() {
    fill(100);
    rectMode(CENTER);
    rect(anchor.x, anchor.y, 10, 10);
  }
  
  void displayLine(Bob b) {
    stroke(255);
    line(b.position.x, b.position.y, anchor.x, anchor.y);
  }
  
    // Constrain the distance between bob and anchor between min and max
  void constrainLength(Bob b, float minlen, float maxlen) {
    PVector dir = PVector.sub(b.position, anchor);
    float d = dir.mag();
    // Is it too short?
    if (d < minlen) {
      dir.normalize();
      dir.mult(minlen);
      // Reset position and stop from moving (not realistic physics)
      b.position = PVector.add(anchor, dir);
      b.velocity.mult(0);
      // Is it too long?
    } 
    else if (d > maxlen) {
      dir.normalize();
      dir.mult(maxlen);
      // Reset position and stop from moving (not realistic physics)
      b.position = PVector.add(anchor, dir);
      b.velocity.mult(0);
    }
  }
}

class Bob {
  
   PVector position;
   PVector velocity;
   PVector acceleration;
   float mass = 24;
   
   float damping = .98; // arbitrary damping to simulate friciton / drag
   
   PVector dragOffset;
   boolean dragging = false;
   
   Bob(float x, float y) {
     position = new PVector(x, y);
     velocity = new PVector();
     acceleration = new PVector();
     dragOffset = new PVector();
   }
   
   void update() {
     velocity.add(acceleration);
     velocity.mult(damping);
     position.add(velocity);
     acceleration.mult(0);
   }
   
   // newtons law F = M*A or A = F / M
   void applyForce(PVector force) {
     PVector f = force.get();
     f.div(mass);
     acceleration.add(force);
   }
   
   void display() {
     stroke(0);
     strokeWeight(2);
     fill(175);
     if(dragging) {
       fill(50);
     }
     ellipse(position.x, position.y, mass * 2, mass * 2);
   }
   
   void clicked(int mx, int my) {
     float d = dist(mx, my, position.x, position.y);
     if( d < mass) {
       dragging = true;
       dragOffset.x = position.x - mx;
       dragOffset.y = position.y - my;
     }
   }
   
   void stopDragging() {
     dragging = false;
   }
   
   void drag(int mx, int my) {
     if(dragging) {
       position.x = mx + dragOffset.x;
       position.y = my + dragOffset.y;
     }
   }

}


// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Mover object
Bob bob;

// Spring object
Spring spring;

void setup() {
  size(640,360);
  // Create objects at starting position
  // Note third argument in Spring constructor is "rest length"
  spring = new Spring(width/2,10,100); 
  bob = new Bob(width/2,100); 

}

void draw()  {
  background(155); 
  // Apply a gravity force to the bob
  PVector gravity = new PVector(0,2);
  bob.applyForce(gravity);
  
  // Connect the bob to the spring (this calculates the force)
  spring.connect(bob);
  // Constrain spring distance between min and max
  spring.constrainLength(bob,30,200);
  
  // Update bob
  bob.update();
  // If it's being dragged
  bob.drag(mouseX,mouseY);
  
  // Draw everything
  spring.displayLine(bob); // Draw a line between spring and bob
  bob.display(); 
  spring.display(); 
  
  fill(0);
  text("click on bob to drag",10,height-5);
}


// For mouse interaction with bob

void mousePressed()  {
  bob.clicked(mouseX,mouseY);
}

void mouseReleased()  {
  bob.stopDragging(); 
}
