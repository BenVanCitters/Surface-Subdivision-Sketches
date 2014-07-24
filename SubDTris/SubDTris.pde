//SubDTriSurf s;
ArrayList<SubDTriSurf> myOBJSubs;
ArrayList<SubDTriSurf> mySubs;
boolean capturing = false;
float curTime = 0f;
void setup()
{
  size(screenWidth,screenHeight,P3D);
  initLPD8();
//  noCursor();
parsePointsAndFaces("skull2.obj");
//  s = new SubDTriSurf();
  mySubs = new ArrayList<SubDTriSurf>();
  myOBJSubs= new ArrayList<SubDTriSurf>();
  for(int i = 0; i < tris.length; i++)
  {
    SubDTriSurf s = new SubDTriSurf();
    
    s.verts[0]= pts[tris[i][0]-1];
    s.verts[1]= pts[tris[i][1]-1];
    s.verts[2]= pts[tris[i][2]-1];
    myOBJSubs.add(s); 
  }
}

void recurSubDiv(int level, ArrayList<SubDTriSurf> surf)
{
  for(SubDTriSurf ff : surf)
  {
    float[] centerPt = ff.getCenterPoint();
    float modVal = (1+sin(curTime*5+centerPt[0]))/2;
    if(level < 1)
      mySubs.add(ff);
    else
    recurSubDiv(level-1,ff.subD());
  }
}

void draw()
{
  float maxDispl = 8;
  normalDisplacementFactor = mouseX*maxDispl/height;
  subdivRecurDepth = (10*mouseX)/width;
  
  float tm  = globalTimeScale* (frameCount*1000.f/30.f)/15600.f;//millis()/2000.f;
  curTime = tm; 
  mySubs.clear();
//  s.animateStartingShape(tm);
//ArrayList<SubDTriSurf>
  for(SubDTriSurf s: myOBJSubs)
  {
    recurSubDiv(subdivRecurDepth,s.subD());
  } 
  println("myOBJSubs: " + myOBJSubs.size());
  directionalLight(255,0,0,0,1,.5);
  directionalLight(0,255,0,0.1,1,.1);
  directionalLight(0,0,255,0.5,1,0);
  background(255,155,155);
  float[] centerPt = new float[]{0,0,0};

//  translate(width/2-centerPt[0],600,100);
  translate(width/2-centerPt[0],height/2-centerPt[1],0);
  scale(55.5);

//  scale(15.5);
  
  pushMatrix();
  rotate(tm);
  rotateX(tm);

  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  for(SubDTriSurf sSs : mySubs)
  {
    sSs.passTriVerts();
  }
  endShape();
  popMatrix();
  
  println("frameRate: " + frameRate + " subs: " + (int)(mouseY*13/height));
//  if(capturing)
//  {
//    saveFrame("frames/####.png");
//  }
}
