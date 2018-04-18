import processing.serial.*;

// constants
int ARDUINO_PORT_INDEX = 5;
int ARDUINO_PORT_NUMBER = 9600;
int DELAY = 1250;

boolean IS_ARDUINO_CONNECTED = true;


// vars
Serial arduinoPort;
String arduinoPortName;

int delayEndTime = -1;

boolean isCycleRunning = false;


// processing setup
void settings() {
  size(320, 320, P2D);
}

void setup() {
  background(0);
  frameRate(30);
  
  initArduinoSerial();
  restartDelay();
}

void draw() {
  background(0);
  
  // quick exit
  if (!isCycleRunning) {
    return;
  };
  
  // restart timer if end time met/passed
  if (millis() >= delayEndTime) {
    isCycleRunning = false;
    println("delay completed (" + millis() + ")");
    
    sendToArduino();
    
    restartDelay();
  }
}


// methods definitions
void initArduinoSerial() {
  if (!IS_ARDUINO_CONNECTED) {
    println("Warning: Arduino board disconnected.");
    return;
  }
  
  printArray(Serial.list());

  arduinoPortName = Serial.list()[ARDUINO_PORT_INDEX];
  println("port name: " + arduinoPortName + ", index: " + ARDUINO_PORT_INDEX);

  arduinoPort = new Serial(this, arduinoPortName, ARDUINO_PORT_NUMBER);
}

void restartDelay() {
  isCycleRunning = true;
  delayEndTime = millis() + DELAY;
}

void sendToArduino() {
  if (!IS_ARDUINO_CONNECTED || arduinoPort == null) {
    return;
  }
  
  arduinoPort.write(1);
}