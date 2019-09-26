final int width = 800;
final int height = 600;
float deviationAngle = radians(25);
String smallTree = generateString(6, "X");
void setup() {
  background(255);
  size(800, 600);
  System.out.println("tree : "+ smallTree);
}

void draw() {
  drawTree(radians(40), 0, height, smallTree);  
  //int pos [] = drawBranch(PI/2, 240, 480);
  //pos = drawLeaf(PI/2 + PI/4, pos[0], pos[1]);
  //pos = drawLeaf(PI/2 - PI/4, pos[0], pos[1]);
}

String drawTree(float currentAngle, int posX, int posY, String treeString) {
  int charPos = 0;
  while(treeString.length() > charPos) {
    char ch = treeString.charAt(charPos);
    if(ch == 'F') {
      int[] pos = drawBranch(currentAngle, posX, posY);
      posX = pos[0];
      posY = pos[1];
      charPos++;
    }
    if(ch == 'X') {
      charPos++;
    }
   
    if(ch == '+') {
      currentAngle = currentAngle+deviationAngle;
      charPos++;
    }
    
    if(ch == '-') {
      currentAngle = currentAngle-deviationAngle;
      charPos++;
    }
    
    if(ch == '[') {
      String newString = treeString.substring(charPos+1, treeString.length());
      treeString = drawTree(currentAngle,posX, posY, newString);
      charPos = 0;
    }
    
    if(ch == ']') {
      return treeString.substring(charPos+1, treeString.length());
    }
    
  }
  return "";
}

int[] drawBranch(float angle, int posX, int posY) {
  final int BRANCH_LENGTH = 3;
  int endX = posX + (int)(BRANCH_LENGTH*cos(angle));
  int endY = posY - (int)(BRANCH_LENGTH*sin(angle));
  stroke(180,210,45);
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
  if(axiom == "F") {
    return generateString(recursion - 1, "F") + generateString(recursion - 1, "F");
  }
  if(axiom == "X") {
    return generateString(recursion - 1, "F") +
    generateString(recursion - 1, "+") + 
    generateString(recursion - 1, "[") +
    generateString(recursion - 1, "[") +
    generateString(recursion - 1, "X") +
    generateString(recursion - 1, "]") +
    generateString(recursion - 1, "-") +
    generateString(recursion - 1, "X") +
    generateString(recursion - 1, "]") +
    generateString(recursion - 1, "-") +
    generateString(recursion - 1, "F") +
    generateString(recursion - 1, "[") +
    generateString(recursion - 1, "-") +
    generateString(recursion - 1, "F") +
    generateString(recursion - 1, "X") +
    generateString(recursion - 1, "]") +
    generateString(recursion - 1, "+") +
    generateString(recursion - 1, "X");
  }
  if(axiom == "[") {
    return "[";
  }
  if(axiom == "]") {
    return "]";
  }
  
  if(axiom == "+") {
    return "+";
  }
  
  if(axiom == "-") {
    return "-";
  }
  
  return "error";
}

  
