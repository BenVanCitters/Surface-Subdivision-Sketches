// http://www.openprocessing.org/visuals/?visualID=6268
// wrestled into VJ compatible MIDI form by Jay Silence

import themidibus.*;
 
// MIDI bus for parameter input via Akai LPD8
MidiBus myBus;

boolean debug = false;
void initLPD8()
{
   if (debug) MidiBus.list(); // List all available Midi devices on STDOUT. 
  // Create a new MidiBus with Akai input device and no output device.
  myBus = new MidiBus(this, "LPD8", -1);
}

// Handle keyboard input
void keyPressed()
{

  
  ////////////////////
  switch(key){
    case 'd':
      debug = !debug;
      println("Debug Output" + (debug?"enabled":"disabled"));
      break;
    case 's':
      saveFrame("screenCaptures/img-######.png");
      break;
   case 'r':

      break;
  }
}
 
// MIDI Event handling
void noteOn(int channel, int pad, int velocity) {
  // Receive a noteOn
  if(debug) {
    print("Note On - ");
    print("Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value: "+velocity);
  }
  switch(pad){
    case 36:
      break;   
    default:
      break;   
  }
}

 
// Right now we are doing nothing on pad release events
void noteOff(int channel, int pad, int velocity) {
    // Receive a noteOff
  if(debug) {
    print("Note Off - ");
    print(" Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value "+velocity);
  }
}

float normalDisplacementFactor = 0;
int subdivRecurDepth = 1;
float overallScale = .01;
float globalTimeScale = 1;
void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if(debug) {
    print("Controller Change - ");
    print("Channel "+channel);
    print(" - Number "+number);
    println(" - Value "+value);
  }
   
  switch(number){
    case 1:  // = K1
      overallScale = 3*value/128.f;
      break;
    case 2: // = K2
      float maxDispl = 8;
      normalDisplacementFactor = value*maxDispl/128.f;
//.01+mouseX*25.f/width
      break;  
    case 3: // = K3
      subdivRecurDepth = 1+(5*value)/128;
      break;  
    case 4: // = K4
      globalTimeScale = .0001+2*value/128.f;
      break;  
    case 5: // = K5
//      gFlySpeed = value/
      break;  
    default:
      break;   
  } 
}

