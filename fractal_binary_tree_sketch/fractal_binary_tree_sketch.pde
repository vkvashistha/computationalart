final int width = 480;
final int height = 480;
String smallTree = generateString(4, "0");
void setup() {
  size(480, 480);
  for(int i=0; i<3; i++) {
  String tree = generateString(i, "0");
  System.out.println("tree : "+ tree);
  }
}

void draw() {
  drawTree(PI/2, 240, 480, smallTree);  
  //int pos [] = drawBranch(PI/2, 240, 480);
  //pos = drawLeaf(PI/2 + PI/4, pos[0], pos[1]);
  //pos = drawLeaf(PI/2 - PI/4, pos[0], pos[1]);
}

String drawTree(float currentAngle, int posX, int posY, String treeString) {
  int charPos = 0;
  while(treeString.length() > charPos) {
    char ch = treeString.charAt(charPos);
    if(ch == '1') {
      int[] pos = drawBranch(currentAngle, posX, posY);
      posX = pos[0];
      posY = pos[1];
      charPos++;
    }
    if(ch == '0') {
      int[] pos = drawLeaf(currentAngle, posX, posY);
      posX = pos[0];
      posY = pos[1];
      charPos++;
    }
    
    if(ch == '[') {
      String newString = treeString.substring(charPos+1, treeString.length());
      treeString = drawTree(currentAngle + PI/4,posX, posY, newString);
      currentAngle = currentAngle - PI/4;
      charPos = 0;
    }
    
    if(ch == ']') {
      return treeString.substring(charPos+1, treeString.length());
    }
    
  }
  return "";
}

int[] drawBranch(float angle, int posX, int posY) {
  final int BRANCH_LENGTH = 10;
  int endX = posX + (int)(BRANCH_LENGTH*cos(angle));
  int endY = posY - (int)(BRANCH_LENGTH*sin(angle));
  line(posX, posY, endX, endY);
  return new int[] {endX, endY};
}

int[] drawLeaf(float angle, int posX, int posY) {
  final int BRANCH_LENGTH = 5;
  int endX = posX + (int)(BRANCH_LENGTH*cos(angle));
  int endY = posY - (int)(BRANCH_LENGTH*sin(angle));
  line(posX, posY, endX, endY);
  return new int[] {endX, endY};
}

String generateString(int recursion, String axiom) {
  if(recursion < 0) {
    return axiom;
  }
  if(axiom == "1") {
    return generateString(recursion - 1, "1") + generateString(recursion - 1, "1");
  }
  if(axiom == "0") {
    return generateString(recursion - 1, "1") +
    generateString(recursion - 1, "[") + 
    generateString(recursion - 1, "0") +
    generateString(recursion - 1, "]") +
    generateString(recursion - 1, "0");
  }
  if(axiom == "[") {
    return "[";
  }
  if(axiom == "]") {
    return "]";
  }
  
  return "error";
}

  
