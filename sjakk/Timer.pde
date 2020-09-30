class Timer{
    boolean white, running, timeout;
    int minutes, milliseconds, lastMillis;
    float textSize, xPos, yPos;
    PFont font;
    color col;
    
    public Timer(boolean white, int minutes){
        this.white = white;
        this.minutes = minutes;
        milliseconds = minutes * 60 * 1000;
        lastMillis = millis();
        running = false;
        float totalSpace = brett.yStart;
        textSize = totalSpace / 2;
        xPos = width/2;
        yPos = totalSpace + (rutestorrelse * 8) + (totalSpace/2);
        font = createFont("fonts/DS-DIGI.TTF", textSize);
        col = (timerMinutes == 0)? color(0) : color(0, 255, 0);
    }
    
    void drawAndUpdate(){
        update();
        draw();
        
    }
    
    void update(){
        if(running) milliseconds -= (millis() - lastMillis);
        lastMillis = millis();
        timeout = (milliseconds <= 0);
    }
    
    void draw(){
        String timeString = (milliseconds <= 0) ? "TIME" : getMinutes() + ":" + getSeconds();
        textAlign(CENTER, CENTER);
        fill(col); textSize(textSize);
        textFont(font);
        
        if(white) text(timeString, xPos, yPos);
        else{
            pushMatrix();
            translate(width, height);
            rotate(radians(180));
            text(timeString, xPos, yPos);
            popMatrix();
        }
        
    }
    
    void start(){
        running = true;
    }
    void stop(){
        running = false;
    }
    
    String getMinutes(){
        int m = milliseconds/60001;
        String s = (m < 10) ? "0" + m : "" + m;
        return s;
    }
    
    String getSeconds(){
        int m = milliseconds/60000;
        int s = (((milliseconds - m) / 1000)) % 60;
        String str = (s < 10) ? "0" + s : "" + s;
        return str;
    }
    
    void toggleTurn(boolean b){
        if(totalMoves == 1) return;
        if(white == b) start();
        else stop();
    }

}
