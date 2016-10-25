class StrobAnim extends AbstractAnimation {

  
  StrobAnim(PGraphics canvas, PApplet app) {
    super(canvas, app);
  } 

  void draw() {
    super.draw();
  
    //shapeMode(CENTER);
    if(millis() % 3 == 0 ) {
    canvas.fill(random(255),random(255),random(255));
    canvas.stroke(random(255),random(255),random(255));
    canvas.rect(0,0,canvas.width, canvas.height);
    }
    
  }
}

