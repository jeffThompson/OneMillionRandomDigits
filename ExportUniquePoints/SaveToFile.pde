
void saveToFile() {
  
  PrintWriter w = null;
  try {
    w = new PrintWriter(new BufferedWriter (new FileWriter(sketchPath("") + outputFilename, true)));
    
    // header
    w.println("x,y,z,num digits,digits (val:count),connections (x_y_z:count)");
    for (Digit d : digits) {
      
      // position
      w.print(d.pos.x + "," + d.pos.y + "," + d.pos.z + "," + d.numDigitsInLocation + ",");
      
      // list of digits with count
      // ex: 5:2 means #5 shows up 2 times
      Iterator it = d.digits.entrySet().iterator();
      String digitsString = "\"";
      while (it.hasNext()) {
        Map.Entry pair = (Map.Entry) it.next();
        digitsString += pair.getKey() + ":" + pair.getValue() + ",";
      }
      w.print( digitsString.substring(0,digitsString.length()-1) );
      w.print("\",");
      
      // connections as comma-separated list, '_' between x-y-z
      it = d.connections.entrySet().iterator();
      String connectionsString = "\"";
      while (it.hasNext()) {
        Map.Entry pair = (Map.Entry) it.next();
        PVector c = (PVector) pair.getKey();
        connectionsString += c.x + "_" + c.y + "_" + c.z + ":" + pair.getValue() + ",";
      }
      w.print( connectionsString.substring(0,connectionsString.length()-1) );
      w.print("\"\n");
    }
  }
  catch (IOException ioe) {
    // error creating/writing to file
  }
  finally  {
    if (w != null) w.close();
  }
}


