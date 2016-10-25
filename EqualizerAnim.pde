class EqualizerAnim extends AbstractAnimation {

  Minim minim;
  AudioInput in;

  EqualizerAnim(PGraphics canvas, PApplet app) {
    
    super(canvas, app);
    this.size(640, 480);

    minim = new Minim(app);
    in = minim.getLineIn(Minim.STEREO, 512);
    
  } 

  void draw() {
    
    super.draw();

    float level = in.mix.level();
    canvas.stroke(255);
    canvas.noStroke();
    canvas.fill(255);

    canvas.rect(0, height, width, -height * level * 5.0);  

  }

  void keyPressed(int key) {
  }
}

