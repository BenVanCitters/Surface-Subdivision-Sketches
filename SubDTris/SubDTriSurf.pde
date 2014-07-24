class SubDTriSurf
{
  public float[][] pts = new float[3][3];
  public SubDTriSurf()
  {
    float r = 700;
    float t = 0;
    pts[0][0] = r*cos(t);
    pts[0][1] = r*sin(t);
    pts[0][2] = 0;
     
    t += TWO_PI/3;
    pts[1][0] = r*cos(t);
    pts[1][1] = r*sin(t);
    pts[1][2] = 0;

    t += TWO_PI/3;
    pts[2][0] = r*cos(t);
    pts[2][1] = r*sin(t);
    pts[2][2] = 0;
  }
   
  public float[] getCenterPoint()
  {
    float[] result = new float[3];
    result[0] =pts[0][0]+pts[1][0]+pts[2][0]; 
    result[1] =pts[0][1]+pts[1][1]+pts[2][1];
    result[2] =pts[0][2]+pts[1][2]+pts[2][2];
    result[0]/=3;
    result[1]/=3;
    result[2]/=3;
    return result;
  }
   
  public void animateStartingShape(float  tm)
  {
    pts[0][0] = -1250*sin(1+tm);
    pts[0][1] = -1250*sin(4+tm/4);
    pts[0][2] = 1800*sin(9+tm*1.3);
     
    pts[1][0] = 950*sin(3+tm*1.3);
    pts[1][1] = -2150*sin(2.2+tm*.4);
    pts[1][2] = 1600*sin(5+tm*.9);
     
    pts[2][0] = -pts[0][0];
    pts[2][1] = -pts[0][1];
    pts[2][2] = pts[0][2];
  }
  public void draw()
  {
    beginShape(TRIANGLE_STRIP);    
    passTriStripVerts();    
    endShape();
  }
   
  public void passTriStripVerts()
  {
    vertex(pts[0][0],pts[0][1],pts[0][2]);
    vertex(pts[1][0],pts[1][1],pts[1][2]);
    vertex(pts[2][0],pts[2][1],pts[2][2]); 
  }
   
  public void passTriVerts()
  {
    vertex(pts[0][0],pts[0][1],pts[0][2]);
    vertex(pts[1][0],pts[1][1],pts[1][2]);
    vertex(pts[2][0],pts[2][1],pts[2][2]); 
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
    return getNormal(new float[]{pts[2][0]-pts[0][0],
                                 pts[2][1]-pts[0][1],
                                 pts[2][2]-pts[0][2]},
                     new float[]{pts[1][0]-pts[0][0],
                                 pts[1][1]-pts[0][1],
                                 pts[1][2]-pts[0][2]});
  }
   
  public ArrayList<SubDTriSurf> subD()
  {
    float mx = normalDisplacementFactor;
    float my = .01+mouseY*5.f/height;
    ArrayList<SubDTriSurf> lst = new ArrayList<SubDTriSurf>();
    float cntr[] = getCenterPoint();
    mx *= .3*(1+sin(curTime/1000.f+cntr[0]/100))/2;
    
    float norm[] = getNormal();
//    float edgeLen = dist(pts[0][0],
//                         pts[0][1],
//                         pts[0][2],
//                        (pts[0][0]+pts[2][0])/2,
//                        (pts[0][1]+pts[2][1])/2,
//                        (pts[0][2]+pts[2][2])/2)*mx;
//    norm[0]*=edgeLen;norm[1]*=edgeLen;norm[2]*=edgeLen;

    float mulPcts[] = new float[]{(1+sin(5+curTime+cntr[0]/100))/2,
                                  (1+sin(3+curTime/1.1+cntr[1]/100))/2,
                                  (1+sin(curTime/7+cntr[2]/100))/2};
//
//    float v1[] = new float[]{(pts[1][0]-pts[0][0]),
//                             (pts[1][1]-pts[0][1]),
//                             (pts[1][2]-pts[0][2])};
//    float v2[] = new float[]{0,0,0,
//                            (pts[2][0]-pts[0][0]),
//                            (pts[2][1]-pts[0][1]),
//                            (pts[2][2]-pts[0][2])};
//    float v3[] = new float[]{(pts[3][0]-pts[0][0]),
//                             (pts[3][1]-pts[0][1]),
//                             (pts[3][2]-pts[0][2])};

//    float newCenterPt[] = new float[]{pts[0][0]+v1[0]*mulPcts[0]+v2[0]*mulPcts[1]+v3[0]*mulPcts[2]+norm[0],
//                                      pts[0][1]+v1[1]*mulPcts[0]+v2[1]*mulPcts[1]+v3[1]*mulPcts[2]+norm[1],
//                                      pts[0][2]+v1[2]*mulPcts[0]+v2[2]*mulPcts[1]+v3[2]*mulPcts[2]+norm[2]};
//
//    float newPts[][] = new float[][]{{(pts[0][0]+pts[1][0])/2,
//                                      (pts[0][1]+pts[1][1])/2,
//                                      (pts[0][2]+pts[1][2])/2},
//                                      newCenterPt,
//                                     {(pts[0][0]+pts[3][0])/2,
//                                      (pts[0][1]+pts[3][1])/2,
//                                      (pts[0][2]+pts[3][2])/2},
//                                     {(pts[1][0]+pts[2][0])/2,
//                                      (pts[1][1]+pts[2][1])/2,
//                                      (pts[1][2]+pts[2][2])/2},
//                                     {(pts[2][0]+pts[3][0])/2,
//                                      (pts[2][1]+pts[3][1])/2,
//                                      (pts[2][2]+pts[3][2])/2}};     
     
    SubDTriSurf s1 = new SubDTriSurf();
    s1.pts[0]= pts[0];
    s1.pts[1]=pts[1];
    s1.pts[2]=cntr;
    lst.add(s1);
     
    SubDTriSurf s2 = new SubDTriSurf();
    s2.pts[0]=pts[1];
    s2.pts[1]=pts[2];
    s2.pts[2]=cntr;
    lst.add(s2);
     
    SubDTriSurf s3 = new SubDTriSurf();
    s3.pts[0]=pts[2];
    s3.pts[1]=pts[0];
    s3.pts[2]= cntr;  
    lst.add(s3);
     
    return lst;
  }
}
