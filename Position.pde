class Position {
  private float x;
  private float y;

  public Position()
  {
    x = 0.0;
    y = 0.0;
  }
  
  public Position(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  // getters and setters
  public float getX() { return x; }
  public float getY() { return y; }
  public void setX(float x) { this.x = x; }
  public void setY(float y) { this.y = y; }
  
  // manipulation
  public void updatePosition(Velocity vel)
  {
    x += vel.getSpeed() * cos(vel.getAngle());
    y += vel.getSpeed() * sin(vel.getAngle());
  }
}
