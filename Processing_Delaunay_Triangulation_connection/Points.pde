class Points
{
  float X, Y, Z;

  Points(float _x, float _y, float _z)
  {
    X = _x;
    Y = _y;
    Z = _z;
  }

  void put()
  {
    stroke(25, 200, 255, 155);
    strokeWeight(5);
    point(X, Y, Z);
  }  

  void melt()
  {
    // int start = millis();
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
  
  void move(Points start, Points dest)
  {
    float current_distance = dist(start.X, start.Y, start.Z, dest.X, dest.Y, dest.Z);
    if (current_distance != 0)
    {
      
      if (current_distance > 10)
       {
         start.X = start.X + ((current_distance / 300) * (dest.X - start.X));
         start.Y = start.Y + ((current_distance / 300) * (dest.Y - start.Y));
         start.Z = start.Z + ((current_distance / 300) * (dest.Z - start.Z));
       }
       else if(current_distance <= 10 && current_distance != 0)
       {
        start.X = dest.X;
        start.Y = dest.Y;
        start.Z = dest.Z;
       }
    }
  }
  
  void cube_Move(Points[] a)
  {
    
  }
}