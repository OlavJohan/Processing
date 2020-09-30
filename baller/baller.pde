ArrayList<Ball> baller = new ArrayList<Ball>();

void setup(){
    //size(800, 800, P3D);
    fullScreen(P3D);
    colorMode(HSB, 255);
    for(int i = 0; i<500; i++) baller.add(new Ball());
    noCursor();
    noStroke();
}
int x = 400;
void draw(){
    background(0);
    noLights();
    
    spotLight(255, 0, 255, mouseX, mouseY, 300, 0, 0, -1, PI, 10);         
    for(Ball b : baller) b.tegn();
    //speil();
}

void speil(){
    shininess(0);
    fill(255,0,255);
    lightSpecular(255, 0, 0);
    beginShape(); 
    vertex(0,0, -202); 
    vertex(width,0, -202);  
    vertex(width,height, -200);  
    vertex(0,height, -200); 
    endShape(CLOSE) ;
}