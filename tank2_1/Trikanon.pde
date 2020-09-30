class Trikanon extends Item{
  public Trikanon(){super();}
  
  @Override
  void gi(Tank t){super.gi(t); t.mottaTrikanon();}
  
  @Override
  Item nyItem(){ return new Trikanon();}
}