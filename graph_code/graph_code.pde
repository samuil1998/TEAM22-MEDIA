/* Program written by Chris Obasi for COMP101P coursework.
It takes input values of temperature that an arduino is writing to serial,
and displays them on a scrolling temperature-time graph. */

import processing.serial.*;

Serial myPort;

String temperature;
int[] values  = new int[10];
int int_temperature;
//String port = "COM5";

void setup() {
  String portName = Serial.list()[1];
  //println(portName);
  myPort = new Serial(this, portName, 9600);
  
  size(800, 400);
}

void draw() {
  
  background(255);
  stroke(0);
  frameRate(1);
  
  //axes labels
  text("°C", 10, 200);
  text("Time(s)", 400, 380);
  
  axis(30, 360, 780, 360, 0); //x axis
  axis(30, 340, 30, 20, 1); //y axis
  
  String temperature = myPort.readStringUntil('\n');
  if (temperature != null) {
    int int_temperature = int(Integer.parseInt(temperature.trim()));
    println(temperature);
        //println(val);
  }
  
  println(int_temperature);
  
  /*Every frame, all the values in the 'values' array are moved down,
  the new incoming temperature value is added to the end of the array,
  and all the values are drawn.*/
  
  for (int i = 0; i < values.length - 1; i++) {
    values[i] = values[i + 1];
  }
  
  values[values.length - 1] = int_temperature;
  
  for (int k = 1; k <= values.length - 1; k++) {
    line(60 + ((k - 1) * 74), 360 - (values[k-1] * 4), 60 + (k * 74), 360 - (values[k] * 4));
  }
}
    
    
/*This function draws arrows for the axes. If the 'numbers' parameter is set to 1,
which I specify for the y axis, it also draws numbers and horizontal lines*/
void axis(int x1, int y1, int x2, int y2, int numbers) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
  line(30, 20, 30, 360);
  
  int counter = 90;
  
  if (numbers == 1) {
    for (int j = 30; j < height; j += 40) {
      fill(0, 0, 0);
      text(counter, 30, j - 30);
      stroke(0, 0, 0);
      line(30, j - 30, 770, j - 30);
      counter -= 10;
    }
  }
} 