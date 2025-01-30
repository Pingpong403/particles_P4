int screenWidth = 1000;
int screenHeight = 700;
int numParticles = 50;
int HMD = 10; // heat map density

boolean showHeatMap = false;
boolean drawTrajectories = false;

boolean keyReady = true;
void keyReleased() {
  keyReady = true;
}

ArrayList<Particle> particles;

void settings() {
  size(screenWidth, screenHeight);
}

void setup() {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < numParticles; i++) {
    int x = (int)random(screenWidth);
    int y = (int)random(screenHeight);
    particles.add(new Particle(5.0, new Position(x, y), new Velocity(0.0, 0.0)));
  }
}

void draw() {
  background(255);
  
  // draw heat map
  if (showHeatMap) {
    for (int x = HMD / 2; x < screenWidth; x+=HMD) {
      for (int y = HMD / 2; y < screenHeight; y+=HMD) {
        Particle dummy = new Particle(5, new Position(x, y), new Velocity());
        dummy.calculateRepel(particles);
        float value = dummy.getVelocity().getSpeed() * 40000;
        noStroke();
        fill(value, value, value);
        rectMode(CENTER);
        rect(x, y, HMD, HMD);
      }
    }
  }
  
  if (keyPressed && keyReady) {
    if (keyCode == UP && showHeatMap) {
      HMD++;
    }
    else if (keyCode == DOWN && showHeatMap) {
      HMD--;
    }
    if (key == 'm' || key == 'M') {
      showHeatMap = !showHeatMap;
    }
    else if (key == 't' || key == 'T') {
      drawTrajectories = !drawTrajectories;
    }
    keyReady = false;
  }
  
  for (Particle p : particles) {
    p.calculateRepel(particles);
  }
  
  for (Particle p : particles) {
    p.update();
  }
  
  if (!showHeatMap) {
    for (Particle p : particles) {
      p.drawParticle();
    }
  }
}
