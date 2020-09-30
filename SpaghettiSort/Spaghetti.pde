class Spaghetti{
    public int lengde;
    
    public Spaghetti(){
        lengde = (int)random(0, height-50);
    }
    
    public Spaghetti(int lengde){
        this.lengde = lengde;
    }
    
    void tegn(float x){
        for(int z = -20; z<20; z++) 
            line(x-(width/2), height, z, x-(width/2), height-lengde,z);
    }
}