class SubDTriSurf
{
  public float[][] verts = new float[3][3];
  public SubDTriSurf()
  {
    float r = 700;
    float t = 0;
    verts[0][0] = r*cos(t);
    verts[0][1] = r*sin(t);
    verts[0][2] = 0;
     
    t += TWO_PI/3;
    verts[1][0] = r*cos(t);
    verts[1][1] = r*sin(t);
    verts[1][2] = 0;

    t += TWO_PI/3;
    verts[2][0] = r*cos(t);
    verts[2][1] = r*sin(t);
    verts[2][2] = 0;
  }
   
  public float[] getCenterPoint()
  {
    float[] result = new float[3];
    result[0] =verts[0][0]+verts[1][0]+verts[2][0]; 
    result[1] =verts[0][1]+verts[1][1]+verts[2][1];
    result[2] =verts[0][2]+verts[1][2]+verts[2][2];
    result[0]/=3;
    result[1]/=3;
    result[2]/=3;
    return result;
  }
   
  public void animateStartingShape(float  tm)
  {
    verts[0][0] = -1250*sin(1+tm);
    verts[0][1] = -1250*sin(4+tm/4);
    verts[0][2] = 1800*sin(9+tm*1.3);
     
    verts[1][0] = 950*sin(3+tm*1.3);
    verts[1][1] = -2150*sin(2.2+tm*.4);
    verts[1][2] = 1600*sin(5+tm*.9);
     
    verts[2][0] = -verts[0][0];
    verts[2][1] = -verts[0][1];
    verts[2][2] = verts[0][2];
  }
  public void draw()
  {
    beginShape(TRIANGLES);    
    passTriVerts();    
    endShape();
  }

   
   
  public void passTriVerts()
  {
    vertex(verts[0][0],verts[0][1],verts[0][2]);
    vertex(verts[1][0],verts[1][1],verts[1][2]);
    vertex(verts[2][0],verts[2][1],verts[2][2]); 
  }
   
  private float[]getNormal(float a[],float b[])
  {
    float cross[] = new float[]{a[1]*b[2]-a[2]*b[1],//
                                a[2]*b[0]-a[0]*b[2],
                                a[0]*b[1]-a[1]*b[0]};
    float crossLen = dist(0,0,0,
                          cross[0],cross[1],cross[2]);
    cross[0]/=crossLen;cross[1]/=crossLen;cross[2]/=crossLen;                         
    return cross; 
  }
   
  private float[] getNormal()
  {
    return getNormal(new float[]{verts[2][0]-verts[0][0],
                                 verts[2][1]-verts[0][1],
                                 verts[2][2]-verts[0][2]},
                     new float[]{verts[1][0]-verts[0][0],
                                 verts[1][1]-verts[0][1],
                                 verts[1][2]-verts[0][2]});
  }
   
  private float getArea()
  {
    float edgeLenA = dist( verts[0][0],verts[0][1],verts[0][2],
                          verts[1][0],
                          verts[1][1],
                          verts[1][2]);
    float edgeLenB = dist( verts[0][0],verts[0][1],verts[0][2],
                          verts[2][0],
                          verts[2][1],
                          verts[2][2]);
    float edgeLenC = dist( verts[2][0],verts[2][1],verts[2][2],
                          verts[1][0],
                          verts[1][1],
                          verts[1][2]);
    float halfPeri = (edgeLenA+edgeLenB+edgeLenC)/2;
    return sqrt(halfPeri*(halfPeri-edgeLenA)*(halfPeri-edgeLenB)*(halfPeri-edgeLenC));
    
  }
   
  public ArrayList<SubDTriSurf> subD()
  {
    float mx = normalDisplacementFactor;
    float my = +mouseY*.15f/height;
    ArrayList<SubDTriSurf> lst = new ArrayList<SubDTriSurf>();
    float cntr[] = getCenterPoint();
    float area = getArea()/1.f;
    
    float norm[] = getNormal();
    float normD = my/area;//.25;//-(10/(area*area*area) + area)*my;
    for(int i = 0; i < 3; i++)
      cntr[i] += normD*norm[i];
    
    SubDTriSurf s1 = new SubDTriSurf();
    s1.verts[0]= verts[0];
    s1.verts[1]=verts[1];
    s1.verts[2]=cntr;
    lst.add(s1);
     
    SubDTriSurf s2 = new SubDTriSurf();
    s2.verts[0]=verts[1];
    s2.verts[1]=verts[2];
    s2.verts[2]=cntr;
    lst.add(s2);
     
    SubDTriSurf s3 = new SubDTriSurf();
    s3.verts[0]=verts[2];
    s3.verts[1]=verts[0];
    s3.verts[2]= cntr;  
    lst.add(s3);
     
    return lst;
  }
}
