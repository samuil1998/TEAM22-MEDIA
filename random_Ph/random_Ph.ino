int pH = 0;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop()
{
  // put your main code here, to run repeatedly:
  pH = random(15);
  Serial.println(pH);
  delay(1000);
  
}
