SubDSurf s;
ArrayList<SubDSurf> mySubs;
boolean capturing = false;
float curTime = 0f;
void setup()
{
//  size(500,500,P3D);
  size(displayWidth,displayHeight,P3D);
  s = new SubDSurf();
  mySubs = new ArrayList<SubDSurf>();
  recurSubDiv(0,s.subD());
}

void recurSubDiv(int level, ArrayList<SubDSurf> surf)
{
  for(SubDSurf ff : surf)
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
  float tm  =  (frameCount*1000.f/30.f)/3600.f;//millis()/2000.f;
  curTime = tm; //global
  mySubs.clear();
//  s.animateStartingShape(tm);
  recurSubDiv((int)(mouseY*13/height),s.subD());
//  recurSubDiv(6,s.subD());
  directionalLight(255,0,0,1,0,0);
  directionalLight(0,255,0,0,1,0);
  directionalLight(0,0,255,0,-1,0);
  background(255,155,155);
  translate(width/2,height/2,-300);
//  scale(.75);
  
  pushMatrix();
//rotateY(tm);
//  rotate(tm);
//  rotateX(tm);

  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  for(SubDSurf sSs : mySubs)
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

//  for(SubDSurf sSs : mySubs)
//  {
//    sSs.draw();
//  }
  println("frameRate: " + frameRate);
  if(capturing)
  {
    saveFrame("frames/####.png");
  }
}

void keyPressed()
{
  if(key == 'p')
  {
    capturing = !capturing;
    
  }
}
