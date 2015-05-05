
/*
RENDER 3D MODEL
Jeff Thompson | 2015 | www.jeffreythompson.org

Max # of digits: 4 (same for connections)

TO DO:
+  Parse and display need updating to new class

*/

float distMult =    1.3;
float diaMin =      10;
float diaMax =      30;

int numToShow =     100;

float initialRotX = radians(48.6);
float initialRotY = radians(-129.6);
float rotInc =      0.05;

String csvFilename = "../UniquePoints.csv";
Table data;
ArrayList<Digit> digits = new ArrayList<Digit>();
float rx, ry;


void setup() {
  size(600,600, OPENGL);
  colorMode(HSB, 255);
  noStroke();
  
  // read data line-by-line, add to model
  println("Reading data...");
  data = loadTable(csvFilename, "header");
  int lineNum = 0;
  for (TableRow entry : data.rows()) {
    
    // how are we doing?
    if (lineNum % 100 == 0) {
      println( "- " + (lineNum+1) + "/" + numToShow );
    }
      
    // x,y,z
    // num digits
    // digits as val:count (comma-separated)
    // connections as x_y_z:count (comma-separated)     
    float x = entry.getFloat("x");
    float y = entry.getFloat("y");
    float z = entry.getFloat("z");
    int numDigits = entry.getInt("num digits");
    
    String[] digitsString = split(entry.getString("digits (val:count)"), ',');
    HashMap<Integer, Integer> allDigits = new HashMap<Integer, Integer>();
    for (String digit : digitsString) {
      String[] d = split(digit, ':');
      allDigits.put( Integer.parseInt(d[0]), Integer.parseInt(d[1]));
    }
    
    String[] connectionsString = split(entry.getString("connections (x_y_z:count)"), ',');
    HashMap<PVector, Integer> connections = new HashMap<PVector, Integer>();
    for (String connection : connectionsString) {
      String[] c = splitTokens(connection, "_:");
      connections.put( new PVector(Float.parseFloat(c[0]), Float.parseFloat(c[1]), Float.parseFloat(c[2])), Integer.parseInt(c[3]));
    }
    
    // add to ArrayList
    Digit d = new Digit(x, y, z, numDigits, allDigits, connections);
    digits.add(d);      
    
    // count lines
    lineNum += 1;
    if (lineNum == numToShow) break;
  }
  println("- loaded " + digits.size() + " digits");
  
  rx = initialRotX;
  ry = initialRotY;
}

void draw() {
  background(50);
  lights();
  translate(width/2, height/2);
  rotateX(rx);
  rotateY(ry);
  
  for (Digit d : digits) {
    d.display();
  }  
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
}


