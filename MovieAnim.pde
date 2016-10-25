class MovieAnim extends AbstractAnimation {

  Movie movie; 

  MovieAnim(PGraphics canvas, PApplet app) {
    super(canvas, app);
    
    movie = new Movie(app, "fingers.mov");
    movie.play();
    this.size(320, 240);
    movie.loop();
    
  } 

  void draw() {
    
    super.draw();
    canvas.image(movie, 0,0);

  }
 
}

