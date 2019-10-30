class Body {
  PVector pos;
  PVector vel;
  PVector dist;
  float distance;
  PVector acc;
  PVector size;
  int mass;
  color col;
  
  Body (int x_pos, int y_pos, int x_size, int y_size, int mymass, float startVelX, float startVelY, color c) {
    pos = new PVector(x_pos, y_pos);
    vel = new PVector(startVelX, startVelY);
    size = new PVector(x_size, y_size);
    mass = mymass;
    col = c;
  }
  
  void update (Body Planet) {
    dist = new PVector(Planet.pos.x, Planet.pos.y);
    dist.sub(this.pos);
    distance = this.dist.mag();
    
    this.acc = new PVector((this.dist.x/this.distance) * (Planet.mass/( this.distance * this.distance)), (this.dist.y/this.distance) * (Planet.mass/( this.distance * this.distance)));
    this.vel.add(this.acc);
    this.pos.add((this.vel));
  }
  
  void display () {
    fill(col);
    ellipse(pos.x, pos.y, size.x, size.y); 
  }
  
  boolean collide(Body Other) {
    boolean flag = false;
    
    flag = (dist(Other.pos.x, Other.pos.y, this.pos.x, this.pos.y) <= (Other.size.x/2) + (this.size.x/2));
    
    return flag;
  }
  
}

//Body Mars = new Body(500, 100, 20, 20, 25, 2, color(255, 0, 0)));
//Body Earth = new Body(100, 100, 20, 20, 100, 2.5, color(0, 200, 255));
//Body Sun2 = new Body(200, 300, 50, 50, 500, 0, color(0, 200, 255));
//Body Sun = new Body(400, 300, 50, 50, 500, 0, color(251, 255, 63));
ArrayList<Body> bodies = new ArrayList<Body>();

PVector offset;
PVector poffset;
PVector mouse;

float zoom;

int fps = 20;

void setup() {
  frameRate(fps);
  
  size(1820, 900);
  stroke(0);
  strokeWeight(3);
  textFont(createFont("Arial", 16, true), 32);
  
  offset = new PVector(0, 0);
  poffset = new PVector(0, 0);
  
  zoom = 0.5;
  // Moon
  bodies.add( new Body(0, 600, 20, 20, 50000, 20, 0, color(170, 170, 169)) );
  
  //Earth
  bodies.add( new Body(0, 0, 50, 50, 1000000, 0, 0, color(0, 200, 255)) );
  
  // Moon 
  bodies.add( new Body(-200, 500, 10, 10, 100, -15, 0, color(0, 0, 0)) );
  
  //bodies.add( new Body(500, 100, 20, 20, 250, 2, 0, color(255, 0, 0)));
  
  /*bodies.add( new Body(0, 0, 50, 50, 100000, 0, 0, color(0, 200, 255)) );
  bodies.add( new Body(0, 600, 20, 20, 1000, -5, 0, color(170, 170, 169)) );
  
  for (int i = 0; i < 2; i++) {
   bodies.add ( new Body((int)(random(-1000, 1000)), 
                         (int)(random(-1000, 1000)), 
                         20, 
                         20, 
                         (int)(random(100, 100000)), 
                         0, 
                         0, 
                         color((int)(random(0, 255)), (int)(random(0, 255)), (int)(random(0, 255))) )); 
  }*/
}

void draw() {  
  background(255, 10);
  
  text("A/Z to move in/out, drag to move\n P/L to raise/lower the FPS:" + ceil(frameRate) + "\n Bodies in the sim:" + bodies.size(), 10, 100);
  
  pushMatrix();
  
  
  
  translate(width/2, height/2);
  
  scale(zoom);
   
  translate(offset.x/zoom, offset.y/zoom);
  
  fill(0);
  
  outer: for (int i = bodies.size() - 1; i >= 0; i--){
    bodies.get(i).display();
    
    for (int j = bodies.size() - 1; j >= 0; j--) { if (i == j) { continue; };
      bodies.get(i).update(bodies.get(j));
      
      if (bodies.get(i).collide(bodies.get(j))) {
        Body current = bodies.get(i);
        Body other = bodies.get(j);
         
        bodies.add( new Body((int)(current.pos.x + (current.size.x/2)),            // X Position
                              (int)(current.pos.y + (current.size.y/2)),            // Y Position
                              (int)((current.size.x/2) + (other.size.x/2)),         // X Size
                              (int)((current.size.y/2) + (other.size.y/2)),         // Y Size
                              current.mass + other.mass,                            // Mass
                              current.vel.x + other.vel.x,                          // X Starting Velocity
                              current.vel.y + other.vel.y,                          // Y Starting Velocity
                              color(ceil(random(0, 255)), floor(random(0, 255)), ceil(random(0, 255)))) );
          
        bodies.remove(i);
        bodies.remove(j);
        
        break outer;
      }
    }
  }
  
  popMatrix();
}

void keyPressed() {
  if (key == 'a') {
    zoom += 0.1;
  } 
  else if (key == 'z') {
    zoom -= 0.1;
  }
  
  if (key == 'p') {
      fps += 5;
      frameRate(fps);
  }
  else if (key == 'l') {
      fps -= 5;
      frameRate(fps);
  }
  
  zoom = constrain(zoom,0,100);
}


void mousePressed () {
  mouse = new PVector(mouseX, mouseY);
  poffset.set(offset);
}

void mouseDragged () {
  offset.x = poffset.x + mouseX - mouse.x;
  offset.y = poffset.y + mouseY - mouse.y;
}
