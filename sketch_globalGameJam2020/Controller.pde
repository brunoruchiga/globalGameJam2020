class Controller {
  boolean mouseReleased;
  boolean up, right, down, left;
  PVector direction;
  boolean debug = false;

  Controller() {
    clearInputs();
    direction = new PVector();
  }

  void handleKeyChanged(int k, boolean pressedState) {
    changeKeyPressed(k, pressedState);
    updateDirection();
  }

  boolean changeKeyPressed(int k, boolean pressedState) {
    switch (k) {
    case LEFT:
      return left = pressedState;
    case RIGHT:
      return right = pressedState;
    case UP:
      return up = pressedState;
    case DOWN:
      return down = pressedState;

    case 65: //a
      return left = pressedState;
    case 68: //d
      return right = pressedState;
    case 87: //w
      return up = pressedState;
    case 83: //s
      return down = pressedState;

    default:
      return pressedState;
    }
  }

  void clearInputs() {
    mouseReleased = false;
  }

  void updateTouch() {
    if (mobileBuild) {
      if (mousePressed) {
        if (mouseX > width/2) {
          right = true;
        } else {
          left = true;
        }
      } else {
        right = false;
        left = false;
      }
    }
    
    multiTouchHandle();
  }

  void multiTouchHandle() {
    //if (right) {
    //  for (int i = 0; i < touches.length; i++) {
    //    if (touches[i].x < width/2) {     
    //      left = true;
    //      right = false;
    //    }
    //  }
    //} else {
    //  for (int i = 0; i < touches.length; i++) {
    //    if (touches[i].x > width/2) {     
    //      left = false;
    //      right = true;
    //    }
    //  }
    //}
    //if (left) {
    //  for (int i = 0; i < touches.length; i++) {
    //    if (touches[i].x > width/2) {     
    //      left = false;
    //      right = true;
    //    }
    //  }
    //} else {
    //  for (int i = 0; i < touches.length; i++) {
    //    if (touches[i].x < width/2) {     
    //      left = true;
    //      right = false;
    //    }
    //  }
    //}
    //if (touches.length == 0) {
    //  left = false;
    //  right = false;
    //}



    //right = false;
    //left = false;
    //for (int i = 0; i < touches.length; i++) {
    //  if (touches[i].x > width/2) {
    //    right = true;
    //  }
    //  if (touches[i].x < width/2) {     
    //    left = true;
    //  }
    //}
  }

  void displayTouch() {
    float margin = 1.5*em;
    float w = 3*em;
    float h = 4*em;
    pushMatrix();
    {
      translate(0, 0, 4);
      noStroke();
      if (left) {
        fill(255);
      } else {
        fill(128);
      }
      //rect(margin, canvas.h - size - margin, size, size);
      //left arrow
      beginShape();
      {
        vertex(margin, height - margin - h/2);
        vertex(margin + w, height - margin - h);
        vertex(margin + w, height - margin);
      }
      endShape();
      if (right) {
        fill(255);
      } else {
        fill(128);
      }
      //right arrow
      beginShape();
      {
        vertex(width - margin, height - margin - h/2);
        vertex(width - margin - w, height - margin - h);
        vertex(width - margin - w, height - margin);
      }
      endShape();
    }
    popMatrix();
  }

  void updateDirection() {
    direction.set(0, 0);
    if (right) {
      direction.x += 1;
    }
    if (left) {
      direction.x -= 1;
    }
    if (up) {
      direction.y -= 1;
    }
    if (down) {
      direction.y += 1;
    }
  }

  void debug() {
    if (debug) {
      String s = "[Controller] ";
      s = s + direction;
      if (mousePressed) {
        s = s + " mousePressed";
      }
      if (mouseReleased) {
        s = s + " mouseReleased";
      }
      println(s);
    }
  }
}

void mouseReleased() {
  controller.mouseReleased = true;
  //saveFrame(floor(random(100)) + "######");
}

void keyPressed() {
  controller.handleKeyChanged(keyCode, true);
}

void keyReleased() {
  controller.handleKeyChanged(keyCode, false);
}
