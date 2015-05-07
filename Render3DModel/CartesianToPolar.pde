
// convert 3D Cartesian coordinates to polar coords
// x = length, y = angleY, z = angleZ
PVector cartesianToPolar(PVector input) {
  PVector output = new PVector();
 output.x = input.mag();
  if (output.x > 0) {
    output.y = -atan2(input.z, input.x);
    output.z = asin(input.y / output.x);
  } else {
    output.y = 0;
    output.z = 0;
  }
  return output;
}
