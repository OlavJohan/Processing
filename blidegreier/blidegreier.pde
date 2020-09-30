//HashMap<Farge, PImage> bilder = new HashMap<>();
ArrayList<Farge> farger = new ArrayList<Farge>();
String bildefil = "trygve.png";

void setup(){
    size(2500,2500);
    frameRate(1);
    File fu = new File("/data/Documents/Processing/blidegreier/data");
    int str = fu.list().length, ant = 0;
    for(String filnavn : fu.list() ) {
        if(filnavn.equals("fjes")) continue;
        PImage img = loadImage(filnavn);
        img.resize(50,50);
        Farge farge = new Farge(img);
        farger.add(farge);
        //image(img, (ant*50)%width,(ant++/50)*50);
        //redraw();
        //System.out.print("\r"+(ant++)+" \\ "+str+"\r");
    }
    println("\n"+farger.size());
    PImage gaute = loadImage("/fjes/"+bildefil);
    gaute.loadPixels();
    int y = 0;
    int i = 0;
    for(color c : gaute.pixels){
        Farge f = narmesteFarge(c);
        int x = (i*50)%width;
        y = (i/50)*50;
        image(f.hentBilde(), x,y,50,50);
        i++;
    }
    save("out_"+bildefil);
    //image(loadImage("gaute.png"),0,0,50,50);
    println("ferdig");
}

void draw(){}

Farge narmesteFarge(color c){
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    Farge temp = farger.get(0);
    float avstand = 1000;

    for(Farge f : farger){
        float tempAvstand = abs(r - f.r) + abs(g - f.g) + abs(b - f.b);
        if(tempAvstand < avstand){
            avstand = tempAvstand;
            temp = f;
        }
    }
    return temp;

}

private class Farge{
    color c;
    float r = 0, g = 0, b = 0;
    PImage bilde;

    int terskel = 4, gangerHentet = 0;

    public Farge(PImage p){
        bilde = p;
        bilde.loadPixels();

        int i = 0;
        for(color c : bilde.pixels){
            r += red(c);
            g += green(c);
            b += blue(c);
            i++;
        }
        r /= i; g /= i; b /= i;
        c = color(r,g,b);
    }

    public PImage hentBilde(){
        gangerHentet++;
        if(terskel == gangerHentet) farger.remove(this);
        return bilde;
    }
}