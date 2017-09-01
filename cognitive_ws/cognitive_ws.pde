int illusions = 7;
int current = 1;
//toggle illusion activation
boolean active = true;

void setup() {
  size(800, 800);
}

void draw() {
  background(255);
  pushStyle();
  switch(current) {
  case 1:
    scintillating();
    break;
    // implement from here. Don't forget to add break for each case
  case 2:
    zollnerIlussion();
    break;
  case 3:
    checker();
    break;
  case 4:
  case 5:
  case 6:
  case 7:
    //println("implementation is missed!");
  }
  popStyle();
}

// switch illusion using the spacebar
void keyPressed() {
  if (key == ' ')
    current = current < illusions ? current+1 : 1;
  if (key == 'a')
    active = !active;
}

// Complete info for each illusion

/*
 Scintillating Grid
 Author: E. Lingelbach, 1994
 Code adapted from Rupert Russell implementation
 Tags: Physiological illusion, Hermann grid illusion
*/
void scintillating() {
  background(0);          // black background

  //style
  strokeWeight(3);        // medium weight lines
  smooth();               // antialias lines
  stroke(100, 100, 100);  // dark grey colour for lines

  int step = 25;          // grid spacing

  //vertical lines
  for (int x = step; x < width; x = x + step) {
    line(x, 0, x, height);
  }

  //horizontal lines
  for (int y = step; y < height; y = y + step) {
    line(0, y, width, y);
  }

  // Circles
  if (active) {
    ellipseMode(CENTER);
    stroke(255, 255, 255);  // white circles
    for (int i = step; i < width -5; i = i + step) {
      for (int j = step; j < height -15; j = j + step) {
        strokeWeight(6);
        point(i, j);
        //strokeWeight(3);
      }
    }
  }
}

void  zollnerIlussion() {
  background(255);
  strokeWeight(20);
  smooth();
  stroke(0, 0, 0);

  int step = 100;
  float finalPoint;

  for (int x = -width; x < width; x = x + step) {
    finalPoint = width + x;
    line(x, 0, finalPoint, height);
  }

  if (active) {
    int doubleStep = step * 2;
    int halfStep = step / 2;
    int verticalQuadWidth = 10;
    int verticalQuadHeight1 = 25;
    int verticalQuadHeight2 = 45;

    strokeWeight(0);
    stroke(0, 0, 0);
    fill(0);

    //Rectángulos verticales
    quadVerticalZollner(0, 0, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadVerticalZollner(halfStep, halfStep, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadVerticalZollner(-step, step, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadVerticalZollner(-halfStep, -halfStep, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);

    //Rectángulos Horizontales
    quadHorizontalZollner(-step, 0, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadHorizontalZollner(-halfStep, halfStep, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadHorizontalZollner(0, step, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
    quadHorizontalZollner(halfStep, -halfStep, doubleStep, verticalQuadWidth, verticalQuadHeight1, verticalQuadHeight2);
  }
}

void quadVerticalZollner(int xInit, int yInit, int increase, int vqw, int vqh1, int vqh2) {
  for (int x = -width + xInit; x <= width; x = x + increase) {
    for (int y = yInit; y <= height; y = y + increase) {
      quad(x - vqw, y + vqh1, x + vqw, y + vqh2, x + vqw, y - vqh1, x - vqw, y - vqh2);
    }
  }
}

void quadHorizontalZollner(int xInit, int yInit, int increase, int vqw, int vqh1, int vqh2) {
  for (int x = -width + xInit; x <= width; x = x + increase) {
    for (int y = yInit; y <= height; y = y + increase) {
      quad(x - vqh1, y + vqw, x + vqh2, y + vqw, x + vqh1, y - vqw, x - vqh2, y - vqw);
    }
  }
}

void checker() {
  float step = height/8;
  float doubleStep = step * 2;
  
  background(192,255,255);
  
  strokeWeight(0);
  stroke(0, 0, 0);
  fill(0, 255, 0);
  
  for (float i = 0; i <= width; i = i + doubleStep) {
    for (float j = 0; j <= height; j = j + doubleStep) {
      rect(i, j, step, step);
    }
  }
  
  for (float i = step; i <= width; i = i + doubleStep) {
    for (float j = step; j <= height; j = j + doubleStep) {
      rect(i, j, step, step);
    }
  }
}
