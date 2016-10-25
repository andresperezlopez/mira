class SimpleAnim extends AbstractAnimation {

  PFont font;
  //Cogito-Black.otf
  
  SimpleAnim(PGraphics canvas, PApplet app) {
    super(canvas, app);
    this.size(40, 26);
    // hello change
    font = loadFont("Cogito-Black-48.vlw");
  } 

  void draw() {
    super.draw();

    canvas.rectMode(CENTER);
    canvas.background(255);
    canvas.fill(0);
    //canvas.rect(0, mouseY, 640, 100);
    //canvas.  
    
    canvas.textFont(font, 32);
    canvas.text("A", 10, 24);

}
}

