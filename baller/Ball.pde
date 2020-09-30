class Ball{
    float x,y,z,fart, cury;
    int farge;
    int bunnpunkt = height+500, str = 20;
    
    public Ball(){
        x = random(-width, width*2);
        y = random(-800, -100);
        z = random(-200,0);
        fart = map(z, -200,0, 5, 10);
        farge = (int)random(0,255);
        cury = y;
    }
    
    public void tegn(){
        cury += fart;
        //colorMode(HSB, 255);
        fill(farge, 255,255);
        //lightSpecular(farge, 255, 255);
        //specular(farge,255,255);
        emissive(farge,255,20);
        pushMatrix();
        translate(x,cury,z);
        sphere(str);
        popMatrix();
        if(cury > bunnpunkt) cury = y;
    }

}