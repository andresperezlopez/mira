class GuiManager {

  PApplet app;
  ControlP5 cp5;

  GuiManager (PApplet app) {

    this.app = app;
    init();
    
  }

  public void init () {

    cp5 = new ControlP5(app);

    cp5.addButton("WORKSHOP MIRA  LIGHT VS PIXELS")
      .setValue(0)
        .setPosition(0, 0)
          .setSize(width, 20)
            ;
    cp5.addButton("SHOW PREVIEW")
      .setPosition(0, 21)
        .setSwitch(true)
          .setSize(100, 20);
          
 cp5.addButton("INVERSE")
      .setPosition(0, 42)
        .setSwitch(true)
          .setSize(100, 20);
          
  }
}

