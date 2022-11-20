
String readFromFile(String filename) {
  String [] lines = loadStrings(filename);
  StringBuilder builder = new StringBuilder();
  for (int i = 0; i < lines.length; i++) {
    builder.append(lines[i]).append("\n");
  }
  return builder.toString();
}

SymbolString output;
Plant p;
void setup() {
  size(640, 320);
  background(206, 220, 242);
  p = new Plant(readFromFile("grammer01.txt"),640,320);
  p.setPlantInclination(50);
  p.grow(6);
  
}

void draw() {
  pushMatrix();
  translate(60, 0);
  p.render();
  popMatrix();
}
