class Menu {
  boolean displayButtons = false;
  
  Button playButton = new Button(3*em, 8*em, canvas.w-6*em, 8*em, "play"); 
  Button settingsButton = new Button(3*em, 17*em, canvas.w-6*em, 3*em, "settings");

  Player menuPlayer;

  Menu() {
    menuPlayer = new Player(canvas.w/2, 0.5*canvas.h);
    menuPlayer.acc.rotate(HALF_PI);
    menuPlayer.speed = 0.1*em;
  }

  void update() {
    if(displayButtons) {
    if (playButton.confirmed()) {
      state.goTo(state.GAME);
    }
    if (settingsButton.confirmed()) {
      if (localization.languageId == "PT") {
        localization.languageId = "EN";
      } else {
        localization.languageId = "PT";
      }
    }
    }

    menuPlayer.update();
    menuPlayer.display();
    if(menuPlayer.pos.y < 0) {
      displayButtons = true;
    }
    menuPlayer.roundScreen();
    controller.displayTouch();
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
    text(getText(textKey), x+(w/2), y+(h/2) - 0.1*em);
  }
}
