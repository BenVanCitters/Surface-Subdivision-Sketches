import processing.opengl.*;
import java.lang.Float;

ArrayList<SubDTriSurf> myOBJSubs;
ArrayList<SubDTriSurf> mySubs;
boolean capturing = true;
long framesCapturedCount = 0;
float curTime = 0f;

boolean isNan(float t)
{
  return Float.isNaN(t);
}

boolean isNan(float[] t)
{
  return isNan(t[0]) || isNan(t[1]) || isNan(t[2]);
}

void setup()
{
  size(1920,1080,OPENGL);  
  //initLPD8();
  parsePointsAndFaces("model.obj");
  mySubs = new ArrayList<SubDTriSurf>();
  myOBJSubs= new ArrayList<SubDTriSurf>();
  for(int i = 0; i < tris.length; i++)
  {
    SubDTriSurf s = new SubDTriSurf();
    try
    {
      s.verts[0]= pts[tris[i][0]];
      s.verts[1]= pts[tris[i][1]];
      s.verts[2]= pts[tris[i][2]];

      if(isNan(s.verts[0]) || isNan(s.verts[1]) || isNan(s.verts[2]))
      {
        println("adding a nan?!?!?");
      }
      
      myOBJSubs.add(s);
    }
    catch(Exception e)
    {
      String ps = "{" + tris[i][0] + ", " + tris[i][1] + ", " + tris[i][2] + "}" ;
      println(e + "problemTri: " + ps);
    } 
  }
}

float my = .25*(1+sin(curTime*5))/2;
void recurSubDiv(int level, ArrayList<SubDTriSurf> surf)
{
  for(SubDTriSurf ff : surf)
  {

    float[] center = ff.getCenterPoint();
    if(center[1] > -10)// || center[1] < -15 )
      continue;
    if(level < 1)
      mySubs.add(ff);
    else
      recurSubDiv(level-1,ff.subD());
  }
}

void draw()
{

   my = mouseY*0.3/height;
  float maxDispl = 8;
  normalDisplacementFactor = mouseX*maxDispl/height;

  
  float tm  = globalTimeScale* (frameCount*1000.f/30.f)/15600.f;//millis()/2000.f;
  curTime = tm; 

  mySubs.clear();
//  s.animateStartingShape(tm);

 
  directionalLight(255, 0, 0,0,1,.5);
  directionalLight(0,255,0,1,.1,.1);
  directionalLight(0,0,255,0,-1,0);
  //ambientLight(0, 0, 100);
  background(100,100,100);

  
  pushMatrix();
    translate(width/2,height/2,-50);
    
    scale(130);
    translate(-centerPt[0],-centerPt[1],-centerPt[2]);
    translate(0,1);
    rotateY(.2+curTime);
    //start the recursive subdividing
    recurSubDiv(2,myOBJSubs);

    
    float[] sz = getaabbSz();
    
    noStroke();
    //box(sz[0],sz[1],sz[2]);
    fill(255);
    int nanCount = 0;
    int infCount = 0;
    beginShape(TRIANGLES);
    for(SubDTriSurf sSs : mySubs)
    {
      sSs.passTriVerts();
      if(sSs.hasNaN())
        nanCount++;
      if(sSs.hasInf())
        infCount++;        
    }
    endShape();
  popMatrix();
  println("nanCount: " + nanCount);
  println("infCount: " + infCount);

  
  println("frameRate: " + frameRate + " subs: " + subdivRecurDepth + " triCount: " + mySubs.size());
  
  if(capturing)
  {
    framesCapturedCount++;
    saveFrame("framesmv/####.png");
    println("seconds recorded: " + framesCapturedCount/30.f);
  }
}

void printTri(int index)
{
  SubDTriSurf sSs = mySubs.get(index);
  sSs.print();
}