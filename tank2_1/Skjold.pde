class Skjold extends Item{

  public Skjold(){super();}
  
  @Override
  void gi(Tank t){
    super.gi(t);
    t.mottaSkjold();
  }
  
  @Override
  Item nyItem(){ return new Skjold();}
}