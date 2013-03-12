import processing.opengl.*;            // comment out if not using OpenGL
import android.view.KeyEvent;
import java.io.File;
import java.util.Scanner;
File yourFile;
ArrayList<pt> A, B, C, D;//Declare finger movement lists
pair L, R;
float roi=100;
float t=0.0;
float f=0;
float recordF=0;
boolean realTime=true;
Scanner scan;
boolean record;
static boolean animate;
boolean showMenu,saveAnimationFrame;
boolean showSpirals=true;
MultiTouchController mController;    //Multiple Finger touch object
PImage myImage;     // image used as tecture 
color red = color(200, 10, 10), blue = color(10, 10, 200), green = color(10, 200, 20), 
magenta = color(200, 50, 200), black = color(10, 10, 10); 
Menu m;
int tracking;
void setup() {               // executed once at the begining 
  size(800, 800, OPENGL); 
  mController=new MultiTouchController();
  mController.init();
  //frameRate(30);             // render 30 frames per second
  smooth();                  // turn on antialiasing
  //loadUserImage();
  myImage = loadImage("jarek.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  ww=1.0/(n-1); 
  hh=1.0/(n-1);                             // set intial width and height of a cell
  w=800*ww; 
  h=800*hh;                                            // set intial width and height of a cell in normalized [0,1]x[0,1]
  L=new pair();
  R=new pair();
  animate=false;
  showMenu=false;

  m=new Menu(); 
  tracking=0;
  ///*************Adding history of points lists
  A=new ArrayList<pt>();
  B=new ArrayList<pt>();
  C=new ArrayList<pt>();
  D=new ArrayList<pt>();
  //****************

}
void draw() {      // executed at each frame
  background(255); // clear screen and paints white background
    resetVertices();
  

  if(!animate)try{setPairs();
       fill(black);
    drawArrayList(A);
    fill(red);drawArrayList(B);
    fill(black);
    drawArrayList(C);
    fill(green);drawArrayList(D);  noFill();

  }
  catch(Exception e){
    
  }
  if (showMenu) {
    m.draw();
  }
  if(showSpirals){
   try{
     R.showAll();}
     catch(Exception e){
     e.printStackTrace(); 
   }
   try{
     L.showAll(); 
   }
     catch(Exception e){
     e.printStackTrace(); 
   }
    
  }
  if (animate) { 
    if(realTime){
      animateUpdate1(tracking);
        
    }
    roi=d(L.ctr(),R.ctr());
    L.evaluate(f);
    R.evaluate(f);
    warpVertices(L,f,roi);
    warpVertices(R,f,roi);
    if(!realTime){
      t+=0.02; if (t>=4) t=0; f=sq(cos(t*PI/2));}
    else{
     tracking++; 
     f=1;
   }
 //   drawArrayList(A);drawArrayList(B);drawArrayList(C);drawArrayList(D);  
  }
  if (showTexture)  paintImage();if(saveAnimationFrame)saveAnimationFrame();
  if(!animate){
    try {
      mController.show();
    }
    catch(Exception e) {
    } 
  }
  else{

  }
 
}  // end of draw()

/********************************************************************************************/
//Override android touch events
/*******************************************************************************************/

public boolean surfaceTouchEvent(MotionEvent me) {//Overwrite this android touch method to process touch data
  int action= whichAction(me);
  if (action==1) {
    if (me.getY()>600&&showMenu) {
      m.buttonPressed(me);//User has pressed a menu button
    }
    else {
      mController.touch(me, whichFinger(me)); //Register the touch event
      if(me.getPointerCount()==4){
        record=true; 
      }
      updateHistory();
    }
  }
  else if (action==0) {
    mController.lift(whichFinger(me)); //Register the lift event
 
     record =false; 
     
    
  }
  else if (action==2) {
    mController.motion(me);//Register the motion event
    updateHistory();
  }
  return super.surfaceTouchEvent(me);
}  
int whichAction(MotionEvent me) { // 1=press, 0=release, 2=drag
  int action = me.getAction(); 
  int aaction = action & MotionEvent.ACTION_MASK;
  int what=0;
  if (aaction==MotionEvent.ACTION_POINTER_UP || aaction==MotionEvent.ACTION_UP) what=0;
  if (aaction==MotionEvent.ACTION_DOWN || aaction==MotionEvent.ACTION_POINTER_DOWN) what=1;
  if (aaction==MotionEvent.ACTION_MOVE) what=2;
  return what;
}  
int whichFinger(MotionEvent me) {
  int pointerIndex = (me.getAction() & MotionEvent.ACTION_POINTER_INDEX_MASK)>> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
  int pointerId = me.getPointerId(pointerIndex);
  return pointerId;
}
/**************************************************************************************/
//*******************End of Surface Touch event override******************************//
/**************************************************************************************/

void setStartPair() {
  L.A0=A.get(0);
  L.B0=B.get(0);
  R.A0=C.get(0);
  R.B0=D.get(0);
}
void setEndPair() {
  L.A1=A.get(A.size()-1);
  L.B1=B.get(B.size()-1);
  R.A1=C.get(C.size()-1);
  R.B1=D.get(D.size()-1);
}
void setPairs() {
  L= new pair(A.get(0), B.get(0), A.get(A.size()-1), B.get(B.size()-1));
  R=new pair(C.get(0),D.get(0),C.get(C.size()-1),D.get(D.size()-1));

}
void updateHistory(MotionEvent me) {
  if (whichFinger(me)==0) {
    A.add(new pt(me.getX(0), me.getY(0)));
  }
  else if (whichFinger(me)==1) {
    B.add(new pt(me.getX(1), me.getY(1)));
  }
  else if (whichFinger(me)==2) {
    C.add(new pt(me.getX(2), me.getY(2)));
  }
  else if (whichFinger(me)==3) {
    D.add(new pt(me.getX(3), me.getY(3)));
  }
}
void updateHistory() {
  A.add(new pt(mController.getDiskAt(0).x, mController.getDiskAt(0).y, 0));
  B.add(new pt(mController.getDiskAt(1).x, mController.getDiskAt(1).y, 0));
  C.add(new pt(mController.getDiskAt(2).x, mController.getDiskAt(2).y, 0));
  D.add(new pt(mController.getDiskAt(3).x, mController.getDiskAt(3).y, 0));
}
void updateHistoryOnMove(MotionEvent me) {
  for (int i=0;i<me.getPointerCount();i++) {
    int index=me.getPointerId(i);
    if (index==0)
      A.add(new pt(me.getX(index), me.getY(index), 0));
    else if (index==1)
      B.add(new pt(me.getX(index), me.getY(index), 0));
    else if (index==2)
      C.add(new pt(me.getX(index), me.getY(index), 0));
    else if (index==3)
      D.add(new pt(me.getX(index), me.getY(index), 0));
  }
}
void animateUpdate(int index) {
  if (A.size()>index) {
    L.At=new pt(A.get(index).x,A.get(index).y,0);
    //println("Inside Animate Update: "+L.At);
  }
  if (B.size()>index)
    L.Bt=B.get(index);
  if (C.size()>index)
    R.At=C.get(index);
  if (D.size()>index)
    R.Bt=D.get(index);
}
void animateUpdate1(int index) {

  if (A.size()>index) {
    L.A1=A.get(index);
  }
  if (B.size()>index)
    L.B1=B.get(index);
  if (C.size()>index)
    R.A1=C.get(index);
  if (D.size()>index)
    R.B1=D.get(index);
}
public void keyPressed() {//Display menu
  if (key == CODED) {
    if (keyCode == KeyEvent.KEYCODE_MENU) {
      showSpirals=false;
      //saveAnimationFrame=true;
      animate=true;
  
    }
  }
}
void drawArrayList(ArrayList<pt> list) {
  for (pt p: list) {
    p.draw();
  }
}
void saveAnimationFrame(){  
  saveFrame("//sdcard//Animation/animation#####.png"); 

}
void printArrayList(ArrayList<pt> list) {
  for (pt p: list) {
    System.out.println("p: "+p);
  }
}


/***************Development Section*/


/****************/

