class Menu {
  Button save, reset, animate, unPin, showSpirals, test;
  Menu() {
    save=new Button("Save", 0, 600);
    reset=new Button("Reset", 0, 700);
    animate=new Button("Animate", 200, 600);
    unPin=new Button("Unpin", 200, 700);
    showSpirals=new Button("Show Spirals", 400, 600);
    test=new Button("Test", 400, 700);
  }
  void draw() {
    save.draw();
    reset.draw();
    animate.draw();
    unPin.draw();
    showSpirals.draw();
    test.draw();
  }
  void buttonPressed(MotionEvent me) {
//    if (save.pressed(me)) {
//      turboWarp.save=true;
//    }
//    if (reset.pressed(me)) { //Remove all pins
//      turboWarp.reset=true;
//    }
//    if (showSpirals.pressed(me)) {
//      turboWarp.showSpirals=!turboWarp.showSpirals;
//    }
//    if (unPin.pressed(me)) {
//      turboWarp.unPin=!turboWarp.unPin;
//    }
    if (animate.pressed(me)) {
      WARPIC.animate=!WARPIC.animate;
//      WARPIC.animatePressed=true;
    }
//    if (test.pressed(me)) {
//      turboWarp.test=!turboWarp.test;
//      turboWarp.drawMenu=false;
   // }
  }
}

