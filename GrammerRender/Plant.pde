class Plant extends Grammer {

    private SymbolString plantString;
    private static final int DEVIATION_ANGLE=25;
    private int width=640;
    private int height=320;
    private int BRANCH_LENGTH=3;
    private int plantInclination=40;
    public Plant(String grammerString, int width, int height) {
        super(grammerString);
        plantString = generateRandomString(1);
        this.width = width;
        this.height = height;
        BRANCH_LENGTH = (int)Math.min(width*0.01,height*0.01);
    }
    
    public void setPlantInclination(int inclination) {
      plantInclination = inclination;
    }
    
    public void grow(int size) {
        plantString = generateRandomString(size);
    }

    public void render() {
        Stack<DrawParams> lastDrawParams = new Stack<>();
        DrawParams currentDrawParams = new DrawParams(plantInclination, 0, height);
        for(int i=0; i<plantString.length(); i++) {
            Symbol s = plantString.symbolAt(i);
            if("F".equals(s.toString())) {
                int posX = currentDrawParams.x;
                int posY = currentDrawParams.y;
                int angle = currentDrawParams.angle;
                int endX = posX + (int)(BRANCH_LENGTH*Math.cos(Math.toRadians(angle)));
                int endY = posY - (int)(BRANCH_LENGTH*Math.sin(Math.toRadians(angle)));
                stroke(35, 74, 44);
                line(posX, posY, endX, endY);
                currentDrawParams.x = endX;
                currentDrawParams.y = endY;
            } else if("+".equals(s.toString())) {
                currentDrawParams.angle += DEVIATION_ANGLE;
            } else if("-".equals(s.toString())) {
                currentDrawParams.angle -= DEVIATION_ANGLE;
            } else if("[".equals(s.toString())) {
                lastDrawParams.push(currentDrawParams);
                currentDrawParams = currentDrawParams.clone();
            } else if("]".equals(s.toString())) {
                currentDrawParams = lastDrawParams.pop();
            }
        }
    }
}

static class DrawParams implements Cloneable{
        int angle;
        int x,y;
        DrawParams(int angle, int x, int y) {
            this.angle = angle;
            this.x = x;
            this.y = y;
        }

        @Override
        public DrawParams clone() {
            return new DrawParams(angle, x, y);
        }
    }
