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
  //int branchTimer = 0;
  float health = 0.2;
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
    speed = 0.25*em;
    vel.set(0, 0);
    acc.set(0, -speed*0.003);
    currentPath = 0;
    canBranch = false;
  }

  void update() {
    controller.updateTouch();
    prevPos.set(pos);

    move();
    //acc.mult(1-(0.000008*time.scaleFactor));
    //println(vel.mag()/em);
    if (!(controller.left && controller.right)) {
      vel.add(acc);
    }
    if (vel.mag() > speed) {
      vel.setMag(speed);
    }
    pos.add(vel.copy().mult(time.scaleFactor));
    //area.update(pos);

    //branchTimer += time.deltaMillis;
    if (health > 0.8) {
      canBranch = true;
    }

    for (int i = 0; i < game.paths.size(); i++) {
      for (int j = 0; j < game.paths.get(i).items.length; j++) {
        float c1 = pos.x - game.paths.get(i).items[j].pos.x; 
        float c2 = pos.y - game.paths.get(i).items[j].pos.y;
        float sqrtDistance = (c1*c1) + (c2*c2);
        if (game.paths.get(i).items[j].active) {
          if (sqrtDistance < 3*em*em) {
            game.paths.get(i).items[j].collect();
            changeHealth(+0.2);
          }
        }
      }
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
      vel.mult(0.5);
      if (canBranch) {
        createNewBranch();
        health = health/3;
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
    if (game.paths.size() > 200) {
      game.paths.remove(0);
      currentPath--;
    }
    canBranch = false;
    //branchTimer = 0;
  }

  void bounce() {
    //pos.sub(vel.copy().mult(time.scaleFactor));
    pos.sub(vel.copy().mult(5*time.scaleFactor));
    vel.mult(-1);
    changeHealth(-0.1);
    //vel.rotate(PI);
  }

  void move() {
    float rotationAngle = TWO_PI/120;
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

  void changeHealth(float amount) {
    health = health + amount;
    health = constrain(health, 0, 1);
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

      //Triangle outline
      if (canBranch) {
        translate(0, 0, 2);
        noStroke();
        fill(cyan);
        beginShape();
        {        
          vertex(0.8*em, 0);
          vertex(-0.7*em, 0.7*em);
          vertex(-0.7*em, -0.7*em);
        }
        endShape(CLOSE);
      }

      //Triangle
      translate(0, 0, 2);
      //stroke(255);
      //strokeWeight(0.1*em);
      noStroke();
      if (canBranch) {
        fill(255);
      } else {
        float percent = (sin(millis()*(0.02-(0.01*health)))+1)/2;
        fill(128 + 56*percent, 128 + 56*percent, 0);
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
