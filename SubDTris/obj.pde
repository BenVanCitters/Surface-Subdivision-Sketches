float[][] pts;
int[][] tris; /////perhaps make this a pshape??
float[] centerPt;
float[] aabb; //axis aligned bounding box

import java.util.Iterator;

void parsePointsAndFaces(String s)
{
  ArrayList<float[]> ptLst;
  ArrayList<int[]> triLst;
  String[] lines = loadStrings(s);

  int tri[];
  ptLst = new ArrayList<float[]>();
  triLst = new ArrayList<int[]>();

  println("lines.length: " + lines.length);

  //parse verticies from obj file
  for (int i = 0; i < lines.length; i++)
  {
//    println("i:" + i);
    String[] pieces = split(lines[i], ' ');
    if (pieces[0].equals("v"))
    {
      float pt[] = { float(pieces[1]), 
                     -1.0f*float(pieces[2]), 
                     float(pieces[3]) };
      ptLst.add(pt);      
      //println("pt: {" + float(pieces[2]) + ", " + float(pieces[3]) +", " + float(pieces[4]) + "}");
    }
    else if (pieces[0].equals("f"))
    {
      //println("tri {" + int(pieces[1]) + ", " + int(pieces[2]) +", " + int(pieces[3]) + "}"); 
      tri = new int[] {
        int(pieces[1]), int(pieces[2]), int(pieces[3])
      };
      triLst.add(tri);
    }
  }
  println("pieces parsed!");
  tris = new int[triLst.size()][3];
  pts = new float[ptLst.size()][3];
  int i = 0;
  for (Iterator<float[]> it = ptLst.iterator();it.hasNext();)
  {    
    pts[i] = it.next();
    i++;
  }
  
  println("points put!");
  //flatten to array
  i = 0;
  for (Iterator<int[]> it = triLst.iterator();it.hasNext();)
  {
    tris[i] = it.next();    
    i++;
  }
  println("array flattened!\nCalc'ing Cntr");
  centerPt = getCenterPoint();
  println("center: " + centerPt[0] + "," + centerPt[1] + "," + centerPt[2] );
  println("center calc'd!");
  
  println("calc'ing aabb!");
  aabb = getAABB();
  println("calc'd aabb!");
  
  println("aabb: " + aabb[0] + "," +aabb[1] + "," +aabb[2] + "," +aabb[3] + "," +aabb[4] + "," +aabb[5] );
}


//void parsePointsAndFaces(String objFileName)
//{
//  ArrayList<float[]> ptLst;
//  ArrayList<int[]> triLst;
//  String[] lines = loadStrings(objFileName);
//
//  int tri[];
//  ptLst = new ArrayList<float[]>();
//  triLst = new ArrayList<int[]>();
//
//  //println("lines.length: " + lines.length);
//
//  //parse verticies from obj file
//  for (int i = 0; i < lines.length; i++)
//  {
//    String[] pieces = split(lines[i], ' ');
//    if (pieces[0].equals("v"))
//    {
//      try{
////        float pt[] = new float[] {float(pieces[2]), -1.0f*float(pieces[3]), float(pieces[4])};
//        float pt[] = new float[] {float(pieces[1]), -1.0f*float(pieces[2]), float(pieces[3])};
//        ptLst.add(pt);      
//      }
//      catch(Exception e)
//      {
//        println(e);
////        println("pieces: " + pieces[0] + "," + pieces[1] + "," + pieces[2] + "," + pieces[3] );
////        println("lines["+i+"]" + lines[i]);
//      }
//println("pt: {" + float(pieces[1]) + ", " + float(pieces[2]) +", " + float(pieces[3]) + "}");
//    }
//    else if (pieces[0].equals("f"))
//    {
//      //println("tri {" + int(pieces[1]) + ", " + int(pieces[2]) +", " + int(pieces[3]) + "}"); 
//      tri = new int[] {
//        int(pieces[1]), int(pieces[2]), int(pieces[3])
//      };
//      triLst.add(tri);
//    }
//  }
//  tris = new int[triLst.size()][3];
//  pts = new float[ptLst.size()][3];
//  
//  println("ptLst.size(): " + ptLst.size() + " triLst.size(): " + triLst.size());
//  int i = 0;
//  for (Iterator<float[]> it = ptLst.iterator();it.hasNext();)
//  {    
//    pts[i] = it.next();
//    i++;
//  }
//  //flatten to array
//  i = 0;
//  for (Iterator<int[]> it = triLst.iterator();it.hasNext();)
//  {
//    tris[i] = it.next();    
//    i++;
//  }
//}

float[] getCenterPoint()
{
  double[] totalPt = {0,0,0};
  for(int i = 0; i < pts.length; i++)
  {
    totalPt[0] += pts[i][0];
    totalPt[1] += pts[i][1];
    totalPt[2] += pts[i][2];
  }
  float[] result = {(float)(totalPt[0]/pts.length),
                    (float)(totalPt[1]/pts.length),
                    (float)(totalPt[2]/pts.length)};
  return result;
}

//returns a float array of the form [minX,maxX,
//                                   minY,maxY,
//                                   minZ,maxZ]
float[] getAABB()
{
                   //x,x,y,y,z,z
  aabb = new float[]{999999999,-999999999,
                     999999999,-999999999,
                     999999999,-999999999};
  for(int i = 0; i < pts.length; i++)
  {
    aabb[0] = min(pts[i][0],aabb[0]);
    aabb[1] = max(pts[i][0],aabb[1]);
    aabb[2] = min(pts[i][1],aabb[2]);
    aabb[3] = max(pts[i][1],aabb[3]);
    aabb[4] = min(pts[i][2],aabb[4]);
    aabb[5] = max(pts[i][2],aabb[5]);    
  }
  return aabb;
}
