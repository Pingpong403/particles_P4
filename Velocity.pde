class Velocity {
  private float speed;
  private float angle;
  
  public Velocity()
  {
    this.speed = 0;
    this.angle = 0;
  }
  
  public Velocity(float speed, float angle)
  {
    this.speed = speed;
    this.angle = angle;
  }
  
  // getters and setters
  public float getSpeed() { return speed; }
  public float getAngle() { return angle; }
  public void setSpeed(float speed) { this.speed = speed; }
  public void setAngle(float angle) { this.angle = angle; }
  
  public void add(Vector force) {
    float fx = force.getMag() * cos(force.getDir());
    float fy = force.getMag() * sin(force.getDir());
    float vx = speed * cos(angle);
    float vy = speed * sin(angle);
    float totalX = fx + vx;
    float totalY = fy + vy;
    angle = atan2(totalY, totalX);
    speed = sqrt(totalX * totalX + totalY * totalY);
  }
  
  // bouncing
  public void bounceX()
  {
    normalize();
    angle += PI / 2;
    angle *= -1;
    angle -= PI / 2;
    normalize();
  }
  
  public void bounceY()
  {
    normalize();
    angle *= -1;
    normalize();
  }
  
  private void normalize()
  {
    while (angle >= 2 * PI) { angle -= 2 * PI; }
    while (angle < 0.0)     { angle += 2 * PI; }
  }
  
  public boolean isGoingDown()
  {
    normalize();
    return angle <= PI;
  }
  
  public boolean isGoingRight()
  {
    angle += PI / 2;
    boolean answer = isGoingDown();
    angle -= PI / 2;
    normalize();
    return answer;
  }
}
