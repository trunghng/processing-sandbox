ArrayList<Particle> particles;

void setup() {
  randomSeed(0);
  size(640, 480);
  particles = new ArrayList<Particle>();
  for (int i=0;i<100;i++){
    particles.add(new Particle(random(width), random(height)));
  }
}

void draw() {
  background(255);
  PVector mouse = new PVector(mouseX, mouseY);
  
  for (Particle p : particles) {
    p.seekSeparate(particles, mouse);
    p.run();
  }
}
