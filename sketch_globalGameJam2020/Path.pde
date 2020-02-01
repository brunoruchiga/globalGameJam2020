class Path {
  int index;
  float pathWeight;
  float verticesDistance;
  PVector[] vertices;
  color c;

  Path(int _index, float x, float y) {
    index = _index;
    pathWeight = 4*em;
    verticesDistance = pathWeight/3;
    c = color(random(255), random(255), random(255));

    createPath(new PVector(x, y));
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
      float randomAngleRange = TWO_PI/9;
      //float randomAngle = random(-randomAngleRange/2, randomAngleRange);
      //float constrainAngleRange = PI;
      //if (angle + randomAngle > -HALF_PI - (constrainAngleRange/2) && angle + randomAngle < -HALF_PI + (constrainAngleRange/2)) {
      //  angle = angle + randomAngle;
      //} else {
      //  randomAngle = randomAngle * (-2);
      //  angle = angle + randomAngle;
      //}
      
      angle = angle + random(-randomAngleRange/2, randomAngleRange/2);
      //angle=random(-PI,0);
      
      //contrain idea
      //angle = constrain(angle, -HALF_PI-constrainAngleRange/2, -HALF_PI+constrainAngleRange/2);
      //angle = lerp(angle, -HALF_PI, 0.2);
      
      
      float sumX = cos(angle) * verticesDistance;
      float sumY = sin(angle) * verticesDistance;
      vertices[i] = new PVector(vertices[i-1].x + sumX, vertices[i-1].y + sumY);
    }
  }

  void display() {
    //fill(c);
    //noStroke();
    //for (int i = 0; i < vertices.length; i++) {
    //  if (camera.canSee(vertices[i].x - pathWeight/2, vertices[i].y - pathWeight/2, pathWeight, pathWeight)) {
    //    ellipse(vertices[i].x, vertices[i].y, pathWeight, pathWeight);
    //  }
    //}

    //Drawing as shape 
    strokeWeight(pathWeight);
    stroke(c);
    noFill();
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
  
  boolean contains(float x, float y, float r) {
    for(int i = 0; i < vertices.length; i++) {
      float c1 = x - vertices[i].x;
      float c2 = y - vertices[i].y;
      float sqrtDistance = (c1*c1) + (c2*c2);
      if(sqrtDistance - (r*r) < (pathWeight/2)*(pathWeight/2)) {
        return true;
      }
    }
    return false;
  }
}
