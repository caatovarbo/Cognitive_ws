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
    squares();
    break;
  case 5:
    whiteIllusion();
    break;
  case 6:
    stroboscopicMotion();
    break;
  case 7:
    rotateSquare();
    break;
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
  float step = height / 10;
  float doubleStep = step * 2;
  boolean random;
  String pattern = "01011010010";

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

  if (active) {
    for (int y = 0; y < pattern.length(); y++) {
        for (int x = 0; x < pattern.length(); x++) {
          char ch = pattern.charAt(x);
          quadChecker(x * step, y * step, step, ch == '0');
        }
      pattern = rotateString(pattern);
    }
  }
}

String rotateString(String s) {
  char lastChar = s.charAt(s.length() - 1);
  return new String(lastChar + s.substring(0, s.length() - 1));
}

void quadChecker(float stepX, float stepY, float distance, boolean position) {
  float height = distance / 5;
  float mheight = height / 2;

  strokeWeight(0);
  stroke(0, 0, 0);

  if (position) {
    fill(0, 0, 0);
    quad(stepX, stepY - height, stepX + mheight, stepY - mheight, stepX, stepY, stepX - mheight, stepY - mheight);
    quad(stepX, stepY, stepX + mheight, stepY + mheight, stepX, stepY + height, stepX - mheight, stepY + mheight);

    fill(255, 255, 255);
    quad(stepX - mheight, stepY - mheight, stepX, stepY, stepX - mheight, stepY + mheight, stepX- height, stepY);
    quad(stepX + mheight, stepY - mheight, stepX + height, stepY, stepX + mheight, stepY + mheight, stepX, stepY);
  } else {
    fill(255, 255, 255);
    quad(stepX, stepY - height, stepX + mheight, stepY - mheight, stepX, stepY, stepX - mheight, stepY - mheight);
    quad(stepX, stepY, stepX + mheight, stepY + mheight, stepX, stepY + height, stepX - mheight, stepY + mheight);

    fill(0, 0, 0);
    quad(stepX - mheight, stepY - mheight, stepX, stepY, stepX - mheight, stepY + mheight, stepX - height, stepY);
    quad(stepX + mheight, stepY - mheight, stepX + height, stepY, stepX + mheight, stepY + mheight, stepX, stepY);

  }
}
int widthSquare = 130;
int yInitSquare = 120;
boolean positionSquare = false;

void squares() {
  int step = 30;

  if (yInitSquare >= height - widthSquare / 2) {
    positionSquare = true;
  }
  if (yInitSquare == widthSquare / 2) {
    positionSquare = false;
  }

  if (!positionSquare) {
    yInitSquare++;
  }
  else {
    yInitSquare--;
  }

  //Stripes
  strokeWeight(0);
  stroke(0, 0, 0);
  fill(0, 0, 0);

  if (active) {
    for (int i = 0; i <= height; i = i + step) {
      rect(0, i * 2, width, step);
    }
  }

  //Squares
  rectMode(CENTER);

  fill(0, 0, 102);
  rect(220, yInitSquare, widthSquare, widthSquare);

  fill(255, 255, 0);
  rect(500, yInitSquare, widthSquare, widthSquare);
}

void whiteIllusion() {
  float step = width / 5;
  float doubleStep = step * 2;
  float padding = 60;
  float rectHeight = 30;

  background(0);

  strokeWeight(0);
  stroke(0);
  fill(192, 192, 192);

  for (float i = 0; i < height; i = i + padding) {
    rect(step, i, step, rectHeight);
  }
  for (float i = rectHeight; i < height; i = i + padding) {
    rect(step * 3, i, step, rectHeight);
  }

  if (active) {
    fill(255);
    for (float i = 0; i < height; i = i + padding) {
      rect(0, i, step, rectHeight);
      rect(step * 2, i, step * 3, rectHeight);
    }
  }
}

boolean firstPair = false;
void stroboscopicMotion() {
  background(192, 192, 192);

  strokeWeight(100);
  stroke(0, 0, 255);

  if (firstPair) {
    point(200, 200);
    point(600, 600);
  } else {
    point(600, 200);
    point(200, 600);
  }
  delay(1000);
  firstPair = !firstPair;
}

void rotateSquare() {

  rotateSquare1();
  if (active) {
    resetMatrix();
    strokeWeight(0);
    stroke(0);
    fill(255,140, 0);

    rect(0, 0, 375, 375);
    rect(425, 0, 375, 375);
    rect(0, 425, 375, 375);
    rect(425, 425, 375, 375);
  }
}

float angle = 0;
float speed;
void rotateSquare1() {

    pushStyle();
    speed = 0.01;
    angle += speed;

    strokeWeight(0);
    stroke(0);
    fill(0, 0, 255);

    translate(width/2, height/2);
    rotate(angle);
    rectMode(CENTER);
    rect(0, 0, 500, 500);
    popStyle();
}
