class Mineitem extends Item{
  public Mineitem(){super();}
  
  @Override
  void gi(Tank t){
    super.gi(t);
    t.mottaMine();
  }
    
  Item nyItem(){return new Mineitem();}
}