float pathWeight;

class Path {
  int index;
  float verticesDistance;
  PVector[] vertices;
  color c;
  int initialDirection;
  float timer;
  Item[] items;

  Path(int _index, int x, int y, int _initialDirection) {
    index = _index;
    pathWeight = 15*em;
    //verticesDistance = pathWeight/3;
    c = color(random(255), random(255), random(255));
    //c = color(255);
    initialDirection = _initialDirection;

    createNewPath(new PVector(x, y));
    //vertices = new PVector[100];
    //vertices[0] = new PVector(0, 0);
    //for(int i = 1; i < vertices.length; i++) {
    //  vertices[i] = new PVector(vertices[i-1].x + random(-em, em), vertices[i-1].x + random(-em, -2*em));
    //}

    createItems();

    timer = 0;
    if (index == 0) {
      timer = 5000;
      c = color(200);
    }
  }


  void createNewPath(PVector initialVertex) {
    vertices = new PVector[40];
    vertices[0] = new PVector();
    vertices[0].set(initialVertex);
    int direction = initialDirection;
    for (int i = 1; i < vertices.length; i++) {
      //float randomAngleRange = TWO_PI/9;

      //float randomAngle = random(-randomAngleRange/2, randomAngleRange);
      //float constrainAngleRange = PI;
      //if (angle + randomAngle > -HALF_PI - (constrainAngleRange/2) && angle + randomAngle < -HALF_PI + (constrainAngleRange/2)) {
      //  angle = angle + randomAngle;
      //} else {
      //  randomAngle = randomAngle * (-2);
      //  angle = angle + randomAngle;
      //}

      //angle = angle + random(-randomAngleRange/2, randomAngleRange/2);
      //angle=random(-PI,0);

      direction = ((direction + floor(random(-1, 2)))+8) % 8;

      //contrain idea
      //angle = constrain(angle, -HALF_PI-constrainAngleRange/2, -HALF_PI+constrainAngleRange/2);
      //angle = lerp(angle, -HALF_PI, 0.2);


      //float sumX = cos(angle) * verticesDistance;
      //float sumY = sin(angle) * verticesDistance;
      //vertices[i] = new PVector(vertices[i-1].x + sumX, vertices[i-1].y + sumY);

      int sumX = convertDirectionToX(direction);
      int sumY = convertDirectionToY(direction);
      vertices[i] = new PVector(vertices[i-1].x + sumX, vertices[i-1].y + sumY);
    }
  }

  void createItems() {
    items = new Item[vertices.length];
    for (int i = 0; i < items.length; i++) {
      float randomAngle = random(TWO_PI);
      float x = gridToWorld(vertices[i].x) + cos(randomAngle)*0.2*pathWeight;
      float y = gridToWorld(vertices[i].y) + sin(randomAngle)*0.2*pathWeight;
      items[i] = new Item(x, y);
      if (random(1) < 0.5) {
        items[i].active = false;
      }
    }
  }


  int convertDirectionToX(int direction) {
    switch (direction) {
    case 0: 
      return 1;
    case 1: 
      return 1;
    case 2: 
      return 0;
    case 3: 
      return -1;
    case 4: 
      return -1;
    case 5: 
      return -1;
    case 6: 
      return 0;
    case 7: 
      return 1;

    default:
      return 0;
    }
  }
  int convertDirectionToY(int direction) {
    switch (direction) {
    case 0: 
      return 0;
    case 1: 
      return 1;
    case 2: 
      return 1;
    case 3: 
      return 1;
    case 4: 
      return 0;
    case 5: 
      return -1;
    case 6: 
      return -1;
    case 7: 
      return -1;

    default:
      return 0;
    }
  }

  void update() {
    timer += time.deltaMillis;
    if (timer < 1500) {
      game.targetZoom = 0.33;
    }
  }

  void display() {
    fill(c);
    noStroke();
    for (int i = 0; i < vertices.length; i++) {
      if (i < timer/100) {
        if (camera.canSee(gridToWorld(vertices[i].x) - pathWeight/2, gridToWorld(vertices[i].y) - pathWeight/2, pathWeight, pathWeight)) {
          ellipse(gridToWorld(vertices[i].x), gridToWorld(vertices[i].y), pathWeight, pathWeight);
        }
      }
    }

    //Drawing as shape 
    //strokeWeight(pathWeight);
    //stroke(c);
    //noFill();
    //beginShape();
    //{
    //  for (int i = 0; i < vertices.length; i++) {
    //    vertex(vertices[i].x, vertices[i].y);
    //  }
    //} 
    //endShape();

    //Debug ellipses
    //noFill();
    //stroke(255, 0, 255);
    //strokeWeight(1);
    //for (int i = 0; i < vertices.length; i++) {
    //  ellipse(gridToWorld(vertices[i].x), gridToWorld(vertices[i].y), pathWeight, pathWeight);
    //}

    //Debug center points
    //stroke(255, 0, 0);
    //strokeWeight(3);
    //for (int i = 0; i < vertices.length; i++) {
    //  point(vertices[i].x, vertices[i].y, 1);
    //}

    for (int i = 0; i < items.length; i++) {
      if (i < timer/100) {
        items[i].display();
      }
    }
  }

  boolean contains(float x, float y, float r) {
    for (int i = 0; i < vertices.length; i++) {
      float c1 = x - gridToWorld(vertices[i].x);
      float c2 = y - gridToWorld(vertices[i].y);
      float sqrtDistance = (c1*c1) + (c2*c2);
      if (sqrtDistance - (r*r) < (pathWeight/2)*(pathWeight/2)) {
        return true;
      }
    }
    return false;
  }
}


float gridToWorld(float a) {
  return round(a) * (pathWeight/2);
}
int worldToGrid(float a) {
  return round(a/(pathWeight/2));
}
