import org.firmata.*;
import cc.arduino.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import de.bezier.data.*;

XlsReader reader;

int arrayX = 25;
int arrayY = 25;
int arrayZ = 25;

float ang = 0.0f;

Points[] pts = new Points[arrayX * arrayY * arrayZ];
Points[] dest = new Points[arrayX * arrayY * arrayZ];

// ArrayList<Points> pts = new ArrayList<Points>();
// ArrayList<Points> dest = new ArrayList<Points>();

float []jitterX = new float[arrayX*arrayY*arrayZ];
float []jitterY = new float[arrayX*arrayY*arrayZ];
float []jitterZ = new float[arrayX*arrayY*arrayZ];

float thredhold = 10.00f;
int loopCount = 0;

int loop = 0;

PeasyCam cam;



void setup()
{
  size(1800, 1100, P3D);
  frameRate(100);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(1000);
  background(0);
  
  for (int i = 0; i < arrayX * arrayY * arrayZ; i++)
  {
    jitterX[i] = random(-45.0, 45.0);
    jitterY[i] = random(-45.0, 45.0);
    jitterZ[i] = random(-45.0, 45.0);
  }

  for (int i = 0; i< arrayX; i++)
  {
    for (int j = 0; j < arrayY; j++)
    {

      for (int k = 0; k < arrayZ; k++)
      {
        pts[i*arrayX*arrayX + j*arrayY + k] = new Points(i*10.0+jitterX[i*arrayX*arrayX + j*arrayY + k], j*10.0+jitterY[i*arrayX*arrayX + j*arrayY + k], k*10.0+jitterZ[i*arrayX*arrayX + j*arrayY + k]);        
         
        pts[i*arrayX*arrayX + j*arrayY + k].put();
      }
    }
  }
  
  // reader = new XlsReader( this, "points.xls" );    // assumes file to be in the data folder

  //  println( reader.getString( 1, 0 ) );    // first value is row, second is cell. both are zero-based
  //  println( reader.getInt( 2, 0 ) );
  //  println( reader.getFloat( 3, 0 ) );
}

void draw()
{
  loop++;
  
  if (loop % 5 == 0)
  {
    for (int i = 0; i < arrayX * arrayY * arrayZ; i++)
      {
        jitterX[i] = random(-45.0, 25.0);
        jitterY[i] = random(-35.0, 15.0);
        jitterZ[i] = random(-25.0, 55.0);
      }
  }
  
  background(0);

  for (int i = 0; i< arrayX; i++)
  {
    for (int j = 0; j < arrayY; j++)
    {

      for (int k = 0; k < arrayZ; k++)
      {
        dest[i*arrayX*arrayX + j*arrayY + k] = new Points(i*20.0+jitterX[i*arrayX*arrayX + j*arrayY + k], j*20.0+jitterY[i*arrayX*arrayX + j*arrayY + k], k*20.0+jitterZ[i*arrayX*arrayX + j*arrayY + k]);        

        if (pts[i*arrayX*arrayX + j*arrayY + k].X != dest[i*arrayX*arrayX + j*arrayY + k].X 
              && pts[i*arrayX*arrayX + j*arrayY + k].Y != dest[i*arrayX*arrayX + j*arrayY + k].Y
              && pts[i*arrayX*arrayX + j*arrayY + k].Z != dest[i*arrayX*arrayX + j*arrayY + k].Z)
        {
          pts[i*arrayX*arrayX + j*arrayY + k].move(pts[i*arrayX*arrayX + j*arrayY + k], dest[i*arrayX*arrayX + j*arrayY + k]);
        }
        
        float dist = dist(pts[i*arrayX*arrayX + j*arrayY + k].X, pts[i*arrayX*arrayX + j*arrayY + k].Y, pts[i*arrayX*arrayX + j*arrayY + k].Z, 100, 100, 100);
        
        if (dist <= 100 )
        {
          pts[i*arrayX*arrayX + j*arrayY + k].put();
        }
      }
    }
  }


  /*
  for (int i = 0; i < arrayX*arrayY*arrayZ; i++)
  {
    for (int j = 0; j < arrayX*arrayY*arrayZ; j++)
    {

      if (dist(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z) < thredhold)
      {
        strokeWeight(0.4);
        stroke(0, 185, 255, 150);
        line(pts[i].X, pts[i].Y, pts[i].Z, pts[j].X, pts[j].Y, pts[j].Z);
      }
    }
  }
  */
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
  }
  // RANDOMNESS REFRESH
  if (keyCode == ENTER) 
  {
    for (int i = 0; i < arrayX * arrayY * arrayZ; i++)
    {
      jitterX[i] = random(-45.0, 25.0);
      jitterY[i] = random(-35.0, 15.0);
      jitterZ[i] = random(-25.0, 55.0);
    }
  }
}