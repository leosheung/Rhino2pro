import org.firmata.*;
import cc.arduino.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

int arrayX = 40;
int arrayY = 40;
int arrayZ = 40;

float ang = 0;

Points[][][] pts = new Points[arrayX][arrayX][arrayZ];

PeasyCam cam;

void setup()
{
  size(3600, 2400, P3D);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(5000);
  background(0);
  delay(3000);
}

void draw()
{

  background(0);

  for (int i = 0; i< arrayX; i++)
  {
    for (int j = 0; j < arrayY; j++)
    {
      for (int k = 0; k < arrayZ; k++)
      {
        //        stroke(255);
        //        strokeWeight(10);
        //        rotate(ang * PI,0,0,0);
        rotate(ang*PI, mouseY/180, mouseX/100, mouseX/50);
        pts[i][j][k] = new Points(i*20.0, j*20.0, k*20.0);
        pts[i][j][k].put();
      }
    }
  }
  ang += 0.000001;
}

