class AbstractAnimation {
  
  PApplet app;
  PGraphics canvas;
  int w, h;
  
  AbstractAnimation (PGraphics canvas, PApplet app) {
    
    this.canvas   = canvas;
    this.canvas.noSmooth();
    this.app     = app;
    size(width, height);
    
  }
  
  void size(int w, int h) {
     
       this.w = w;
       this.h = h; 
    
  }
  
  void draw() {
  }
  
  void keyPressed(int key) {
  }
  
}

