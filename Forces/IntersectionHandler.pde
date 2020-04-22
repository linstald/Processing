class IntersectionHandler {
  //states to indicate which intersection to calculate
  final static int LINETOLINE = 0;
  final static int LINETORAY = 1;
  final static int LINETOSEGMENT = 2;
  final static int RAYTORAY = 3;
  final static int RAYTOSEGMENT = 4;
  final static int SEGMENTTOSEGMENT = 5;

  /**
   *  calculates the intersection point of line A1B1 and A2B2
   *  returns null if the lines do not intersect, respective to the given type
   **/
  PVector intersect(PVector A1, PVector B1, PVector A2, PVector B2, int type) {

    //renaming as in wikipedia
    float x1 = A1.x;
    float y1 = A1.y;
    float x2 = B1.x;
    float y2 = B1.y;
    float x3 = A2.x;
    float y3 = A2.y;
    float x4 = B2.x;
    float y4 = B2.y;

    //uses the formula as in wikipedia:
    //https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
    float denum = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
    if (denum==0) { //lines are parallel
      return null;
    }
    float tNum = (x1-x3)*(y3-y4)-(y1-y3)*(x3-x4);
    float uNum = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3));

    float t = tNum/denum;
    float u = uNum/denum;
    PVector intersection = new PVector(x1+t*(x2-x1), y1+t*(y2-y1));
    //return according to type of intersection
    switch(type) {
    case LINETOLINE: //return intersection, they must intersect except if they are parallel
      return intersection;

    case LINETORAY:
      if (u>=0) { //return only if u is positive
        return intersection;
      } else {
        return null;
      }

    case LINETOSEGMENT:
      if (utils.isBetween(u, 0, 1)) { //return only if u is between 0 and 1
        return intersection;
      } else {
        return null;
      }

    case RAYTORAY:
      if (t>=0 && u>=0) { //return only if t and u are positive
        return intersection;
      } else {
        return null;
      }

    case RAYTOSEGMENT:
      if (t>=0 && utils.isBetween(u, 0, 1)) { //return only if t is positive and u is between 0 and 1
        return intersection;
      } else {
        return null;
      }

    case SEGMENTTOSEGMENT:
      if (utils.isBetween(t, 0, 1) && utils.isBetween(u, 0, 1)) { //return only if t and u are between 0 and 1
        return intersection;
      } else {
        return null;
      }

    default: //default return null
      return null;
    }
  }
  /**
   *  calculates the Intersectionpoint of a Ball and a GroundSegment
   **/
  PVector intersect(Ball b, GroundSegment gs) {
    PVector nPoint = b.getnPoint(gs);
    GroundSegment nS = gs.getExtendedGroundSegment(b);
    return intersect(nPoint, PVector.add(nPoint, b.vel), nS.from, nS.to, SEGMENTTOSEGMENT);
  }
}
