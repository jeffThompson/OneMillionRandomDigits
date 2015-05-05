
void getDataAndStore(int i) {

  // rotate based on current digit
  int digit = digitsFromFile[i];
  rotateX( radians(digit * 36) );
  rotateY( radians(digit * 36) );
  
  // get model position in 3D space
  x = modelX(0, 0, 0);
  y = modelY(0, 0, 0);
  z = modelZ(0, 0, 0);
  
  // first node? previous = self
  if (i == 0) {
    px = x;
    py = y;
    pz = z;
  }

  // compare to all other Digits
  // if already a Digit in that position then update
  boolean updated = false;
  for (Digit other : digits) {
    if (other.pos.x == x && other.pos.y == y && other.pos.z == z) {
      updated = true;
      other.update(digit, px, py, pz);
      break;
    }
  }
  
  // otherwise, store as new
  if (!updated) {
    Digit d = new Digit(digit, x, y, z, px, py, pz);
    digits.add(d);
  }

  // current position = previous
  px = x;
  py = y;
  pz = z;

  // move to next position
  translate(0, distBetween, 0);
}


