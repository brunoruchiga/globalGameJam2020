class Player {
  PVector initialPos = new PVector();
  PVector pos = new PVector();
  PVector prevPos = new PVector();
  float speed;
  PVector vel = new PVector();
  PVector acc = new PVector();
  float w, h;
  //Rectangle area;
  int currentPath;
  boolean canBranch;
  int branchTimer = 0;
  boolean debug = false;

  Player(float x, float y) {
    w = em;
    h = em;
    initialPos.set(x, y);
    //area = new Rectangle(pos.x, pos.y, w, h);
    reset();
  }

  void reset() {
    pos.set(initialPos);
    prevPos.set(pos.x, pos.y);
    speed = 0.2*em;
    vel.set(0, 0);
    acc.set(0, -speed*0.0002);
    currentPath = 0;
    canBranch = false;
  }

  void update() {
    controller.updateTouch();
    prevPos.set(pos);

    checkCollision();
    move();
    vel.add(acc);
    if (vel.mag() > speed) {
      vel.setMag(speed);
    }
    pos.add(vel.copy().mult(time.scaleFactor));
    //area.update(pos);

    branchTimer += time.deltaMillis;
    if (branchTimer > 5000) {
      canBranch = true;
    }
  }

  void checkCollision() {
    boolean inAnyPath = false;
    for (int i = 0; i < game.paths.size(); i++) {
      if (game.paths.get(i).contains(pos.x, pos.y, w/2)) {
        inAnyPath = true;
      }
    }
    if (!inAnyPath) {
      if (canBranch) {
        createNewBranch();
      } else {
        bounce();
      }
    }

    //if (!game.paths.get(currentPath).contains(pos.x, pos.y, w/2)) {
    //  if (canBranch) {
    //    createNewBranch();
    //  } else {
    //    bounce();
    //  }
    //}
  }

  void createNewBranch() {
    currentPath++;
    game.paths.add(new Path(currentPath, worldToGrid(pos.x), worldToGrid(pos.y), 6));
    if (game.paths.size() > 20) {
      game.paths.remove(0);
      currentPath--;
    }
    canBranch = false;
    branchTimer = 0;
    game.targetZoom = game.targetZoom * 0.9; 
  }

  void bounce() {
    //pos.sub(vel.copy().mult(time.scaleFactor));
    pos.sub(vel.copy().mult(time.scaleFactor));
    //vel.rotate(PI);
  }

  void move() {
    float rotationAngle = TWO_PI/180;
    if (controller.right) {
      acc.rotate(rotationAngle*time.scaleFactor);
      vel.rotate(rotationAngle*time.scaleFactor);
    }
    if (controller.left) {
      acc.rotate(-rotationAngle*time.scaleFactor);
      vel.rotate(-rotationAngle*time.scaleFactor);
    }
  }

  void display() {
    pushMatrix(); 
    {
      translate(pos.x, pos.y, 10);
      rotate(acc.heading());
      stroke(0, 0, 255);
      strokeWeight(0.1*em);
      if(canBranch) {
       fill(0, 0, 255);
      } else {
       noFill(); 
      }
      beginShape();
      {
        vertex(0.5*em, 0);
        vertex(-0.5*em, 0.4*em);
        vertex(-0.5*em, -0.4*em);
      }
      endShape(CLOSE);
    }
    popMatrix();
  }

  void debug() {
    if (debug) {
      pushMatrix(); 
      {
        translate(pos.x, pos.y);
        rotate(acc.heading());
        stroke(0, 0, 255);
        strokeWeight(3);
        //noFill();
        fill(255);
        //rect(-w/2, -h/2, w, h);
        ellipse(0, 0, h, w);
        line(0, 0, w, 0);
      }

      stroke(255);
      strokeWeight(3);
      point(0, 0);
      popMatrix();
    }
  }
}
