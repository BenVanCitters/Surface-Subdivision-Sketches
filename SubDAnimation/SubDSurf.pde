class SubDSurf
{
  public float[][] pts = new float[4][3];
   public SubDSurf()
   {
     pts[0][0] = -1250;
     pts[0][1] = -1250;
     pts[0][2] = 0;
     
     pts[1][0] = 250;
     pts[1][1] = -250;
     pts[1][2] = 0;
     
     pts[2][0] = 1250;
     pts[2][1] = 1250;
     pts[2][2] = 0;
     
     pts[3][0] = -250;
     pts[3][1] = 250;
     pts[3][2] = 0;
   }
   
   public float[] getCenterPoint()
   {
     float[] result = new float[3];
     result[0] =pts[0][0]+pts[1][0]+pts[2][0]+pts[3][0]; 
     result[1] =pts[0][1]+pts[1][1]+pts[2][1]+pts[3][1];
     result[2] =pts[0][2]+pts[1][2]+pts[2][2]+pts[3][2];
     result[0]/=4;
     result[1]/=4;
     result[2]/=4;
     return result;
   }
   
   public void animateStartingShape(float  tm)
   {
     pts[0][0] = -1250*sin(tm);
     pts[0][1] = -1250*sin(4+tm/4);
     pts[0][2] = 800*sin(tm*1.3);
     
     pts[1][0] = 250*sin(tm*1.3);
     pts[1][1] = -850*sin(tm*.4);
     pts[1][2] = 1600*sin(tm*.9);
     
     pts[2][0] = -pts[0][0];
     pts[2][1] = -pts[0][1];
     pts[2][2] = pts[0][2];
     
     pts[3][0] = -pts[1][0];
     pts[3][1] = -pts[1][1];
     pts[3][2] = pts[1][2];
   }
   public void draw()
   {
     //    fill(random(255),random(255),random(255));
     beginShape(TRIANGLE_STRIP);
//     for(float[] p: pts)
     {
//       vertex(pts[0][0],pts[0][1],pts[0][2]);
//       vertex(pts[3][0],pts[3][1],pts[3][2]);
//       vertex(pts[1][0],pts[1][1],pts[1][2]);
//       vertex(pts[2][0],pts[2][1],pts[2][2]);
       passTriStripVerts();
     }
     endShape();
   }
   
   public void passTriStripVerts()
   {
     vertex(pts[0][0],pts[0][1],pts[0][2]);
     vertex(pts[3][0],pts[3][1],pts[3][2]);
     vertex(pts[1][0],pts[1][1],pts[1][2]);
     vertex(pts[2][0],pts[2][1],pts[2][2]); 
   }
   
   public void passTriVerts()
   {
     vertex(pts[0][0],pts[0][1],pts[0][2]);
     vertex(pts[3][0],pts[3][1],pts[3][2]);
     vertex(pts[1][0],pts[1][1],pts[1][2]);
     vertex(pts[1][0],pts[1][1],pts[1][2]);
     vertex(pts[3][0],pts[3][1],pts[3][2]);
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
   
   private float[]getNormal()
   {
     return getNormal(new float[]{pts[2][0]-pts[0][0],
                            pts[2][1]-pts[0][1],
                            pts[2][2]-pts[0][2]},
                            new float[]{pts[1][0]-pts[0][0],
                            pts[1][1]-pts[0][1],
                            pts[1][2]-pts[0][2]});
   }
   
   private float[] getAvgNormal()
   {
     float norm[] = getNormal(new float[]{pts[2][0]-pts[0][0],
                                          pts[2][1]-pts[0][1],
                                          pts[2][2]-pts[0][2]},
                              new float[]{pts[1][0]-pts[0][0],
                                          pts[1][1]-pts[0][1],
                                          pts[1][2]-pts[0][2]});
     float norm2[] = getNormal(new float[]{pts[0][0]-pts[1][0],
                                           pts[0][1]-pts[1][1],
                                           pts[0][2]-pts[1][2]},
                               new float[]{pts[3][0]-pts[1][0],
                                           pts[3][1]-pts[1][1],
                                           pts[3][2]-pts[1][2]});
     norm[0] = (norm[0] + norm2[0])/2;
     norm[1] = (norm[1] + norm2[1])/2;
     norm[2] = (norm[2] + norm2[2])/2;
     return norm;
   }
   
   public ArrayList<SubDSurf> subD()
   {
    float mx = .01+mouseX*25.f/width;
    float my = .01+mouseY*5.f/height;
     ArrayList<SubDSurf> lst = new ArrayList<SubDSurf>();
     float cntr[] = getCenterPoint();
     mx += .9+.001+.3*(1+sin(millis()/1000.f+cntr[0]/100))/2;
     float edgeLen = dist(pts[0][0],pts[0][1],pts[0][2],
                          (pts[0][0]+pts[2][0])/2,
                          (pts[0][1]+pts[2][1])/2,
                          (pts[0][2]+pts[2][2])/2)/mx;
    float norm[] = getAvgNormal();
    norm[0]*=edgeLen;norm[1]*=edgeLen;norm[2]*=edgeLen;

    float mulPcts[] = new float[]{(1+sin(5+curTime+cntr[0]/100))/2,
                                  (1+sin(3+curTime/1.1+cntr[1]/100))/2,
                                  (1+sin(curTime/7+cntr[2]/100))/2};
//    float newCenterPt[] = new float[]{(pts[1][0]-pts[0][0])*mulPcts[0]+(pts[2][0]-pts[0][0])*mulPcts[1]+(pts[3][0]-pts[0][0])*mulPcts[2]+norm[0],
//                                      (pts[1][1]-pts[0][1])*mulPcts[0]+(pts[2][1]-pts[0][1])*mulPcts[1]+(pts[3][1]-pts[0][1])*mulPcts[2]+norm[1],
//                                      (pts[1][2]-pts[0][2])*mulPcts[0]+(pts[2][2]-pts[0][2])*mulPcts[1]+(pts[3][0]-pts[0][2])*mulPcts[2]+norm[2]};

float v1[] = new float[]{(pts[1][0]-pts[0][0]),
                         (pts[1][1]-pts[0][1]),
                         (pts[1][2]-pts[0][2])};
float v2[] = new float[]{0,0,0,(pts[2][0]-pts[0][0]),
                         (pts[2][1]-pts[0][1]),
                         (pts[2][2]-pts[0][2])};
float v3[] = new float[]{(pts[3][0]-pts[0][0]),
                         (pts[3][1]-pts[0][1]),
                         (pts[3][2]-pts[0][2])};

    float newCenterPt[] = new float[]{pts[0][0]+v1[0]*mulPcts[0]+v2[0]*mulPcts[1]+v3[0]*mulPcts[2]+norm[0],
                                      pts[0][1]+v1[1]*mulPcts[0]+v2[1]*mulPcts[1]+v3[1]*mulPcts[2]+norm[1],
                                      pts[0][2]+v1[2]*mulPcts[0]+v2[2]*mulPcts[1]+v3[2]*mulPcts[2]+norm[2]};

    float newPts[][] = new float[][]{{(pts[0][0]+pts[1][0])/2,
                                      (pts[0][1]+pts[1][1])/2,
                                      (pts[0][2]+pts[1][2])/2},
                                      newCenterPt,
//                                     {(pts[0][0]+pts[1][0]+pts[2][0]+pts[3][0])/4+norm[0],
//                                      (pts[0][1]+pts[1][1]+pts[2][1]+pts[3][1])/4+norm[1],
//                                      (pts[0][2]+pts[1][2]+pts[2][2]+pts[3][2])/4+norm[2]},
                                     {(pts[0][0]+pts[3][0])/2,
                                      (pts[0][1]+pts[3][1])/2,
                                      (pts[0][2]+pts[3][2])/2},
                                     {(pts[1][0]+pts[2][0])/2,
                                      (pts[1][1]+pts[2][1])/2,
                                      (pts[1][2]+pts[2][2])/2},
                                     {(pts[2][0]+pts[3][0])/2,
                                      (pts[2][1]+pts[3][1])/2,
                                      (pts[2][2]+pts[3][2])/2}};     
     
     SubDSurf s1 = new SubDSurf();
     s1.pts[0]= pts[0];
     s1.pts[1]=newPts[0];
     s1.pts[2]=newPts[1];
     s1.pts[3]=newPts[2];
     lst.add(s1);
     
     SubDSurf s2 = new SubDSurf();
     s2.pts[0]=newPts[0];
     s2.pts[1]= pts[1];
     s2.pts[2]=newPts[3];
     s2.pts[3]=newPts[1];
     lst.add(s2);
     
     SubDSurf s3 = new SubDSurf();
     s3.pts[0]=newPts[1];
     s3.pts[1]=newPts[3];
     s3.pts[2]= pts[2];
     s3.pts[3]=newPts[4];  
     lst.add(s3);
     
     SubDSurf s4 = new SubDSurf();
     s4.pts[0]=newPts[2];
     s4.pts[1]=newPts[1];
     s4.pts[2]=newPts[4];
     s4.pts[3]= pts[3];     
     lst.add(s4);
     return lst;
   }
}
