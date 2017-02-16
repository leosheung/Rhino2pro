void sphere(Points[] pts)
{
  if (millis() % 5 == 0)
  {
    for (int i = 0; i < arrayX * arrayY * arrayZ; i++)
    {
      jitterX[i] = random(-20.0, 20.0);
      jitterY[i] = random(-20.0, 20.0);
      jitterZ[i] = random(-20.0, 20.0);
    }
  }

  background(0);

  float grid = 7.0;

  for (int i = 0; i< arrayX; i++)
  {
    for (int j = 0; j < arrayY; j++)
    {
      for (int k = 0; k < arrayZ; k++)
      {
        // --------------------------------------------------------------------------------------------------------------------------------
        int index = i*arrayX*arrayX + j*arrayY + k;
        float dist = dist(pts[index].X, pts[index].Y, pts[index].Z, center.X, center.Y, center.Z);
        if (dist > upperLimit)
        {
          jitterX[i] = random(-20.0, 20.0);
          jitterY[i] = random(-20.0, 20.0);
          jitterZ[i] = random(-20.0, 20.0);
        } else if (dist < downLimit)
        {
          jitterX[i] = random(-100.0, 100.0);
          jitterY[i] = random(-100.0, 100.0);
          jitterZ[i] = random(-100.0, 100.0);
        }

        dest[index] = new Points(
        pts[index].X+jitterX[index], 
        pts[index].Y+jitterY[index], 
        pts[index].Z+jitterZ[index]);        

        if (pts[index].X != dest[index].X || pts[index].Y != dest[index].Y || pts[index].Z != dest[index].Z)
        {
          pts[index].move(pts[index], dest[index], 1);
        }



        // if too close, eject quickly
        if (dist < 75)
        {
          Points cast;
          int rnd = round(random(0, 2));
          switch(rnd)
          {
          case 0:
            cast = new Points(center.X, 
            pts[index].Y + (pts[index].Y - center.Y) * 100, 
            center.Z);
            pts[index].move(pts[index], cast, 2);
            break;

          case 1:
            cast = new Points(center.X, 
            center.Y, 
            pts[index].Z + (pts[index].Z - center.Z) * 100);
            pts[index].move(pts[index], cast, 2);
            break;

          case 2:
            cast = new Points(pts[index].X + (pts[index].X - center.X) * 100, 
            center.Y, 
            center.Z);
            pts[index].move(pts[index], cast, 2);
            break;
          }
        }

        // if too far, come back slowly
        else if (dist > upperLimit)
        {
          Points jitterCenter = new Points(center.X + abs(jitterY[index]), center.Y + abs(jitterZ[index]), center.Z + abs(jitterX[index]));
          pts[index].move(pts[index], jitterCenter, 3);
        } 

        attr = new Points(mouseX - center.X, mouseX - center.Y, mouseX - center.Z);
        float attrDist = dist(pts[index].X, pts[index].Y, pts[index].Z, attr.X, attr.Y, attr.Z);
        
        
        if (attrDist <= 75)
        {

          attr.put();
          Points cast;
          cast = new Points(pts[index].X + (pts[index].X - attr.X)/30, 
          pts[index].Y + (pts[index].Y - attr.Y)/30, 
          pts[index].Z + (pts[index].Z - attr.Z)/30);
          pts[index].move(pts[index], cast, 1);
        }

        float dist1 = dist(mouseX - center.X, mouseX - center.Y, mouseY - center.Z, 
        pts[index].X, 
        pts[index].Y, 
        pts[index].Z) / 60 - 1.2;

        if (dist1 >= 1)
          dist1 = 1;
        // Point clouds Visualization

        float scale = dist / 1000;
        // default is 25, 170, 205, 125
        if (dist > 105)
        { 
          pts[index].put(dist1 * rgb[1], dist1 * rgb[2], dist1 * rgb[3], dist1 * 125, dist1 * 0.9 / scale);
        } 
        
        else if (dist <= 100 && dist > 80)
        {
          pts[index].put(dist1 * rgb[1], dist1 * rgb[2], dist1 * rgb[3], dist1 * rgb[0], dist1 * 0.2 / scale);
        } 
        
        else
        {
          pts[index].put(dist1 * rgb[1], dist1 * rgb[2], dist1 * rgb[3], dist1 * rgb[0], dist1 * random(0.5, 1) * 0.3);
        }

        // --------------------------------------------------------------------------------------------------------------------------------
      }
    }
  }
}


void ground(Points[] pts)
{
  for (int i = 0; i < pts.length; i++)
  {
    if (pts[i].Z != 0)
    {
      pts[i].move(pts[i], new Points(pts[i].X, 0, pts[i].Z), 3);
    }
    pts[i].put();
  }
}
