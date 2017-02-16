class Points
{
  float X, Y, Z;

  Points(float _x, float _y, float _z)
  {
    X = _x;
    Y = _y;
    Z = _z;
  }

  void put(float strokeR, float strokeG, float strokeB, float Alpha, float strokeWeight)
  {
    stroke(strokeR, strokeG, strokeB, Alpha);
    strokeWeight(strokeWeight);
    point(X, Y, Z);
  }  

  void put()
  {
    stroke(255, 255, 255, 255);
    strokeWeight(3);
    point(X, Y, Z);
  }

  void melt()
  {
    // int start = millis();
    int freq = 20; // lower the faster
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

  void move(Points start, Points dest, int mode)
  {
    float current_distance = dist(start.X, start.Y, start.Z, dest.X, dest.Y, dest.Z);

    if (current_distance != 0)
    {

      if (current_distance > 10)
      {
        switch(mode)
        {
        case 1:
          start.X = start.X + ((current_distance / 300) * (dest.X - start.X));
          start.Y = start.Y + ((current_distance / 300) * (dest.Y - start.Y));
          start.Z = start.Z + ((current_distance / 300) * (dest.Z - start.Z));       
          break;
        case 2:
          start.X = start.X + (dest.X - start.X);
          start.Y = start.Y + (dest.Y - start.Y);
          start.Z = start.Z + (dest.Z - start.Z);
          break;
        case 3:
          start.X = start.X + 0.01* (dest.X - start.X);
          start.Y = start.Y + 0.01 * (dest.Y - start.Y);
          start.Z = start.Z + 0.01 * (dest.Z - start.Z);
          break;
        }
      }
      else if (current_distance <= 1 && current_distance != 0)
      {
        start.X = dest.X;
        start.Y = dest.Y;
        start.Z = dest.Z;
      }
    }
  }
}