class Pixels extends Shape {
  
  ArrayList pixels;
  int w,h;
  float scale = 50;

   Pixels (int w, int h) {
     
    super();
    
    this.w = w;
    this.h = h;
    
    init();
    
  }

  void init() {

    pixels = new ArrayList();
    for(int i = 0; i<this.w; i++ ) {
     
     for(int j = 0; j<this.h; j++ ) {
      
         Pixel px = new Pixel(this);
         px.setPositions(i, j);
         pixels.add(px);
       
     } 
     
    }
      
  }

  

  // get bounding box
  Rectangle getBBox() {
    
    return new Rectangle(pos.x, pos.y, this.w * scale , this.h * scale) ;
    
  }
  
  ArrayList getPixels() {
      return pixels;
  }
  
  void drawBBox () {
     
      noFill();
      fill(0);
      stroke(255);
      Rectangle bbox = getBBox();
      rect(bbox.x - 2, bbox.y - 2, bbox.width + 4, bbox.height + 4);
    
  }
  
  void draw2D() {
    
    fill(0,255,0);
    Rectangle r = getBBox();
    rect(r.x, r.y, r.width, r.height);
    
    for ( int i=0; i < pixels.size(); i++) {
      Pixel px = (Pixel) pixels.get(i);
      px.draw();
    }
  }
}



class Pixel extends Shape {
  
 float scale = 60;
 Pixels mom;
  
 Pixel(Pixels mom) {
   
   this.mom = mom;
   
 } 
 
void setPositions(int x, int y) {
    pos.set(x,y, 0.0);
  }
  
  void draw() {
    
   rect(pos.x*mom.scale, pos.y*mom.scale, mom.scale/2, mom.scale/2);
     
    /*
    beginShape(POINTS);
    vertex(pos.x, pos.y);
    endShape(POINTS);    
    */
  }
  
  
  
}

