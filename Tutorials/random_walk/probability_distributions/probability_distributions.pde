import java.util.Random;
//int [] randomCounts;
Random generator;


void setup() {
  size(640, 240);
  //randomCounts = new int[20];
  generator = new Random();
}

void draw() {
  /*
  background(255);
  
  int index = int(random(randomCounts.length));
  randomCounts[index]++;

  stroke(0);
  fill(175);
  int w = width/ randomCounts.length;
  
  for(int x = 0; x < randomCounts.length; x++) {
    rect(x*w, height - randomCounts[x], w-1, randomCounts[x]);
  }
  */
  
  float num = (float) generator.nextGaussian();
  
  float sd = 60;
  float mean = 230;
  float x = sd * num + mean; // in order to adjust to a normal distribution based around the mean and standard deviation I want.
  
  
  noStroke();
  fill(255, 10);
  ellipse(x, 180, 16, 16);
  
}
