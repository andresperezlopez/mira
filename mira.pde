import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.video.*;
import dmxP512.*;
import processing.serial.*;
import processing.opengl.*;
import controlP5.*;

// gui
GuiManager gui;
AnimationsManager animationsManager;
Pixels pixels;

// will be the reference of the texture
PImage tex;

// we declare the DMX library 
DmxP512 dmxOutput;
int     universeSize     = 512;
String  DMXPRO_PORT      = "/dev/tty.usbserial-EN129078";
int     DMXPRO_BAUDRATE  = 115000;

boolean bDrawTexture = false;
boolean bInverse     = false;

void setup () {

  size(1024, 768, OPENGL);
  noSmooth();
  frameRate(31);
  
  // we init the our pixels manager
  pixels = new Pixels(8, 6);
  Rectangle bbox = pixels.getBBox();

  // we init the the animation manager, we set a canvas for the texture ( used for size )
  // init the animations and set the first one as default

  animationsManager = new AnimationsManager(this);
  animationsManager.setAnimations();
  
  gui = new GuiManager(this);
  
  //we init the serial DMX connection
  Serial myPort;
  println(Serial.list());
  dmxOutput=new DmxP512(this, universeSize, false);
 // dmxOutput.setupDmxPro(DMXPRO_PORT, DMXPRO_BAUDRATE);
  
  
}

    //pixel sampler

    int samplePxBrightness(PImage image, int pxx, int pxy, int rows, int cols, int subdivider, boolean average) {
        int rowOffset = image.width / rows;
        int colOffset = image.height / cols;
        int maxBright = 0;
        int ySize = Math.max(1, colOffset / subdivider);
        int xSize = Math.max(1, rowOffset / subdivider);
        long sum = 0;


        for(int y = 0; y < ySize; y++ ){
            int yoffset = pxy * colOffset + (colOffset - ySize) / 2 + y;

            for(int x = 0; x < xSize; x++) {
                int xoffset = pxx * rowOffset + (rowOffset - xSize) / 2 + x;
                int pxBrightness = (int) brightness(image.get(xoffset, yoffset));

                maxBright = pxBrightness > maxBright ? pxBrightness : maxBright;
                sum += pxBrightness;
            }
        }

        if(average) {
            return (int) (sum / (ySize * xSize));
        }

        return maxBright;
    }



void draw() {

  // clear background color
  background(0);

  // We store our animation as a graphic texture and get it
  animationsManager.prepass();
  tex = animationsManager.getCanvasAsTexture();


  // if there's something wrong with the texture, stop.
  if (tex == null) return;

  // we center everything in middle
  pushMatrix();


  if (bDrawTexture) {
    
    
    translate( width *.5 + (int)(- animationsManager.currentAnim.w * .5), height * .5 + (int)(- animationsManager.currentAnim.h * .5));
    image(tex, 0, 0);
    
  } else {

    tex.resize((int)pixels.w, (int)pixels.h);
    translate( width *.5 + (int)(- pixels.getBBox().width * .5), height * .5 + (int)(- pixels.getBBox().height * .5));
    fill(255);
    tex.resize((int)pixels.w, (int)pixels.h);
    pixels.drawBBox();
    stroke(0);
    strokeWeight(2.0);
     
    for ( int i=0; i< pixels.getPixels ().size(); i++) {

      // get pixels stored
      Pixel px = (Pixel) pixels.getPixels().get(i);

      // get position 
      int x = (int)px.pos.x;
      int y = (int)px.pos.y;

      // now we read the colors of the pixels, and we draw the pixels again
       float r = red(tex.get(x, y));
       float g = green(tex.get(x, y));
       float b = blue(tex.get(x, y));
       float a = alpha(tex.get(x, y));
       px.col = color(r, g, b, a);
      
      int br = (int)brightness(tex.get(x, y));
      //int br = samplePxBrightness(tex, x, y, 8, 6, 2, true);

      if(bInverse)
        br = 255 - br;
      //stroke(r, g, b, a);
      fill(br);



      px.draw();
    }

}

  popMatrix();

 
  int count = 0;
   for(int i =0; i<8; i++ ) {
       
      for(int j=0; j<6; j++ ) {
        
        int index  =  j * 8 + i;
        
         Pixel px = (Pixel) pixels.getPixels().get(count);
        int x = (int)px.pos.x;
        int y = (int)px.pos.y;

    // for the dmx we just need the brightness ( grayscale )
        int br = (int)brightness(tex.get(x, y));
        if(bInverse)
        br = 255 - br;
    // send to DMX
    //int channel = 350 + i;
      int channel  = 350 + j * 8 + i;
      
    
    //println("set level " + channel);
        dmxOutput.set(channel, br);
        
        count++;
      }
      
   }
  


}
void keyPressed () {

  if (key == 't') 
    bDrawTexture = !bDrawTexture; 

  if (key == ' ') 
    animationsManager.nextAnimation();

  animationsManager.keyPressed(key);
}

void movieEvent(Movie m) {
  m.read();
}



public void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName() == "SHOW PREVIEW") 
    bDrawTexture = !bDrawTexture;
    
     if (theEvent.getController().getName() == "INVERSE") 
    bInverse = !bInverse;
    
}

