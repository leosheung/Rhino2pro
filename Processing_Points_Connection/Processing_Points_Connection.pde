import org.firmata.*;
import cc.arduino.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import de.bezier.data.*;

XlsReader reader;

float ang = 0.0f;
int ptCount = 0;

boolean shot = false;

// thredhold of point connection
float thredhold = 0.0f;
int loopCount = 0;
int now = 0;

PeasyCam cam;

// USE HALF EDGE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

void setup()
{
  // OPENGL
  size(2500, 1600, P3D);
  cam = new PeasyCam(this, 185);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(1000);
  background(0);

  reader = new XlsReader( this, "points2.xls" );    // assumes file to be in the data folder
  //reader = new XlsReader( this, "points.xls" ); 
  ptCount = reader.getInt(0, 0);

  println(ptCount + 100);

  //  println( reader.getString( 1, 0 ) );    // first value is row, second is cell. both are zero-based
  //  println( reader.getInt( 2, 0 ) );
  //  println( reader.getFloat( 3, 0 ) );
}



void draw()
{
  // initialize the array of points;
  Points[] pts = new Points[ptCount];
   
  background(0);

  for (int i = 0; i< ptCount; i++)
  {
    pts[i] = new Points(reader.getFloat(i+1, 0), reader.getFloat(i+ptCount+1, 0), reader.getFloat(i+ptCount+ptCount+1, 0));        
    pts[i].put(255,255,255,180,1);
  }
  

  now+=4;
  
  for (int i = 0; i < ptCount; i++)
  {
    for (int j = 0; j < ptCount; j++)
    {

      if (dist(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z) < thredhold)
      {
        //int start = millis();
        int freq = 200; // lower the faster
        int highTrans = 120;
        int trans = round(now%highTrans);
        //int trans = 150;
        
        pushMatrix();
        //rotate(ang*PI,100,100,100);
        if((now/highTrans)%2 == 0)
        {
          stroke(255, 255, 255, trans);
        }
        else
        {
          stroke(255, 255, 255, highTrans - trans);
        }
        strokeWeight(0.4);
        //stroke(45, 100, 255, 180);
        line(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z);
        popMatrix();
      }
    }
  }
  
  if (shot == true)
  {
    saveFrame("MuseTunnel-###.png");
    println("Image saved");
  }
}

void keyPressed() 
{
  // thredhold control
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      thredhold+=0.3;
    } else if (keyCode == DOWN) 
    {
      thredhold-=0.3;
    }
    
    if (keyCode == ENTER)
    {
      shot = true;
    }
    else
    {
      shot = false;
    }
  }
}