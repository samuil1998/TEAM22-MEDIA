int pH = 0;
int temp = 0;
int rot = 0;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop()
{
  // put your main code here, to run repeatedly:
  pH = random(14);
  temp = random(50);
  rot = random(1000);
  
  Serial.print('H'); // 'H' is the header marking the beginning of the message
  Serial.print(",");
  Serial.print(pH,DEC);
  Serial.print(",");
  Serial.print(temp,DEC);
  Serial.print(",");  
  Serial.print(rot,DEC);
  Serial.print(","); 
  Serial.println(); //sending a "\n" or LF to mark the end of the message
  delay(500);  //minimum delay needed for the transferring of messages
  
}
