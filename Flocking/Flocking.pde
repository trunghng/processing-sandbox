Flock flock;

void setup() {
  size(640, 540);
  flock = new Flock();
  
  for (int i=0; i<100; i++) {
    flock.addBoid(new Boid(width/2, height/2));
  }
}

void draw() {
  background(255);
  flock.run();
}
