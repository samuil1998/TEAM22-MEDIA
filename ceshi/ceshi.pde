//using the Serial library from Sketch/Import Library/Serial
import processing.serial.*;

Serial myPort;        // Create object from Serial class
char HEADER = 'H';    // 'H' is the character indicating the beginning o f the message
short LF = 10;        // ASCII code for linefeed
float pH;
float temp;
float rot;
String temperature;
float[] temps  = new float[10];
float[] phs  = new float[10];
float[] rpms  = new float[10];
float int_temperature;

void settings() {
  size(1920, 1000);
}

void setup() {
  //size(1920, 400);
  
  //IMPORTANT!!! WRITE DOWN YOUR OWN PORT INSTEAD OF "COM1" BEFORE YOU START THE GAME
  myPort = new Serial(this, "COM4", 9600);
}

//this part reads the serial port to get data from the Arduino and assign it to variables
void serialEvent(Serial myPort) {

  String message = myPort.readStringUntil(LF); // read serial data

  if (message != null) 
  {
    String [] data  = message.split(","); //split the message into commas
    if (data[0].charAt(0) == HEADER) {   
      
      for ( int i = 1; i < data.length-1; i++) { // skip the header and terminating cr and lf
        int value = Integer.parseInt(data[i]);
        
        if (i == 1) //first value is the light one
        {
          pH = value;
        }
        
        if (i == 2) //second one comes from the potentiometer
        {
          temp = value;
          println(temp);
        }
        
        if (i == 3) //second one comes from the potentiometer
        {
          rot = value;
        }
        
      }
    }
  }
}

void draw() {
 background(255);
 frameRate(5);
 
 
 //background shade. every changes should be made after this
 noStroke();
 fill(#F5F5F5);
 rect(8,0,640,950,3,5,3,78);
 rect(1300,0,620,950,3,5,3,78);
 
  //data
 PFont data;
 data=loadFont("GillSansMT-Bold-35.vlw");
 textFont(data);
 fill(0);
 text(("°C"),215,830);
 text(("°F"), 110,920);
 text(pH, 890,476);
 text(rot+("rpm"),1400,476);
 text(temp+("°C"),330,476);
 text(temp*9/5+32+("°F"), 330,598);
 
 
 //thermoeter c
 fill(#696969);//grey
 ellipse(250,750,65,65);

 stroke(#696969);
 strokeWeight(28);
 line(250,750,250,419);
  
 stroke(255);
 strokeWeight(13);
 line(250,725,250,425);
  
 noStroke();
 fill(#DC143C);//red
 ellipse(250,750,50,50);
   
   //higher bond of input value of map is random, need to be changed later
 float mappedTempc = map (temp,0,80,0,300);
 stroke(#DC143C);//red
 //if (temp <= 50)
 line(250,750,250,750-mappedTempc);
 
 //for thermometer f
 noStroke();
 fill(#696969);
 ellipse(130,840,65,65);

 stroke(#696969);
 strokeWeight(28);
 line(130,840,130,419);
  
 stroke(255);
 strokeWeight(13);
 line(130,825,130,425);
  
 noStroke();
 fill(#1E90FF);
 ellipse(130,840,50,50);

 float mappedTempf = map (temp,0,80,0,415);
 stroke(#1E90FF);//blue
 line(130,840,130,840-mappedTempf);
 
 //for thermometer c&f scale
 fill(#696969);
 PFont Label;
 Label=loadFont("BellMTBold-15.vlw");
 textFont(Label);
 for (int i =1; i<17;i++)
    text (i*5+(" —"), 203, 750-i*20.311);//32.5

 for (int i =1; i<18;i++)
     text (i*10+(" —"),80,840-23.817*i);
     
 //highlights for data
 stroke(#1E90FF);//blue
 strokeWeight(5);
 line(320,570,320,630);//temp f
 stroke(#DC143C);
 line(320,450,320,510);//RED temp c
 stroke(#7CFC00);//green
 line(1390,450,1390,510);
 stroke(0);
 line(880,450,880,510);//ph

 //LABELS for data
 text(("current temperature in reactor (Fahrenheit)"), 326, 630);
 text(("current temperature in reactor (Celcius)"), 326, 510);
 text(("current pH value in reactor"), 886, 510);
 text(("current stirring rate in reactor"), 1396, 510);
 
 
 //for ph scale
 PImage phScale;
 phScale=loadImage("phscale.png");
 image(phScale,730,400);
 //line(750,411,750,918);918-411=507
 float mappedpH = map (pH,0,14,0,507);
 noStroke();
 fill(0);
 triangle(755,411+mappedpH, 823, 407+mappedpH, 823, 415+mappedpH);

  
  //GRAPH 1
  
  stroke(0);
  strokeWeight(1);
  
  //axes labels
  text("°C", 10, 200);
  text("Time(s)", 300, 380);
  
  axis(30, 360, 630, 360, 0, 0, 0); //x axis
  axis(30, 340, 30, 20, 1, 630, 80); //y axis
  
  for (int i = 0; i < temps.length - 1; i++) {
    temps[i] = temps[i + 1];
  }
  
  temps[temps.length - 1] = temp;
  
  for (int k = 1; k <= temps.length - 1; k++) {
    line(60 + ((k - 1) * 60), 360 - (temps[k-1] * 4), 60 + (k * 60), 360 - (temps[k] * 4));
  }
  
  //GRAPH 2
  
  int g2x = 650;
  //axes labels
  text("pH", 10 + g2x, 200);
  text("Time(s)", 300 + g2x, 380);
  
  axis(30 + g2x, 360, 630 + g2x, 360, 0, 0, 0); //x axis
  axis(30 + g2x, 360, 30 + g2x, 20, 1, 630 + g2x, 16); //y axis
  
  for (int i = 0; i < phs.length - 1; i++) {
    phs[i] = phs[i + 1];
  }
  
  phs[phs.length - 1] = pH;
  
  for (int k = 1; k <= phs.length - 1; k++) {
    line(60 + ((k - 1) * 60) + g2x, 360 - (phs[k-1] * 20), 60 + (k * 60) + g2x, 360 - (phs[k] * 20));
  }
  
  //GRAPH 3
  
  int g3x = 1300;
  //axes labels
  text("rpm", 10 + g3x, 200);
  text("Time(s)", 300 + g3x, 380);
  
  axis(30 + g3x, 360, 630 + g3x, 360, 0, 0, 0); //x axis
  axis(30 + g3x, 360, 30 + g3x, 20, 1, 630 + g3x, 1600); //y axis
  
  for (int i = 0; i < phs.length - 1; i++) {
    rpms[i] = rpms[i + 1];
  }
  
  rpms[rpms.length - 1] = rot;
  
  for (int k = 1; k <= phs.length - 1; k++) {
    line(60 + ((k - 1) * 60) + g3x, 360 - (rpms[k-1] * 0.2), 60 + (k * 60) + g3x, 360 - (rpms[k] * 0.2));
  }
}

void axis(int x1, int y1, int x2, int y2, int numbers, int xend, int maxy) {
  
  int step = maxy / 8;
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  line(x1, 20, x1, 360);
  
  int counter1 = maxy + step;
  
  if (numbers == 1) {
    for (int j = 30; j < height && counter1 >= 0; j += 40) {
      fill(0, 0, 0);
      text(counter1, x1, j - 30);
      stroke(0, 0, 0);
      line(x1, j - 30, xend, j - 30);
      counter1 -= step;
    }
  }
}