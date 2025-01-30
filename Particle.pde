class Particle {
  private float charge;
  private Position pos;
  private Velocity vel;
  
  public Particle() {
    charge = 0.0;
    pos = new Position();
    vel = new Velocity();
  }
  
  public Particle(float charge, Position pos, Velocity vel) {
    this.charge = charge * 10e-9;
    this.pos = pos;
    this.vel = vel;
  }
  
  public float getCharge() { return charge; }
  public Position getPosition() { return pos; }
  public Velocity getVelocity() { return vel; }
  public void setCharge(float charge) { this.charge = charge; }
  public void setPosition(Position pos) { this.pos = pos; }
  public void setVelocity(Velocity vel) { this.vel = vel; }
  
  public void calculateRepel(ArrayList<Particle> particles) {
    float k = 8.988 * 10e9;
    Vector resultant = new Vector();
    for (Particle p : particles) {
      if (this != p) {
        // calculate force as a vector and add to resultant
        float distance = calcDistance(p) / PIXELS_PER_METER;
        float magnitude = k * charge * p.getCharge() / (distance * distance);
        float direction = atan2(pos.getY() - p.getPosition().getY(), pos.getX() - p.getPosition().getX());
        Vector forceV = new Vector(direction, magnitude);
        resultant = resultant.addVector(forceV);
      }
    }
    // use resultant as a force and add to velocity
    if (!showHeatMap && drawTrajectories) resultant.drawVector(pos, 128);
    vel.add(resultant);
  }
  
  private float calcDistance(Particle other) {
    return sqrt(
      (pos.getX() - other.getPosition().getX()) *
      (pos.getX() - other.getPosition().getX()) +
      (pos.getY() - other.getPosition().getY()) *
      (pos.getY() - other.getPosition().getY())
    );
  }
  
  public void update() {
    pos.updatePosition(vel);
    if (pos.getX() < 0 || pos.getX() > screenWidth) {
      vel.bounceX();
      pos.setX(pos.getX() < 0 ? 0 : screenWidth);
    }
    if (pos.getY() < 0 || pos.getY() > screenHeight) {
      vel.bounceY();
      pos.setY(pos.getY() < 0 ? 0 : screenHeight);
    }
  }
  
  public void drawParticle() {
    noStroke();
    fill(0);
    circle(pos.getX(), pos.getY(), 5);
  }
}

float PIXELS_PER_METER = 100;
