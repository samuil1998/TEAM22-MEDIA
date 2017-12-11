
void setup(){
  size(1920,1000);
}
void draw(){
// sketch of frames
 //for testing, delete when apply
 float temp = random(50);
 float pH = random(14);
 float rot = random (2400);


smooth();
background(255);
frameRate(1);

stroke(#F5F5F5);
strokeWeight(2);
fill(#F5F5F5);
rect(30,30,620,950,3,20,3,65);
rect(1270,30,620,950,3,20,3,65);
  
  // this is for sketching thermometer (celcius)

 noStroke();
 fill(#696969);
 ellipse(250,750,65,65);

 stroke(#696969);
 strokeWeight(28);
 line(250,750,250,419);
  
 stroke(255);
 strokeWeight(13);
 line(250,725,250,425);
  
 noStroke();
 fill(#DC143C);
 ellipse(250,750,50,50);
  
 
 //higher bond of input value of map is random, need to be changed later
 float mappedTempc = map (temp,0,50,0,300);
 stroke(#DC143C);//red
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

 float mappedTempf = map (temp,0,50,0,415);
 stroke(#1E90FF);//blue
 line(130,840,130,840-mappedTempf);


//for thermometerS axis
 fill(#696969);
 PFont Label;
 Label=loadFont("BellMTBold-15.vlw");
 textFont(Label);
 for (int i =1; i<11;i++)
    text (i*5+(" —"), 203, 750-i*32.5);//20.5

 for (int i =1; i<13;i++)
     text (i*10+(" —"),80,840-34.5*i);
 
 


//for ph scale
 PImage phScale;
  phScale=loadImage("phscale.png");
  image(phScale,730,400);
  //line(750,411,750,918);918-411=507
  float mappedpH = map (pH,0,14,0,507);
  noStroke();
  fill(0);
  triangle(755,411+mappedpH, 820, 407+mappedpH, 820, 415+mappedpH);
 
 
//text outline
stroke(#1E90FF);//blue
strokeWeight(5);
line(320,570,320,630);//temp f
stroke(#DC143C);
line(320,450,320,510);//RED temp c
stroke(#7CFC00);//green
line(1390,450,1390,510);
stroke(0);
line(880,450,880,510);//ph

//for LABELS display
 text(("curent temperature in reactor (Fahrenheit)"), 326, 630);
 text(("curent temperature in reactor (Celcius)"), 326, 510);
 text(("curent pH value in reactor"), 886, 510);
 text(("curent stirring rate in reactor"), 1396, 510);

 
 
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
}