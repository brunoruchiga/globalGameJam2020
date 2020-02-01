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

  //void updateTouch() {
  //  if (mousePressed) {
  //    if (mouseX > width/2) {
  //      right = true;
  //    } else {
  //      left = true;
  //    }
  //  } else {
  //    right = false;
  //    left = false;
  //  }
  //}

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
}

void keyPressed() {
  controller.handleKeyChanged(keyCode, true);
}

void keyReleased() {
  controller.handleKeyChanged(keyCode, false);
}
