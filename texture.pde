int n=50;                                   // size of grid. Must be >2!
pt[][] G = new pt [n][n];                  // array of vertices
boolean showVertices=false, showEdges=false, showTexture=true;  // flags for rendering vertices and edges
float w,h,ww,hh;                                  // width, height of cell in absolute and normalized units

void resetVertices() {   // resets points and laplace vectors 
   for (int i=0; i<n; i++) for (int j=0; j<n; j++) G[i][j]= P(i*w,j*h); 
   } 

void warpVertices(pt LA0, pt LB0, pt LA1, pt LB1, pt RA0, pt RB0, pt RA1, pt RB1, float f) { 
   for (int i=0; i<n; i++) for (int j=0; j<n; j++) G[i][j]= spirals(LA0,LB0,LA1,LB1,RA0,RB0,RA1,RB1,f,P(i*w,j*h));   
   }
    
void warpVertices(pair L, float f, float roi) { 
   for (int i=0; i<n; i++) for (int j=0; j<n; j++) G[i][j] = L.warp(G[i][j],f,roi);  
   }
    
void warpVertices(pair L, pair R, float f) { 
   for (int i=0; i<n; i++) for (int j=0; j<n; j++) G[i][j] = warp(L,R,f,G[i][j]);  
   }
    

void paintImage() {
   noStroke(); noFill(); textureMode(NORMAL);       // texture parameters in [0,1]x[0,1]
   beginShape(QUADS); 
   for (int i=0; i<n-1; i++) {
     beginShape(QUAD_STRIP); texture(myImage); 
     for (int j=0; j<n; j++) { 
        vertex(G[i][j].x,    G[i][j].y,      i*ww, j*hh); 
        vertex(G[i+1][j].x, G[i+1][j].y, (i+1)*ww, j*hh); };
     endShape();
     }
   }
  
void drawEdges() {
   stroke(black); noFill(); 
   beginShape(QUADS); 
   for (int i=0; i<n-1; i++) {
      beginShape(QUAD_STRIP);  
      for (int j=0; j<n; j++) { vertex(G[i][j].x, G[i][j].y); vertex(G[i+1][j].x, G[i+1][j].y); };
      endShape();
      };
   }

void drawVertices() {
   noStroke(); fill(red); 
   for (int i=0; i<n; i++) for (int j=0; j<n;j++) show(G[i][j],1);
   }

