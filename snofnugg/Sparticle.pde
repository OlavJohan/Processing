class Sparticle{
  
  float oscSpeed;
  PVector rot, rotSpeed, distance;
  float c;
  boolean up = false, rotationPluss;
  

  Sparticle(){
    distance = new PVector(random(-40, 40), random(-40, 40), random(-40, 40));
    rot = new PVector(random(0, 360), random(0, 360), random(0, 360));
    rotSpeed = new PVector(random(0, 1), random(0, 1), random(0, 1));
    rotationPluss = random(0,100) > 50;
    c = (int)random(0,255);
    oscSpeed = 0.5;
  }
  
  void draw(){
    fill(c);
    stroke((int)c);
    stroke((int)c);
    pushMatrix();
    translate(distance.x, distance.y, distance.z);
    rotateX(radians(rot.x));
    rotateY(radians(rot.y));
    rotateZ(radians(rot.z));
    ellipse(0,0,1,2);
    popMatrix();
    rot.x += (rotationPluss ? 1 : -1) * rotSpeed.x;
    rot.y += (rotationPluss ? 1 : -1) * rotSpeed.y;
    rot.z += (rotationPluss ? 1 : -1) * rotSpeed.z;
    oscillate();
  }
  
  void oscillate(){
    if(up){
      c += oscSpeed;
      up = (c < 255);
    }else{
      c -= oscSpeed;
      up = c < 20;
      c = (c < 0) ? 0 : c;
    }
  }

}
