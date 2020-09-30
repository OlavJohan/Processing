class Fnugg{
  int multiplier = 3;
  PVector pos, rot, curRot;
  float curRX, curRY, curRZ, ranRot = 1.5;
  float speed;
  Sparticle sparts[];
  
  Fnugg(){
    int x = (int)random(width * -multiplier, width * multiplier),
        y = (int)random(height * -multiplier, height * multiplier),
        z = (int)random(-600, 30);
    pos = new PVector(x,y,z);
    float rotX = random(-ranRot, ranRot),
    rotY = random(-ranRot, ranRot),
    rotZ = random(-ranRot, ranRot);
    rot = new PVector(rotX, rotY, rotZ);
    curRot = new PVector(random(0, 360), random(0, 360), random(0, 360));
    speed = random(2, 5);
    sparts = new Sparticle[8];
    for(int i = 0; i<sparts.length; i++) sparts[i] = new Sparticle();
  }
  
  void draw(){
    stroke(230, 230, 255);
     pos.y += speed;
    curRot.x += rot.x;
    curRot.y += rot.y;
    curRot.z += rot.z;
    if(height * multiplier < pos.y) pos.y = height * -multiplier;
    boolean lang = true;
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    rotateX(radians(curRot.x));
    rotateY(radians(curRot.y));
    rotateZ(radians(curRot.z));
    for(float rt = 0; rt < 359; rt += 360.0/10){
      pushMatrix();
      rotate(radians(rt));
      line(0, 0, 0, (lang)? -50 : -25);
      if(lang){
        line(0, -30, -20, -45);
        line(0, -30, 20, -45);
        
        line(0, -40, -20, -55);
        line(0, -40, 20, -55);
        
        line(0, -50, -7, -57);
        line(0, -50, 7, -57);
        
        line(0, -20, -7, -27);
        line(0, -20, 7, -27);
      }else {
        line(0, -25, -7, -32);
        line(0, -25, 7, -32);
      }
      lang = !lang;
      popMatrix();
    }
    for(Sparticle s : sparts) s.draw();
    popMatrix();
    
  }
}
