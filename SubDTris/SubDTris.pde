SubDTriSurf s;
ArrayList<SubDTriSurf> mySubs;
boolean capturing = false;
float curTime = 0f;
void setup()
{
  size(screenWidth,screenHeight,P3D);
  initLPD8();
  noCursor();
  s = new SubDTriSurf();
  mySubs = new ArrayList<SubDTriSurf>();
  recurSubDiv(0,s.subD());
}

void recurSubDiv(int level, ArrayList<SubDTriSurf> surf)
{
  for(SubDTriSurf ff : surf)
  {
    float[] centerPt = ff.getCenterPoint();
    float modVal = (1+sin(curTime*5+centerPt[0]))/2;
    if(level < 1)// || modVal >.5)
      mySubs.add(ff);
    else
    recurSubDiv(level-1,ff.subD());
  }
}

void draw()
{
  float maxDispl = 8;
  normalDisplacementFactor = mouseX*maxDispl/height;
  subdivRecurDepth = 1+(6*mouseX)/width;
//  overallScale = 3*value/128.f;
  float tm  = globalTimeScale* (frameCount*1000.f/30.f)/15600.f;//millis()/2000.f;
  curTime = tm; //global
  mySubs.clear();
  s.animateStartingShape(tm);
  recurSubDiv(subdivRecurDepth,s.subD());
//  recurSubDiv(6,s.subD());
  directionalLight(255,0,0,1,0,0);
  directionalLight(0,255,0,0,1,0);
  directionalLight(0,0,255,0,-1,0);
  background(255,155,155);
  float[] centerPt = s.getCenterPoint();
  translate(width/2-centerPt[0],height/2-centerPt[1],-300-centerPt[2]);
  
  scale(overallScale);
  
  pushMatrix();
//rotateY(tm);
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
  
//  pushMatrix();
//  /*  rotate(tm);
//  rotateX(tm);*/
//  
//  rotate(tm);
//  rotateX(tm+PI);
////  rotateY(PI+tm);
//  rotateZ(PI/2);
//  
//  beginShape(TRIANGLES);
//  for(SubDSurf sSs : mySubs)
//  {
//    sSs.passTriVerts();
//  }
//  endShape();
//  popMatrix();

  println("frameRate: " + frameRate + " subs: " + (int)(mouseY*13/height));
//  if(capturing)
//  {
//    saveFrame("frames/####.png");
//  }
}
