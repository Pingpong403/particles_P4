class Vector {
  private float dir;
  private float mag;
  
  public Vector() {
    dir = 0.0;
    mag = 0.0;
  }
  
  public Vector(Vector other) {
    dir = other.getDir();
    mag = other.getMag();
  }
  
  public Vector(float dir, float mag) {
    this.dir = dir;
    this.mag = mag;
  }
  
  public float getDir() { return dir; }
  public float getMag() { return mag; }
  public void setDir(float dir) { this.dir = dir; }
  public void setMag(float mag) { this.mag = mag; }
  
  public Vector addVector(Vector other) {
    float x1 = mag * cos(dir);
    float y1 = mag * sin(dir);
    float x2 = other.getMag() * cos(other.getDir());
    float y2 = other.getMag() * sin(other.getDir());
    
    float newDir = atan2(y1 + y2, x1 + x2);
    float newMag = sqrt((x1 + x2) * (x1 + x2) + (y1 + y2) * (y1 + y2));
    return new Vector(newDir, newMag);
  }
  
  public Vector subVector(Vector other) {
    float negativeDir = dir + PI;
    Vector negativeVector = new Vector(negativeDir, mag);
    return negativeVector.addVector(other);
  }
  
  public void drawVector(Position pos, int value) {
    float endX = pos.getX() + mag * cos(dir);
    float endY = pos.getY() + mag * sin(dir);
    stroke(value);
    strokeWeight(3);
    noFill();
    line(pos.getX(), pos.getY(), endX, endY);
    Vector line1 = new Vector();
    Vector line2 = new Vector();
    line1.setDir(dir + PI - PI / 6);
    float len = 20/* - 50.0 / mag*/;
    line1.setMag(len > 0 ? len : 0);
    line2.setDir(dir + PI + PI / 6);
    line2.setMag(len > 0 ? len : 0);
    
    // draw the two lines to make it more understandable
    float endXL1 = endX + line1.getMag() * cos(line1.getDir());
    float endYL1 = endY + line1.getMag() * sin(line1.getDir());
    line(endX, endY, endXL1, endYL1);
    
    float endXL2 = endX + line2.getMag() * cos(line2.getDir());
    float endYL2 = endY + line2.getMag() * sin(line2.getDir());
    line(endX, endY, endXL2, endYL2);
  }
}
