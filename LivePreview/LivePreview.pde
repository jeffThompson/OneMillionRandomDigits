
/*
ONE MILLION RANDOM DIGITS (3D)
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 TO DO/THINK ABOUT:
 +  Colors assoc w numbers? How to pick...
 +  Several pieces, attach together (open joint with printed marking?)
 +  Macro- and micro-structure, fractal-like
 +  Cull repetitions from list? Tag so it can be drawn diff?
 
 */

int lineLen =       35;
int lineThickness = 12;
int numToShow =     1000;
int sphereDetail =  8;

float initialRotX = radians(48.6);
float initialRotY = radians(-129.6);
float rotInc =      0.05;

String filename =   "../AMillionRandomDigits.txt";
int[] digits;
float rx, ry;


void setup() {
  size(800, 800, OPENGL);
  noStroke();
  sphereDetail(sphereDetail);

  // read the data into an array
  digits = new int[1000000];
  try {
    BufferedReader reader = createReader(filename);
    String tempLine;
    int index = 0;
    while ( (tempLine = reader.readLine ()) != null) {
      for (int i=8; i<tempLine.length (); i++) {
        if (tempLine.charAt(i) != ' ') {
          digits[index] = Character.getNumericValue(tempLine.charAt(i));
          index++;
        }
      }
    }
  }
  catch (IOException ioe) {
    // error reading file :(
  }
  
  rx = initialRotX;
  ry = initialRotY;
}


void draw() {
  background(50);
  lights();
  
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateX(rx);
  rotateY(ry);
  
  for (int i=0; i<numToShow; i++) {
    int digit = digits[i];
    switch(digit) {
    case 0: fill(255, 0, 0);     break;
    case 1: fill(0, 255, 0);     break;
    case 2: fill(0, 0, 255);     break;
    case 3: fill(255, 255, 0);   break;
    case 4: fill(0, 255, 255);   break;
    case 5: fill(255, 0, 255);   break;
    case 6: fill(255, 150, 0);   break;
    case 7: fill(150, 255, 0);   break;
    case 8: fill(0, 255, 150);   break;
    case 9: fill(0, 150, 255);   break;
    }
    rotateX( radians(digit * 36) );
    rotateY( radians(digit * 36) );

    sphere(lineThickness);
    
    if (lineLen > lineThickness) {
      pushMatrix();
      translate(0, lineLen/2, 0);
      box(lineThickness, lineLen, lineThickness);
      popMatrix();
    }

    translate(0, lineLen, 0);
    if (i == numToShow-1) sphere(lineThickness);
  }
  popMatrix();
  
  fill(255);
  textAlign(LEFT);
  text(nf(degrees(rx),0,3) + "º, " + nf(degrees(ry),0,3) + "º", 30,height-30);
  textAlign(RIGHT);
  text(nf(frameRate,0,1) + " fps", width-30,height-30);
}


void mouseDragged() {
  rx += (pmouseY-mouseY) * rotInc;
  ry += (pmouseX-mouseX) * -rotInc;
}


void keyPressed() {
  if (key == 32) {
    rx = initialRotX;
    ry = initialRotY;
  }
  else if (key == 's') {
    save(int(degrees(rx)) + "x" + int(degrees(ry)) + "y_" + numToShow + "digits.png");
  }
}


