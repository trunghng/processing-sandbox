Car car;
float d = 25;

void setup() {
  size(640, 480);
  car = new Car(width/2, height/2);

}

void draw() {
  background(255);
  //PVector mouse = new PVector(mouseX, mouseY);
  
  //fill(120);
  //stroke(0);
  //strokeWeight(2);
  //ellipse(mouse.x, mouse.y, 20, 20);
  stroke(175);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, width-d*2, height-d*2);
  
  //car.seek(mouse);
  //car.arrive(mouse);
  car.avoidWall();
  car.update();
  car.display();
}
