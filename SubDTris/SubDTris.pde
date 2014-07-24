import processing.opengl.*;

//SubDTriSurf s;
ArrayList<SubDTriSurf> myOBJSubs;
ArrayList<SubDTriSurf> mySubs;
boolean capturing = false;
long framesCapturedCount = 0;
float curTime = 0f;

float[] atrractorPos = new float[]{0,0,0};
void setup()
{
//  size(screenWidth,screenHeight,OPENGL);
  size(1280,720,OPENGL);  
  initLPD8();
//  noCursor();
parsePointsAndFaces("column.obj");
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
  subdivRecurDepth = (6*mouseX)/width;
  
  float tm  = globalTimeScale* (frameCount*1000.f/30.f)/15600.f;//millis()/2000.f;
  curTime = tm; 
  atrractorPos[0] = 2*sin(curTime);
  atrractorPos[1] = 3*sin(2+curTime)*cos(1+curTime/1.1);
  atrractorPos[2] = 1*sin(curTime/2)*sin(5+curTime*1.1);
  
  mySubs.clear();
//  s.animateStartingShape(tm);
//ArrayList<SubDTriSurf>
  for(SubDTriSurf s: myOBJSubs)
  {
    recurSubDiv(subdivRecurDepth,s.subD());
  } 
  directionalLight(255,0,0,0,-1,.5);
  directionalLight(0,255,0,1,.1,.1);
//  directionalLight(0,0,255,0.5,1,0);
  background(255,200,0);
  float[] centerPt = new float[]{0,0,0};

//  translate(width/2-centerPt[0],600,100);

//  scale(15.5);
  
  pushMatrix();
  translate(width/2,height/2-centerPt[1],-500);
  scale(125.5);

  rotateY(tm*2.1);
  rotateX(tm*7.1);
  rotate(tm*4);
  
  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  for(SubDTriSurf sSs : mySubs)
  {
    sSs.passTriVerts();
  }
  endShape();
  popMatrix();

  pushMatrix();
  translate(width/6-centerPt[0],height/2-centerPt[1],0);
  scale(125.5);

  rotateY(-tm*9.1);
  rotateX(5+tm);
  rotate(tm*3);
  
  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  for(SubDTriSurf sSs : mySubs)
  {
    sSs.passTriVerts();
  }
  endShape();
  popMatrix();
  
  pushMatrix();
  translate(width*5/6-centerPt[0],height/2-centerPt[1],0);
  scale(125.5);

  rotateY(tm*2.5);
  rotateX(-5+6*tm);
  rotate(-tm*6.8);
  
  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  for(SubDTriSurf sSs : mySubs)
  {
    sSs.passTriVerts();
  }
  endShape();
  popMatrix();
  
  println("frameRate: " + frameRate + " subs: " + (int)(mouseY*13/height) + "triCount: " + mySubs.size());
  if(capturing)
  {
    framesCapturedCount++;
    saveFrame("frames/####.png");
    println("seconds recorded: " + framesCapturedCount/30.f);
  }
}
