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

      camera.target.set(p[0].pos.x, p[0].pos.y, 1);
      camera.update();
    }
  }

  void display() {
    background(green);

    camera.begin();
    {
      fill(yellow);
      noStroke();
      ellipse(0, 0, 0.5*em, 0.5*em);

      for (int i = 0; i < p.length; i++) {
        p[i].display();
        p[i].debug();
      }
    }
    camera.end();
  }
}
