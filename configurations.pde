  //Testing reading from android file//Can read from file here. Need to allow user to enter in the pathname
 // File dir = Environment.getExternalStorageDirectory();

  //*********************************
void loadUserImage(){
  try{
    scan= new Scanner(new File("//sdcard//WARPIC/testScan4.txt"));
  }
  catch(Exception e){
   e.printStackTrace(); 
  }
  String pathname=scan.nextLine();
  println("pathname: "+pathname);
  yourFile = new File(pathname);
}
void 
