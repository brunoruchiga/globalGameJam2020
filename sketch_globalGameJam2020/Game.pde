class Game {
  boolean playing;
  boolean gameOver;
  float seconds;
  Player[] p = new Player[numberOfPlayers];

  Game() {
    reset();
  }

  void reset() {
    for (int i = 0; i < p.length; i++) {
      p[i] = new Player(0, 0);
    }
    playing = true;
    gameOver = false;
    seconds = 0;

    camera.jumpToTarget(p[0].pos.x, p[0].pos.y - em, 1);
  }

  void update() {
    if (playing) {
      seconds = seconds + (time.deltaMillis * 0.001);

      for (int i = 0; i < p.length; i++) {
        p[i].update();
      }
    }
  }

  void display() {
    camera.target.set(p[0].pos.x, p[0].pos.y, 1);
    camera.update();
    camera.begin();
    {
      background(black);

      //Debug terrain
      float debugTerraingSpacing = 2*em;
      for (float y = camera.screenInitialY(); y < camera.screenInitialY() + canvas.h; y+=debugTerraingSpacing) {
        for(int i = -10; i <= 10; i++) {
          stroke(255, 255, 0);
          strokeWeight(2);
          point(i*debugTerraingSpacing, floor(y/debugTerraingSpacing)*debugTerraingSpacing);
        }
      }

      for (int i = 0; i < p.length; i++) {
        p[i].display();
        p[i].debug();
      }
    }
    camera.end();
  }
}
