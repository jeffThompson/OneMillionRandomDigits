

class Digit {
  
  PVector pos;
  int numDigitsInLocation;
  HashMap<Integer, Integer> digits = new HashMap<Integer, Integer>();
  HashMap<PVector, Integer> connections = new HashMap<PVector, Integer>();  
  float diameter;
  color c;
  
  
  Digit(float x, float y, float z, int _numDigitsInLocation, HashMap<Integer,Integer> _digits, HashMap<PVector,Integer> _connections) {
    numDigitsInLocation = _numDigitsInLocation;
    pos = new PVector(x, y, z);
    digits = _digits;
    connections = _connections;
    
    diameter = map(numDigitsInLocation, 1,7, diaMin,diaMax);
    
    // average digit # into usable color
    /*int colorVal = 0;
    for (int i=0; i<digits.length; i++) {
      colorVal += digits[i];
    }
    colorVal /= digits.length;
    c = color( map(colorVal, 0,9, 0,255), 255,255 );*/
    c = color(255,150,0);
  }
  
  
  void display() {
    pushMatrix();
    translate(pos.x * distMult, pos.y * distMult, pos.z * distMult);
    fill(c);
    noStroke();
    sphere(diameter);
    popMatrix();
  }

}


