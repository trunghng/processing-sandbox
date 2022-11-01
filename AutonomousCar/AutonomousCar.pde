Car car;
float d = 25;
char prevKey = ' ';
FlowField field;
Path path;

void setup() {
  size(640, 480);
  car = new Car(width/2, height/2);
  field = new FlowField();
  path = new Path();
}

PVector drawMouse() {
  PVector mouse = new PVector(mouseX, mouseY);
  fill(120);
  stroke(0);
  strokeWeight(2);
  ellipse(mouse.x, mouse.y, 20, 20);
  return mouse;
}

void drawWalls() {
  stroke(175);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, width-d*2, height-d*2);
}

void seekSteering() {
  PVector mouse = drawMouse();
  car.seek(mouse);
  car.run();
}

void arriveSteering() {
  PVector mouse = drawMouse();
  car.arrive(mouse);
  car.run();
}

void avoidWallSteering() {
  drawWalls();
  car.avoidWall();
  car.run();
}

void followFlowField() {
  car.follow(field);
  car.run();
}

void followPath() {
  path.display();
  car.follow(path);
  car.run();
}

void draw() {
  background(255);
  if (key == '1') {
    seekSteering();
    prevKey = key;
  } else if (key == '2') {
    arriveSteering();
    prevKey = key;
  } else if (key == '3') {
    if (prevKey != key) {
      car.resetVelocity();
    }
    avoidWallSteering();
    prevKey = key;
  } else if (key == '4'){
    followFlowField();
    prevKey = key;
  } else {
    followPath();
    prevKey = key;
  }
}
