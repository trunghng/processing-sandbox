class Boid {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float maxSpeed;
  float maxForce;
  float radius;

  Boid(float x, float y) {
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

  PVector separate(ArrayList<Boid> boids) {
    float separateRadius = this.radius * 2;
    int count = 0;
    PVector sum = new PVector();

    for (Boid other : boids) {
      float distance = PVector.dist(this.location, other.location);
      if (distance > 0 && distance < separateRadius) {
        count++;
        PVector diff = PVector.sub(this.location, other.location);
        diff.normalize().div(distance);
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

  PVector cohesion(ArrayList<Boid> boids) {
    float neighborRadius = 50;
    int count = 0;
    PVector sum = new PVector();

    for (Boid other : boids) {
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

  PVector align(ArrayList<Boid> boids) {
    float neighborRadius = 50;
    int count = 0;
    PVector sum = new PVector();
    for (Boid other : boids) {
      float distance = PVector.dist(this.location, other.location);
      if (distance < neighborRadius) {
        count++;
        sum.add(other.velocity);
      }
    }
    if (count > 0) {
      sum.div(boids.size());
      sum.setMag(this.maxSpeed);
      sum.sub(this.velocity);
      sum.limit(this.maxForce);
    }
    return sum;
  }

  void flock(ArrayList<Boid> boids) {
    PVector separate = this.separate(boids);
    PVector align = this.align(boids);
    PVector cohesion = this.cohesion(boids);

    separate.mult(1.5);
    align.mult(1);
    cohesion.mult(1);

    applyForce(separate);
    applyForce(align);
    applyForce(cohesion);
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

  void display() {
    fill(175);
    stroke(0);
    pushMatrix();
    translate(this.location.x, this.location.y);
    ellipse(0, 0, this.radius, this.radius);
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

  void run(ArrayList<Boid> boids) {
    this.flock(boids);
    this.update();
    this.borders();
    this.display();
  }
}
