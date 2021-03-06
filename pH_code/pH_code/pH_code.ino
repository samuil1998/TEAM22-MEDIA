const int inputPin = P1_2;
const int acidPin = P1_4;
const int basePin = P1_5;
double pH  = 0;
double volt = 0;

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode (inputPin, INPUT);
  pinMode (acidPin, OUTPUT);
  pinMode (basePin, OUTPUT);

}

void loop()
{
  // put your main code here, to run repeatedly:
    volt = analogRead (inputPin);
    pH = (volt - 2.8)/(-0.16);
    Serial.println(pH);
    
    if(pH >= 5.5)
    {
      analogWrite(acidPin, 128);
      digitalWrite(basePin, LOW);
    }
    else if(pH <= 4.5)
    {
      digitalWrite(acidPin,LOW);
      analogWrite(basePin,128);
    }
    else
    {
      digitalWrite(acidPin,LOW);
      digitalWrite(basePin,LOW);
    }
    
    delay(1000);
}
