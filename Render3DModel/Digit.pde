
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
    pos.mult(distMult);
    digits = _digits;
    connections = _connections;
    
    // average digit # into usable color
    int colorVal = 0;
    Iterator it = digits.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry pair = (Map.Entry) it.next();
      
      // cast from Integer to int :(
      colorVal += Integer.parseInt( pair.getKey().toString() ) * Integer.parseInt( pair.getValue().toString() );
    }
    colorVal /= numDigitsInLocation;
    c = color( map(colorVal, 0,9, 0,255), 255,255 );
  }
  
  
  void update() {
    pos.normalize();
    pos.mult(distMult);
  }
  
  
  void display() {
    if (saveModel) {
      //
    }
    saveModel = false;
    
    // spheres at node
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(c);
    noStroke();
    float dia = map(numDigitsInLocation, 1,maxDigits, diaMin,diaMax);
    sphere(dia);
    popMatrix();
    
    // connections
    //stroke(255, 150);
    Iterator it = connections.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry pair = (Map.Entry) it.next();
      PVector other = (PVector) pair.getKey();
      float count = Integer.parseInt( pair.getValue().toString() ) * (diaMin/2);
      count = map(count, 1,4, diaMin/2,diaMax/2);

      // get angle in 3D space
      // via: https://www.processing.org/discourse/beta/num_1236393966.html
      PVector polar = cartesianToPolar(PVector.sub(pos, other));
      PVector halfway = PVector.add(pos, other);
      halfway.div(2);
      pushMatrix();
      translate(halfway.x, halfway.y, halfway.z);
      rotateY(polar.y);
      rotateZ(polar.z);
      noStroke();
      box(polar.x, count, count);
      popMatrix();
    }
  }

}


