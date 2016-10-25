class SnakeAnimation extends AbstractAnimation {

 int  total;
 float count, speed;

  SnakeAnimation(PGraphics canvas, PApplet app) {
    super(canvas, app);
    
    this.size(8, 6);
    
    count = 0;
    total = 8 * 6;
    speed = 1.8;
    
  } 

  void draw() {
    super.draw();
  
    canvas.stroke(255);
    canvas.noStroke();
    canvas.fill(255);
    
    int index = 0;
    for(int i =0; i<8; i++ ) {
       
      for(int j=0; j<6; j++ ) {
       
        //index = j * 8 + i;
        
        if(index < (int)count ) {
           canvas.rect(i,j,1,1); 
        }
         
        index++;
        
      }
      
    }
    
     
      
    
    
    count += speed;
    if(count > total) 
          count = 0;
    
    
    // canvas.rect(0,0, 30, 30);; 
    
  }

  void keyPressed(int key) {
    //println("Kikoo");
  }
}

