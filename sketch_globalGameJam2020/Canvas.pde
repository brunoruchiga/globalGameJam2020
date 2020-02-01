class Canvas {
  float x, y, w, h;
  boolean debug = false;

  Canvas(float ratio) {
    if (height*ratio>width) {
      //vertical screen
      w = width;
      h = w/ratio;

      x = 0;
      y = height/2 - h/2;
    } else {
      //horizontal screen
      h = height;
      w = h*ratio;

      y = 0;
      x = width/2 - w/2;
    }
  }

  void debug() {
    if (debug) {
      noFill();
      stroke(255, 255, 0);
      strokeWeight(1);

      rect(x, y, w-1, h-1);
    }
  }

  void debugGrid() {
    for (int i = 0; i <= floor(w/em); i++) {
      for (int j = 0; j <= floor(h/em); j++) {
        stroke(200);
        noFill();
        rect(i*em, j*em, em, em);

        //fill(0);
        //textFont(font);
        //textSize(em/5);
        //textAlign(LEFT, TOP);
        //text("(" + i + "," + j + ")", i*em, j*em);
      }
    }
  }

  void begin() {
    translate(x, y);
  }

  void end() {
    translate(-x, -y);
  }
}
