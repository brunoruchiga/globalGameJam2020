class Menu {
  Button playButton = new Button(2*em, 8*em, 12*em, 8*em, "play"); 
  Button settingsButton = new Button(2*em, 17*em, 12*em, 3*em, "settings");

  void update() {
    if (playButton.confirmed()) {
      state.goTo(state.GAME);
    }
    if (settingsButton.confirmed()) {
    }
  }
}

class Button {
  float x, y, w, h;
  float timer;
  String textKey;

  Button(float x_, float y_, float w_, float h_, String _textKey) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    textKey = _textKey;

    timer = 0;
  }

  boolean confirmed() {
    display();
    return (hover() && controller.mouseReleased);
  }

  boolean pressed() {
    return (hover() && mousePressed);
  }

  boolean hover() {
    return (mouseX - canvas.x > x && mouseX - canvas.x < x+w && mouseY - canvas.y > y && mouseY - canvas.y < y+h);
  }

  void display() {
    debug();
  }

  void debug() {
    stroke(255);
    strokeWeight(1);    

    if (pressed()) {
      fill(255, 128);
    } else if (hover()) {
      fill(255, 56);
    } else {
      noFill();
    }
    rect(x, y, w, h);

    textAlign(CENTER, CENTER);
    fill(255);
    textFont(fontSmall);
    text(getText(textKey), x+(w/2), y+(h/2));
  }
}
