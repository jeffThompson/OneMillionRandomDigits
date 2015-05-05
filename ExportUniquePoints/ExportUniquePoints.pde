
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.util.Iterator;
import java.util.Map;

/*
EXPORT UNIQUE POINTS
 Jeff Thompson | 2015 | www.jeffreythompson.org
 
 
 
 */

float distBetween =     1.0;
int numToShow =         1000000;

String filename =       "../AMillionRandomDigits.txt";
String outputFilename = "../UniquePoints.csv";

int[] digitsFromFile;
float x, y, z, px, py, pz;
ArrayList<Digit> digits = new ArrayList<Digit>();


void setup() {
  size(100, 100, OPENGL);

  // read the data into an array
  println("Reading " + numToShow + " digits from file...");
  readDataFromFile();

  // store into ArrayList
  println("Adding to array list...");
  for (int i=0; i<numToShow; i++) {
    if (i % 100 == 0) {
      println( "- " + (i+1) + "/" + numToShow );
    }
    getDataAndStore(i);
  }
  
  // what did we get?
  println( "\n" + digits.size() + " stored" );
  println( (numToShow - digits.size()) + " updated" );  
  
  // save to file
  println("\nSaving to file...");
  saveToFile();
  
  println("DONE!\n");
  exit();
}


