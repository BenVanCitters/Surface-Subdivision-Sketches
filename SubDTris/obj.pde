float[][] pts;
int[][] tris; /////perhaps make this a pshape??


void parsePointsAndFaces(String s)
{
  ArrayList<float[]> ptLst;
  ArrayList<int[]> triLst;
  String[] lines = loadStrings(s);

  int tri[];
  ptLst = new ArrayList<float[]>();
  triLst = new ArrayList<int[]>();

  //println("lines.length: " + lines.length);

  //parse verticies from obj file
  for (int i = 0; i < lines.length; i++)
  {
//    println("i:" + i);
    String[] pieces = split(lines[i], ' ');
    if (pieces[0].equals("v"))
    {
//       println(pieces[3]);
      float pt[] = new float[] {
        float(pieces[1]), -1.0f*float(pieces[2]), float(pieces[3])
      };
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
  tris = new int[triLst.size()][3];
  pts = new float[ptLst.size()][3];
  int i = 0;
  for (Iterator<float[]> it = ptLst.iterator();it.hasNext();)
  {    
    pts[i] = it.next();
    i++;
  }
  //flatten to array
  i = 0;
  for (Iterator<int[]> it = triLst.iterator();it.hasNext();)
  {
    tris[i] = it.next();    
    i++;
  }
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

