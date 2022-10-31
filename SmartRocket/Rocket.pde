class Rocket { // Phenotype
  
  DNA dna;
  float fitness;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  int geneCounter = 0;
  boolean hitTarget = false;
  float r;
  
  Rocket() {
    acceleration = new PVector();
    velocity = new PVector();
    location = new PVector(width/2, height+20);
    r = 4;
    dna = new DNA();
  }
  
  Rocket(DNA dna_) {
    acceleration = new PVector();
    velocity = new PVector();
    location = new PVector(width/2, height+20);
    r = 4;
    dna = dna_;
  }
  
  Rocket(PVector loc, DNA dna_) {
    acceleration = new PVector();
    velocity = new PVector();
    location = loc;
    r = 4;
    dna = dna_;
  }
  
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  void fitness() {
    float d = PVector.dist(location, target);
    fitness = pow(1/d, 2);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void run() {
    checkHit();
    if (!hitTarget) {
      applyForce(dna.genes[geneCounter]);
      geneCounter++;
      update();
    }
    display();
  }
  
  void display() {
    float theta = velocity.heading() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);

    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    // Rocket body
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();

    popMatrix();
  }
  
  void checkHit() {
    float d = PVector.dist(location, target);
    if (d < 12) {
      hitTarget = true;
    }
  }
  
  DNA getDNA() {
    return dna;
  }
  
  float getFitness() {
    return fitness;
  }
}
