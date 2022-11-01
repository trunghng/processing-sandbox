Car car;
float d = 25;
char prevKey = ' ';

void setup() {
  size(640, 480);
  car = new Car(width/2, height/2);

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

void draw() {
  background(255);
  
  if (key == '1') {
    seekSteering();
    prevKey = key;
  } else if (key == '2') {
    arriveSteering();
    prevKey = key;
  } else {
    if (prevKey != key) {
      car.resetVelocity();
    }
    avoidWallSteering();
    prevKey = key;
  }
}
