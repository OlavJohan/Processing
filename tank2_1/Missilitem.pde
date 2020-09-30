class Missilitem extends Item{
  public Missilitem(){super();}
  
  @Override
  void gi(Tank t){
    super.gi(t);
    t.mottaMissil();
  }
    
  Item nyItem(){return new Missilitem();}
}