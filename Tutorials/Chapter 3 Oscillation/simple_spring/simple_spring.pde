class Pendulum {
  float length_of_arm;
  float angle; // angle of arm
  float aVelocity; // angle velocity
  float aAcceleration; // angle acceleration
  float damping;
  PVector location;
  PVector origin;
  
  void update() {
    float gravity = 0.4;
    aAcceleration = (-1 * gravity / length_of_arm) * sin(angle);
    aVelocity += aAcceleration;
    angle += aVelocity;
    aVelocity *= damping;
  }
  
  Pendulum(PVector origin_, float length_of_arm_) {
    origin = origin_.get();
    location = new PVector();
    length_of_arm = length_of_arm_;
    angle = PI/4;
    aVelocity = 0.0;
    aAcceleration = 0.0;
    damping = .995; // arbitrary damping that ensures the Pendulum slows over time
  }
  
  void go() {
    update();
    display();
  }
  
  void display() {
    location.set(length_of_arm * sin(angle), length_of_arm * cos(angle), 0); // converting from polar coordinates (i have radius and the theta/angle) and i want to get cartesian coordinates
    location.add(origin);
    stroke(0);
    line(origin.x, origin.y, location.x, location.y);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
}

Pendulum p;

void setup() {
  size(200, 200); 
  p = new Pendulum(new PVector(width/2, 10), 125);
}

void draw() {
  background(255);
  p.go();
}
