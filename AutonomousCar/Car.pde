class Car {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxForce;

  float r;
  final PVector v = new PVector(-6, 3);

  Car(float x, float y) {
    location = new PVector(x, y);
    velocity = v.copy();
    acceleration = new PVector(0, 0);
    maxSpeed = 3;
    maxForce = 0.1;
    r = 4;
  }
  
  void resetVelocity() {
    velocity = v.copy();
  }

  // Seek steering
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);
    desired.normalize().mult(maxSpeed);
    steering(desired);
  }

  // Arrive steering
  void arrive(PVector target) {
    PVector desired = PVector.sub(target, location);
    float d = desired.mag();
    desired.normalize();

    if (d<100) {
      float m = map(d, 0, 100, 0, maxSpeed);
      desired.mult(m);
    } else {
      desired.mult(maxSpeed);
    }
    steering(desired);
  }
  
  // Avoid walls steering
  void avoidWall() {
    PVector desired = null;
    if (location.x < d) {
      desired = new PVector(maxSpeed, velocity.y);
    } else if (location.x > width - d) {
      desired = new PVector(-maxSpeed, velocity.y);
    }
    
    if (location.y < d) {
      desired = new PVector(velocity.x, maxSpeed);
    } else if (location.y > height - d) {
      desired = new PVector(velocity.x, -maxSpeed);
    }
    
    if (desired != null) {
      desired.normalize().mult(maxSpeed);
      steering(desired);
    }
  }
  
  // flow-field following
  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxSpeed);
    steering(desired);
  }
  
  void steering(PVector desired) {
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}
