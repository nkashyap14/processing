/*
Assigns a random color to every pixel of a window randomly
loadPixels();
for (int x = 0; x < width; x++) {
  for (int y = 0; y < height; y++) {
    float bright = random(255);
    pixels[x+y*width] = color(bright); // assigns random brightness
  }
}

updatePixels();
*/ 

//float bright = map(noise(x, y), 0,1, 0, 255); maps a new brightness value for each pixel which changes by x and y values. gives you a noise value for every x and y in our two dimensional space.
//problem with above statement is you are incrementing by one every time you increase the x, y values which is a sizeable jump through noise

// solution is to use different variables

size(640, 280);
loadPixels();
float xoff = 0.0;
for(int x = 0; x < width; x++) {
  float yoff = 0.0;
  
  for(int y = 0; y < height; y++) {
    float bright = map(noise(xoff, yoff), 0, 1, 0, 255);
    pixels[x + y * width] = color(bright);
    yoff += 0.1;
  }
  xoff += 0.1;
}
updatePixels();
