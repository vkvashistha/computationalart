
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
  size(640, 360);
  background(255);
  p = new Plant(readFromFile("grammer01.txt"));
  p.grow(6);
  
}

void draw() {
  p.render();
}
