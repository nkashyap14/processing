/*
float t = 0;

void setup() {
  size(640, 260);
}

void draw() {
  float n = noise(t);
  float x = map(n,0,1,0,width);
  ellipse(x, 180, 16, 16);
  
  t += 0.01;
}
*/

class Walker {
  float x, y;
  
  float tx, ty;
  
  Walker() {
    tx = 0;
    ty = 10000;
  }
  
  void step() {
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
    
    tx += 0.01;
    ty += 0.01;
  }
}
Walker walk;

void setup() {
  size(640, 280);
  walk = new Walker();
}


void draw() {
  ellipse(walk.x, walk.y, 16, 16);
  walk.step();
}
