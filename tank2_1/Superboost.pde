class Superboost extends Item{
  public Superboost(){super();}
  
  @Override
  void gi(Tank t){
    super.gi(t);
    t.mottaSuperboost();
  }
  
  @Override
  Item nyItem(){
    return new Superboost();
  }
}