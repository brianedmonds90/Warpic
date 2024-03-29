class Button{
  String title;
  int x,y;
  public Button(String myTitle,int myX,int myY){
    title=myTitle;
    x=myX;
    y=myY;
  } 
  void draw(){
    fill(255);
    strokeWeight(5);
    stroke(255,0,0);
    rect(x, y, 200, 100);
    fill(0);
    text(title, x+5, y+75); 
    noStroke();
  }
  boolean pressed(MotionEvent me){
    if(me.getX()<x){
       return false;
    } 
    if(me.getX()>x+200){
       return false; 
    }
    if(me.getY()<y){
       return false; 
    }
    if(me.getY()>y+100){
      return false; 
    }
    return true;
  }
}
