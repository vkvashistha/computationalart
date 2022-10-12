class Plant extends Grammer {

    private SymbolString plantString;
    private static final int DEVIATION_ANGLE=25;
    private static final int SCREEN_WIDTH=640;
    private static final int SCREEN_HEIGHT=320;
    private static final int BRANCH_LENGTH=1;
    private static final int LEAF_LENGTH=5;
    public Plant(String grammerString) {
        super(grammerString);
        plantString = generateRandomString(1);
    }
    
    public void grow(int size) {
        plantString = generateRandomString(size);
    }

    public void render() {
        Stack<DrawParams> lastDrawParams = new Stack<>();
        DrawParams currentDrawParams = new DrawParams(40, SCREEN_WIDTH/2, SCREEN_HEIGHT);
        for(int i=0; i<plantString.length(); i++) {
            Symbol s = plantString.symbolAt(i);
            if("F".equals(s.toString())) {
                int posX = currentDrawParams.x;
                int posY = currentDrawParams.y;
                int angle = currentDrawParams.angle;
                int endX = posX + (int)(BRANCH_LENGTH*Math.cos(Math.toRadians(angle)));
                int endY = posY - (int)(BRANCH_LENGTH*Math.sin(Math.toRadians(angle)));
                stroke(180,210,45);
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
