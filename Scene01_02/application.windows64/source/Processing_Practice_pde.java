import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import org.firmata.*; 
import cc.arduino.*; 
import peasy.test.*; 
import peasy.org.apache.commons.math.*; 
import peasy.*; 
import peasy.org.apache.commons.math.geometry.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Processing_Practice_pde extends PApplet {









int arrayX = 40;
int arrayY = 40;
int arrayZ = 40;

float ang = 0;

Points[][][] pts = new Points[arrayX][arrayX][arrayZ];

PeasyCam cam;

public void setup()
{
  size(3600, 2400, P3D);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(5000);
  background(0);
  delay(3000);
}

public void draw()
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
        pts[i][j][k] = new Points(i*20.0f, j*20.0f, k*20.0f);
        pts[i][j][k].put();
      }
    }
  }
  ang += 0.000001f;
}

class Points
{
  float X, Y, Z;

  Points(float _x, float _y, float _z)
  {
    X = _x;
    Y = _y;
    Z = _z;
  }

  public void put()
  {
    stroke(25, 145, 255, 180);
    strokeWeight(1);
    point(X, Y, Z);
  }

  public void melt()
  {
    int start = millis();
    int freq = 2; // lower the faster
    int highTrans = 255;
    float trans = round(millis()/freq/highTrans%2) ;

    pushMatrix();
    //rotate(ang*PI,100,100,100);
    stroke(255, 255, 255, millis()/freq%highTrans);
    strokeWeight(0.1f);

    if (trans == 1)
    {
      point(X, Y, Z);
    } else
    {
      point(X, Y, Z);
    }
    popMatrix();
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#000000", "--hide-stop", "Processing_Practice_pde" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
