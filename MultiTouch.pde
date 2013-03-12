import android.view.MotionEvent;
class MultiTouch{
  pt currentTouch, lastTouch, disk;
  Pin p;
  boolean selected;
  int meIndex;
  pt movement; 
  ArrayList <pt>history;
  MultiTouch(){
   currentTouch=new pt();
   lastTouch= new pt();
   disk=new pt();
   selected=false;
   meIndex=-1;
   p=new Pin();
   history=new ArrayList<pt>();
  }
  MultiTouch(float x,float y,float z){
   currentTouch=new pt();
   lastTouch= new pt();
   disk=new pt(x,y,z);
   selected=false;
   meIndex=-1;
   history=new ArrayList<pt>();
  }
  void lift(){
   //this.meIndex=-1;
   this.selected=false;
   println("lift used");
  }
  void movement(int pointerId, MotionEvent ev){
    currentTouch=new pt(ev.getX(pointerId),ev.getY(pointerId),0);
    disk.move(currentTouch.subtract(lastTouch));
    lastTouch.set(currentTouch);
    println("movement used");
    history.add(lastTouch);
  }
  void touch(int pointerId,MotionEvent ev){
    this.meIndex=pointerId;
    this.selected=true;
    this.lastTouch=new pt(ev.getX(pointerId),ev.getY(pointerId),0);
    history.add(lastTouch);
     println("touch used");
  }
  void show(){
     if(this.selected){
       fill(0,255,0);
       this.disk.draw(); 
     }
     else{
       fill(255,0,0);
       this.disk.draw(); 
     }
  }
  String toString(){
    String ret="";
    ret+= "disk: "+disk;
    ret+= " currentTouch: "+currentTouch+" lastTouch: "+lastTouch+" meIndex: "+meIndex+ "Selected: "+selected;
   return ret; 
  }
  pt getHistoryAt(int i){
   return history.get(i); 
  }
  ArrayList<pt> getHistory(){
   return history; 
  }
  void setPin(Pin pin){
    p=pin;
  }
  void resetPin(){
    p=new Pin(); 
  }
  void drawHistory(){
   for(pt p: history){
      p.draw(); 
   }
  }
}
