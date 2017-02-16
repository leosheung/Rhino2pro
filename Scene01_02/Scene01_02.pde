// import codeanticode.syphon.*;
// import org.firmata.*;
// import cc.arduino.*;

// import UDP library
import hypermedia.net.*;


import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

// initial the point 3D array
float span = 180;
float grid = 5;

int arrayX = round(span / grid);
int arrayY = round(span / grid);
int arrayZ = round(span / grid);

// default is 25, 170, 205, 125
int[] rgb = new int[4];

// float array to store the received data
float[] nums = new float[6000];

// define the UDP Object
UDP udpr; 

// decide which stage is on
int phase = 0;

float ang = 0.0f;

// Store all the points
Points[] pts = new Points[arrayX*arrayY*arrayZ];
Points[] dest = new Points[arrayX*arrayY*arrayZ];

// ArrayList<Points> pts = new ArrayList<Points>();
// ArrayList<Points> dest = new ArrayList<Points>();

// Array for motion generation
float []jitterX = new float[arrayX*arrayY*arrayZ];
float []jitterY = new float[arrayX*arrayY*arrayZ];
float []jitterZ = new float[arrayX*arrayY*arrayZ];

float thredhold = 1000f;
int loopCount = 0;

int loop = 0;


float upperLimit = 104;
float downLimit = 75;

Points attr;

PeasyCam cam;


// Decide the center of chaotic ball
Points center = new Points(0, 0, 0);

// SyphonServer server;

void setup()
{
  size(1500, 1000, P3D);
  // frameRate(100);
  cam = new PeasyCam(this, 200);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(10000);
  background(0);
  smooth();
  
  connectGH_start(udpr);
  
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

  rgb[0] = 20;
  rgb[1] = 1;
  rgb[2] = 152;
  rgb[3] = 239;

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
  
  switch(phase)
  {
    case 0:
      sphere(pts);
      break;
    case 1:
      connectGH_draw(nums, pts, dest, center);
      break;
    case 2:
      ground(pts);
      break;
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

// data retrieve from UDP server
void receive(byte[] data) {  // <-- extended handler


  // get the "real" message =
  // forget the ";\n" at the end <-- !!! only for a communication with Pd !!!
  data = subset(data, 0, data.length);
  String message = new String( data );
  nums = float(split(message, "\n"));

  // println(nums[5438]);
  // background(255, 0, 255);
}


// keyboard testing
void keyPressed() 
{
  // thredhold control
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      phase++;
    } else if (keyCode == DOWN) 
    {
      phase--;
    }
    else if (keyCode == RIGHT) 
    {
      thredhold+=5;
      println(thredhold);
    } 
    else if (keyCode == LEFT) 
    {
      thredhold-=5;
      println(thredhold);
    }
  }
}