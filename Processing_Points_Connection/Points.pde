class Points
{
  float X, Y, Z;

  Points(float _x, float _y, float _z)
  {
    X = _x;
    Y = _y;
    Z = _z;
  }

  void put(int a, int b, int c, int d, float e)
  {
    stroke(a,b,c,d);
    strokeWeight(e);
    point(X, Y, Z);
  }

  void melt()
  {
    int start = millis();
    int freq = 2; // lower the faster
    int highTrans = 255;
    float trans = round(millis()/freq/highTrans%2) ;

    pushMatrix();
    //rotate(ang*PI,100,100,100);
    stroke(255, 255, 255, millis()/freq%highTrans);
    strokeWeight(2);

    if (trans == 1)
    {
      point(X, Y, Z);
    } else
    {
      point(X, Y, Z);
    }
    popMatrix();
  }
  
  void ptMove(Points a, Points b)
  {
    println("hello world");
  }
}