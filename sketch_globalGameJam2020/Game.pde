float gameOverTimer = 0;

class Game {
  boolean playing;
  boolean gameOver;
  float seconds;
  Player[] p = new Player[numberOfPlayers];
  ArrayList<Path> paths = new ArrayList<Path>();
  //Path path;

  float targetZoom = 0.8;

  //Button resetButton = new Button(em, 3*em, 4*em, 2.5*em, "Reset"); 
  //Button zoom0 = new Button(6*em, em, 2*em, 2*em, "-"); 
  //Button zoom1 = new Button(9*em, em, 2*em, 2*em, "+"); 

  Game() {
    reset();
  }

  void reset() {
    seconds = 0;
    playing = true;
    gameOver = false;
    for (int i = 0; i < p.length; i++) {
      p[i] = new Player(0, 0);
    }
    //path = new Path(0);
    paths.clear();
    paths.add(new Path(0, 0, 0, 6));

    camera.jumpToTarget(p[0].pos.x, p[0].pos.y - em, 1);
  }

  void update() {
    if (playing) {
      seconds = seconds + (time.deltaMillis * 0.001);

      for (int i = 0; i < p.length; i++) {
        p[i].update();
        p[i].checkCollision();
      }

      for (int i = paths.size() - 1; i >= 0; i--) {
        paths.get(i).update();
      }
    }
  }

  void display() {
    camera.target.set(p[0].pos.x, p[0].pos.y, targetZoom);
    if (gameOver) {
      gameOverTimer += time.deltaMillis;
    }
    game.targetZoom = 1 - constrain((gameOverTimer*0.0001), 0, 0.96);
    camera.update();
    camera.begin();
    {
      background(black);

      //path.display();
      //for (int i = 0; i < paths.size(); i++) {
      for (int i = paths.size() - 1; i >= 0; i--) {
        paths.get(i).display();
      }

      //Debug terrain
      //float debugTerraingSpacing = 2*em;
      //for (float y = camera.screenInitialY(); y < camera.screenInitialY() + canvas.h*2; y+=debugTerraingSpacing) {
      //  for (int i = -10; i <= 10; i++) {
      //    stroke(255, 255, 0);
      //    strokeWeight(2);
      //    point(i*debugTerraingSpacing, floor(y/debugTerraingSpacing)*debugTerraingSpacing, -1);
      //  }
      //}

      for (int i = 0; i < p.length; i++) {
        p[i].display();
        p[i].debug();
      }
    }
    camera.end();

    if (gameOver) {
      textAlign(CENTER, CENTER);
      fill(255);
      textFont(fontBig);
      text("CONGRATULATION!\nTHANK YOU FOR PLAYING", canvas.w/2, canvas.h/2);
      //text("/", canvas.w/2, canvas.h/2);
    }

    fill(255);
    textFont(font);
    textAlign(RIGHT, TOP);
    text(p[0].score + ".000", canvas.w - em, 3.5*em);

    //Display player health
    translate(0, 0, 2);
    fill(56);
    rect(em, em, (canvas.w-2*em), 2*em);
    translate(0, 0, 2);
    if (p[0].canBranch) {
      float percent = (sin(millis()*0.01)+1)/2;
      fill(lerpColor(cyan, white, percent, RGB));
    } else {
      fill(cyan);
    }
    rect(em, em, (canvas.w-2*em)*p[0].visibleHealth, 2*em);

    if (!p[0].canBranch) {
      fill(cyan);
      textFont(font);
      textAlign(LEFT, TOP);
      text("REPAIRING DAMAGE...", em, 3.5*em);
    }


    //if (resetButton.confirmed()) {
    //  reset();
    //}
    //if (zoom0.confirmed()) {
    //  targetZoom = 0.2;
    //}    
    //if (zoom1.confirmed()) {
    //  targetZoom = 0.8;
    //}
  }
}
