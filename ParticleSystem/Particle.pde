class Particle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float maxSpeed;
  float maxForce;
  float radius;
  
  Particle(float x, float y) {
    this.location = new PVector(x, y);
    this.maxSpeed = 3;
    this.maxForce = 0.2;
    this.radius = 12;
    this.velocity = PVector.random2D().setMag(this.maxSpeed);
    this.acceleration = new PVector(0, 0);
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, this.location);
    desired.setMag(this.maxSpeed);
    PVector steer = PVector.sub(desired, this.velocity);
    steer.limit(this.maxForce);
    return steer;
  }
  
  PVector separate(ArrayList<Particle> particles) {
    float separateRadius = this.radius * 2;
    int count = 0;
    PVector sum = new PVector();
    
    for (Particle other : particles) {
      float distance = PVector.dist(this.location, other.location);
      if (distance > 0 && distance < separateRadius) {
        count++;
        PVector diff = PVector.sub(this.location, other.location);
        diff.normalize();
        diff.div(distance);
        sum.add(diff);
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.setMag(this.maxSpeed);
      sum.sub(this.velocity);
      sum.limit(this.maxForce);
    }
    return sum;
  }
  
  void seekSeparate(ArrayList<Particle> particles, PVector target) {
    PVector separate = separate(particles);
    PVector seek = seek(target);
    separate.mult(2);
    seek.mult(1);
    applyForce(separate);
    applyForce(seek);
  }
  
  PVector cohesion(ArrayList<Particle> particles) {
    float neighborRadius = 50;
    int count = 0;
    PVector sum = new PVector();
    
    for (Particle other : particles) {
      float distance = PVector.dist(this.location, other.location);
      if (distance > neighborRadius && distance > 0) {
        count++;
        sum.add(other.location);
      }
    }
    if (count > 0) {
      sum.div(count);
    }
    return seek(sum);
  }
  
  void cohesionSeparate(ArrayList<Particle> particles) {
    PVector cohesion = cohesion(particles);
    PVector separate = separate(particles);
    cohesion.mult(1.2);
    separate.mult(2);
    applyForce(cohesion);    
    applyForce(separate);
  }
  
  void applyForce(PVector force) {
    this.acceleration.add(force);
  }
  
  void update() {
    this.velocity.add(this.acceleration);
    this.velocity.limit(this.maxSpeed);
    this.location.add(this.velocity);
    this.acceleration.mult(0);
  }
  
  void display(){
    fill(175);
    stroke(0);
    pushMatrix();
    translate(location.x, location.y);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }

  void borders() {
    if (this.location.x < -this.radius)
      this.location.x = width + this.radius;
    if (this.location.y < -this.radius)
      this.location.y = height + this.radius;
    if (this.location.x > width + this.radius)
      this.location.x = -this.radius;
    if (this.location.y > height + this.radius)
      this.location.y = -this.radius;
  }
  
  void run() {
    this.update();
    this.borders();
    this.display();
  }
}
