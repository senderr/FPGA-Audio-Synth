# FPGA-Audio-Synth
**A mini audio synthesizer that can be run on an Altera DE1-SoC FPGA controlled by a PS-2 Keyboard**

This project combines audio from 3 oscillators to generate sound.
Each oscillator has customizable enable, waveform, octave, gain, and ASDR controls.

**HOW TO USE:**

1. Create a project in Quartus Prime with the source files.
2. Connect a PS2 controller to the DE1_SoC board.
3. Compile and load the program onto the DE1_SoC board.
4. Press KEY[0] to reset all of the registers and be taken to the main menu.

**Loading Oscillators**
1. To load an oscillator, raise **one** of the following switches and press KEY[3] to begin the loading process

* SW[0]=oscA_config
* SW[1]=oscB_config
* SW[3]=oscC_config
* SW[7]=oscA_ASDR
* SW[8]=oscB_ASDR
* SW[9]=oscC_ASDR

**For config settings:**  
*press KEY[1] to save and choose the next setting*  
*press KEY[2] to save and go back to the main menu*  

a. Use the switches to set the value for enable (0/1)  
b. Use the switches to set the value for waveform (0 = square, 1 = sine)  
c. Use the switches to set the value for gain (0-15)  
d. Use the switches to set the value for octave (0-3)  

*Control is transferred back to the main menu after cycling through all config settings.*

**For ASDR settings:**   
*press KEY[1] to save and choose the next setting*  
*press KEY[2] to save and go back to the main menu*  

a. Use the switches to set the value for attack (0-15)  
b. Use the switches to set the value for decay (0-15)  
c. Use the switches to set the value for sustain (0-15)  
d. Use the switches to set the value for decay (0-15)  


*Control is transferred back to the main menu after cycling through all ASDR settings.*
