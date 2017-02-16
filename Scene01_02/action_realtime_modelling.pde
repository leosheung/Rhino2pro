void connectGH_start(UDP a)
{
  // create a new datagram connection on port 6000
  // and wait for incomming message
  a = new UDP( this, 10000);
  //udp.log( true );     // <-- printout the connection activity
  a.listen( true );
}

void connectGH_draw(float[] nums, Points[] pts, Points[] dest, Points center)
{
  background(0);
  for (int i = 0; i <  nums.length/3; i++)
  {
    dest[i] = new Points(nums[i], nums[i + (nums.length/3)], nums[i + (nums.length)*2/3]);
    pts[i].move(pts[i], dest[i], 3);

    float dist = dist(pts[i].X, pts[i].Y, pts[i].Z, dest[i].X, dest[i].Y, dest[i].Z);
    float scale = dist / 200;

    pts[i].put(rgb[1], rgb[2], rgb[3], 125, scale);
  }

  for (int i = nums.length/3; i < nums.length; i++)
  {
    float dist_explosion = dist(pts[i].X, pts[i].Y, pts[i].Z, center.X, center.Y, center.Z);
    if (dist_explosion < 5000)
    {
      Points cast = new Points(pts[i].X + (pts[i].X - center.X) * 50, 
        pts[i].Y + (pts[i].Y - center.Y) * 15, 
        pts[i].Z + (pts[i].Z - center.Z) * 3);

      pts[i].move(pts[i], cast, 3);
      pts[i].put(rgb[1], rgb[2], rgb[3], 185/(dist_explosion/1000), 0.9 / (dist_explosion/1000));
    } 
    
    else
    {
      // do nothing;
    }
  }




  //  for (int i = 0; i < nums.length/3; i++)
  //  {
  //    pushMatrix();
  //    stroke(255, 255, 255, 50);
  //    strokeWeight(5);
  //    point(nums[i], nums[i + (nums.length/3)], nums[i + (nums.length)*2/3]);
  //    popMatrix();
  //  }

  for (int i = 0; i < nums.length/3; i++)
  {
    for (int j = 0; j < nums.length/3; j++)
    {
      float dist_line = dist(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z);
      float dist_pursuit_i = dist(pts[i].X, pts[i].Y, pts[i].Z, dest[i].X, dest[i].Y, dest[i].Z);
      float dist_pursuit_j = dist(pts[j].X, pts[j].Y, pts[j].Z, dest[j].X, dest[j].Y, dest[j].Z);

      if ( dist_line < thredhold && dist_pursuit_i <= 2000 && dist_pursuit_j <= 2000)
      //if ( dist_pursuit_i <= 200 && dist_pursuit_j <= 200)
      {
        pushMatrix();
        stroke(rgb[1], rgb[2], rgb[3]);
        strokeWeight(0.2);
        line(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z);
        popMatrix();
      }
    }
  }
}