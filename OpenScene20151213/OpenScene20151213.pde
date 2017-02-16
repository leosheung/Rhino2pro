// import codeanticode.syphon.*;

// import org.firmata.*;
// import cc.arduino.*;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;


float span = 180;
float grid = 5;

int arrayX = round(span / grid);
int arrayY = round(span / grid);
int arrayZ = round(span / grid);

// default is 25, 170, 205, 125
int[] rgb = new int[4];



int phase = 0;

float ang = 0.0f;

Points[] pts = new Points[arrayX*arrayY*arrayZ];
Points[] dest = new Points[arrayX*arrayY*arrayZ];

// ArrayList<Points> pts = new ArrayList<Points>();
// ArrayList<Points> dest = new ArrayList<Points>();

float []jitterX = new float[arrayX*arrayY*arrayZ];
float []jitterY = new float[arrayX*arrayY*arrayZ];
float []jitterZ = new float[arrayX*arrayY*arrayZ];

float thredhold = 10.00f;
int loopCount = 0;

int loop = 0;

float upperLimit = 104;
float downLimit = 75;

Points attr;

PeasyCam cam;

Points center = new Points(0, 0, 0);

// SyphonServer server;

void setup()
{
  size(3000, 2000, P3D);
  // frameRate(100);
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
        int index = i*arrayX*arrayX + j*arrayY + k;

        pts[index] = new Points(i*grid+jitterX[index] - (span/2), j*grid+jitterY[index] - (span/2), k*grid+jitterZ[index] - (span/2));
      }
    }
  }

  rgb[0] = 225;
  rgb[1] = 225;
  rgb[2] = 150;
  rgb[3] = 65;

  // reader = new XlsReader( this, "points.xls" );    // assumes file to be in the data folder

  //  println( reader.getString( 1, 0 ) );    // first value is row, second is cell. both are zero-based
  //  println( reader.getInt( 2, 0 ) );
  //  println( reader.getFloat( 3, 0 ) );

  // Create syhpon server to send frames out.
  // server = new SyphonServer(this, "Processing Syphon");
}

void draw()
{
  background(0);

  frameRate(100);

  if (phase == 0)
  {
    sphere(pts);
  }
  // server.sendScreen();
  if (phase == 2)
  {
    ground(pts);
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
        if (dist > 110)
        { 
          pts[index].put(dist1 * rgb[1], dist1 * rgb[2], dist1 * rgb[3], dist1 * 125, dist1 * 0.9 / scale);
        } else if (dist <= 100 && dist > 80)
        {
          pts[index].put(dist1 * rgb[1], dist1 * rgb[2], dist1 * rgb[3], dist1 * rgb[0], dist1 * 0.2 / scale);
        } else
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

// keyboard testing
void keyPressed() 
{
  // thredhold control
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      upperLimit += 5;
    } else if (keyCode == DOWN) 
    {
      upperLimit -= 5;
    }
  }
}

