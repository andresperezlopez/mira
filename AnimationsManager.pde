class AnimationsManager {

  PApplet app;
  
  ArrayList anims;
  PGraphics canvas;
  AbstractAnimation currentAnim;
  
  int animIndex = 0;

  AnimationsManager(PApplet app) {
    
     this.app = app;
     
  } 
  
  void setAnimations () {
    canvas   = createGraphics(width,height,OPENGL);
    
    anims = new ArrayList();
    anims.add( new SimpleAnim(canvas, app));
    anims.add( new SnakeAnimation(canvas, app));
    anims.add( new EqualizerAnim(canvas, app));
    anims.add( new ShaderAnim(canvas, app));
    anims.add( new MovieAnim(canvas, app));
    anims.add( new StrobAnim(canvas, app));
    
    setAnimation(0);
   
  }
  
  void updateCanvas () {
    
    canvas   = createGraphics(currentAnim.w,currentAnim.h,OPENGL);
    canvas.noSmooth();
    currentAnim.canvas = canvas;
    
  }

  void setAnimation(int index) {
    
    animIndex = index;
    currentAnim = (AbstractAnimation) anims.get(animIndex);
    updateCanvas();
    
  }
  
  void nextAnimation() {
    
    animIndex++;
    if(animIndex > anims.size()-1) animIndex = 0;
    setAnimation(animIndex);
    
  }

  void prepass() {
   
    canvas.beginDraw();
    canvas.background(0);
    currentAnim.draw();
    canvas.endDraw();
    
  }
  
  
  PImage getCanvasAsTexture () {
    canvas.loadPixels();
    return canvas.get();
  }
  
  
  void keyPressed(int key) {
    currentAnim.keyPressed(key);
  }
  
}

