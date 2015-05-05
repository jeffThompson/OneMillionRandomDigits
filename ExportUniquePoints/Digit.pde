
class Digit {
  
  PVector pos;
  int numDigitsInLocation;
  HashMap<Integer, Integer> digits = new HashMap<Integer, Integer>();
  HashMap<PVector, Integer> connections = new HashMap<PVector, Integer>();
  
  
  Digit(int digit, float x, float y, float z, float px, float py, float pz) {
    digits.put( digit, 1 );
    numDigitsInLocation = 1;
    pos = new PVector(x, y, z);
    connections.put( new PVector(px,py,pz), 1 );
  }
  
  
  void update(int digit, float px, float py, float pz) {
    numDigitsInLocation++;
    
    // add digit to HashMap
    // if already stored, update count; otherwise, add new
    if ( digits.containsKey(digit) ) {
      digits.put( digit, digits.get(digit)+1 );
    }
    else {
      digits.put( digit, 1 );
    }
    
    // same for connections
    PVector prev = new PVector(px, py, pz);
    if ( connections.containsKey(prev) ) {
      connections.put( prev, connections.get(prev)+1 );
    }
    else {
      connections.put( prev, 1 );
    }
  }

}


