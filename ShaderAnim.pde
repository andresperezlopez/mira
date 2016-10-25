class ShaderAnim extends AbstractAnimation {

  Minim minim;
  AudioInput in;

  PImage tex;
  PShader deform;


  ShaderAnim(PGraphics canvas, PApplet app) {
    super(canvas, app);

    minim = new Minim(app);
    in = minim.getLineIn(Minim.STEREO, 512);
    
    canvas.textureWrap(REPEAT);
    tex = loadImage("tex1.jpg");
 
    deform = loadShader("deform.glsl");
    deform.set("resolution", float(width), float(height));
    
  } 

  void draw() {
    super.draw();

    float son = in.mix.level();

    float bass = in.mix.get(100);
    float mid = in.mix.get(256);
    float high = in.mix.get(500);
    
    deform.set("time", millis() / 1000.0);
    deform.set("mouse", float(mouseX) * son * 10.0, float(mouseY));
    canvas.shader(deform);
    canvas.image(tex, 0, 0, width, height);
  }

  void keyPressed(int key) {
    //println("Kikoo");
  }
}

