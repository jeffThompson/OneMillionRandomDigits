
import java.util.Iterator;
import java.util.Map;

/*
RENDER 3D MODEL
Jeff Thompson | 2015 | www.jeffreythompson.org

Max # of digits: 4 (same for connections)

TO DO:
+  Etch into solid clear block? Could be very thin...

*/


float initialRotX = radians(48.6);
float initialRotY = radians(-129.6);
float rotInc =      0.05;

int maxDigits, numToShow, detail;
boolean dataLoaded = false;
String csvFilename = "../UniquePoints.csv";
Table data;
ArrayList<Digit> digits = new ArrayList<Digit>();
float rx, ry, zoom;
float distMult, diaMin, diaMax;
boolean saveModel = false;
PFont font;


void setup() {
  
  // set default values
  maxDigits =  4;              // max # of digits at one node
  numToShow =  1000;           // how many data points to load?
  distMult =   18.0;           // space between nodes
  diaMin =     4;              // smallest possible node diameter
  diaMax =     10;             // largest
  detail =     18;             // detail of 3D spheres
  
  rx =         initialRotX;    // set current rotation (allows reset)
  ry =         initialRotY;
  zoom =       0;              // sets current zoom (also for reset)
  
  
  // basic setup
  size(800,800, OPENGL);
  colorMode(HSB, 255);
  sphereDetail(detail);
  font = createFont("LucidaConsole", 16);
  textFont(font, 16);
  
  // read data line-by-line, add to model
  if (!dataLoaded) {
    println("Reading data...");
    data = loadTable(csvFilename, "header");
    int lineNum = 0;
    for (TableRow entry : data.rows()) {
      
      // how are we doing?
      if (lineNum % 100 == 0) {
        println( "- " + lineNum + "/" + numToShow );
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
        PVector p = new PVector(Float.parseFloat(c[0]), Float.parseFloat(c[1]), Float.parseFloat(c[2]));
        p.mult(distMult);
        connections.put( p, Integer.parseInt(c[3]) );    // position, count
      }
      
      // add to ArrayList
      Digit d = new Digit(x, y, z, numDigits, allDigits, connections);
      digits.add(d);      
      
      // count lines
      lineNum += 1;
      if (lineNum == numToShow) {
        dataLoaded = true;
        break;
      }
    }
    println("Loaded " + digits.size() + " digits");
  }
}

void draw() {
  background(50);
  lights();
  
  // display digits
  pushMatrix();
  translate(width/2, height/2, zoom);
  rotateX(rx);
  rotateY(ry);
  for (Digit d : digits) {
    d.display();
  }
  popMatrix();
  
  // UI
  hint(DISABLE_DEPTH_TEST);      // draw 2D (back to 3D at bottom)
  fill(255);
  noStroke();
  textAlign(LEFT);
  text("DIA:  " + diaMin + "/" + diaMax + "\nDIST: " + distMult, 50,height-50);
  textAlign(RIGHT);
  text(nf(frameRate, 0,1) + " FPS", width-50,height-50);
  hint(ENABLE_DEPTH_TEST);
}


void mouseDragged() {
  rx += (pmouseY-mouseY) * rotInc;
  ry += (pmouseX-mouseX) * -rotInc;
}


void keyPressed() {
  if (key == 32) {
    setup();
  }
  else if (key == 's') {
    saveModel = true;
  }
  else if (key == CODED) {
    
    // UP/DOWN changes distance between nodes
    if (keyCode == UP) {
      distMult += 1;
      for (Digit d : digits) {
        d.update();
      }
    }
    else if (keyCode == DOWN && distMult >= 1) {
      distMult -= 1;
      for (Digit d : digits) {
        d.update();
      }
    }
    
    // L/R changes max size
    else if (keyCode == RIGHT) {
      diaMax += 1;
    }
    else if (keyCode == LEFT && diaMax > diaMin+1) {
      diaMax -= 1;
    }    
  }
}

void mouseWheel(MouseEvent event) {
  zoom += event.getCount();
}


