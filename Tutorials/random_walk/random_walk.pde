class Walker {
  
  int x;
  int y;
  
  Walker() {
    x = width / 2;
    y = height / 2;
  }
  
  void display() {
    stroke(0);
    point(x, y);
  }
  
  void step() {
    //int stepx = int(random(3)) - 1;
    //int stepy = int(random(3)) - 1;
    
    // alternative option
    //float stepx = random(-2, 2);
    //float stepy = random(-2, 2);
    //x += stepx;
    //y += stepy;
    float r = random(1);
    if (r < 0.4) {
      x++;
    }
    else if (r < 0.6) {
      x--;
    }
    else if (r < 0.8) {
      y++;
    }
    else {
      y--;
    }
    
  }
}


Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}
