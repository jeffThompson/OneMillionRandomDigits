
void readDataFromFile() {
  
  digitsFromFile = new int[1000000];
  try {
    BufferedReader reader = createReader(filename);
    String tempLine;
    int index = 0;
    while ( (tempLine = reader.readLine ()) != null) {
      for (int i=8; i<tempLine.length (); i++) {
        if (tempLine.charAt(i) != ' ') {
          digitsFromFile[index] = Character.getNumericValue(tempLine.charAt(i));
          index++;
        }
      }
    }
  }
  catch (IOException ioe) {
    // error reading file :(
  }
}


