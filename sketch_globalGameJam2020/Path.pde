class Path {
  int index;
  float pathWeight;
  float verticesDistance;
  PVector[] vertices;

  Path(int _index) {
    index = _index;
    pathWeight = 5*em;
    verticesDistance = pathWeight/2;

    createPath(new PVector(0, 0));
    //vertices = new PVector[100];
    //vertices[0] = new PVector(0, 0);
    //for(int i = 1; i < vertices.length; i++) {
    //  vertices[i] = new PVector(vertices[i-1].x + random(-em, em), vertices[i-1].x + random(-em, -2*em));
    //}
  }

  void createPath(PVector initialVertex) {
    vertices = new PVector[100];
    vertices[0] = new PVector();
    vertices[0].set(initialVertex);
    float angle = -HALF_PI;
    for (int i = 1; i < vertices.length; i++) {
      float randomAngleRange = TWO_PI/18;
      float randomAngle = random(-randomAngleRange/2, randomAngleRange);
      float constrainAngleRange = HALF_PI;
      if (angle + randomAngle > -HALF_PI - (constrainAngleRange/2) && angle + randomAngle < -HALF_PI + (constrainAngleRange/2)) {
        angle = angle + randomAngle;
      } else {
        randomAngle = randomAngle * (-2);
        angle = angle + randomAngle;
      }
      //angle = constrain(angle, -HALF_PI-constrainAngleRange/2, -HALF_PI+constrainAngleRange/2);
      //angle = lerp(angle, -HALF_PI, 0.2);
      float sumX = cos(angle) * verticesDistance;
      float sumY = sin(angle) * verticesDistance;
      vertices[i] = new PVector(vertices[i-1].x + sumX, vertices[i-1].y + sumY);
    }
  }

  void display() {
    fill(white);
    noStroke();
    for (int i = 0; i < vertices.length; i++) {
      if (camera.canSee(vertices[i].x - pathWeight/2, vertices[i].y - pathWeight/2, pathWeight, pathWeight)) {
        ellipse(vertices[i].x, vertices[i].y, pathWeight, pathWeight);
      }
    }

    //Drawing as shape    
    strokeWeight(pathWeight);
    stroke(white);
    noFill();
    //strokeJoin(ROUND);
    beginShape();
    {
      for (int i = 0; i < vertices.length; i++) {
        vertex(vertices[i].x, vertices[i].y);
      }
    } 
    endShape();

    //Debug ellipses
    //noFill();
    //stroke(255, 0, 255);
    //strokeWeight(1);
    //for (int i = 0; i < vertices.length; i++) {
    //  ellipse(vertices[i].x, vertices[i].y, pathWeight, pathWeight);
    //}

    //Debug center points
    //stroke(255, 0, 0);
    //strokeWeight(3);
    //for (int i = 0; i < vertices.length; i++) {
    //  point(vertices[i].x, vertices[i].y, 1);
    //}
  }
}
