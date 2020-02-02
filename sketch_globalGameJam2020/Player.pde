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
    acc.set(0, -speed*0.0004);
    currentPath = 0;
    canBranch = false;
  }

  void update() {
    controller.updateTouch();
    prevPos.set(pos);

    move();
    acc.mult(1-(0.000008*time.scaleFactor));
    println(vel.mag()/em);
    if (!(controller.left && controller.right)) {
      vel.add(acc);
    }
    //if (vel.mag() > speed) {
    //  vel.setMag(speed);
    //}
    pos.add(vel.copy().mult(time.scaleFactor));
    //area.update(pos);

    branchTimer += time.deltaMillis;
    if (branchTimer > 1000) {
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
  }

  void bounce() {
    //pos.sub(vel.copy().mult(time.scaleFactor));
    pos.sub(vel.copy().mult(2*time.scaleFactor));
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

  void roundScreen() {
    if (pos.x > canvas.w) {
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = canvas.w;
    }
    if (pos.y > canvas.h) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = canvas.h;
    }
  }

  void display() {
    pushMatrix(); 
    {
      translate(pos.x, pos.y, 2);
      rotate(acc.heading());

      //Fire left
      if (!controller.left) {
        fill(255, 128, 0);
      } else {
        fill(128, 56, 0);
      }
      noStroke();
      beginShape();
      {
        vertex(-em/2, 0);
        vertex(-em/2, -0.4*em);
        vertex(-em/2 -0.6*em, -0.2*em);
      }
      endShape();

      //Fire right
      if (!controller.right) {
        fill(255, 128, 0);
      } else {
        fill(128, 56, 0);
      }
      noStroke();
      beginShape();
      {
        vertex(-em/2, 0);
        vertex(-em/2, 0.4*em);
        vertex(-em/2 -0.6*em, 0.2*em);
      }
      endShape();

      //Triangle
      translate(0, 0, 2);
      //stroke(255);
      //strokeWeight(0.1*em);
      noStroke();
      if (canBranch) {
        fill(255);
      } else {
        fill(128);
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
