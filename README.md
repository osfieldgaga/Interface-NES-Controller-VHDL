# Interface-NES-Controller-VHDL
Interface a NES Controller using a Spartan-3 FPGA Starter Board

This mimics the signals sent from the NES Console to it's controller.
The controller responds with the state of each button.

The NES controller is a fairly easy device to understand. It uses a shift register to capture the state of the buttons and sends the information as a stream of bits.
The operation is said to be from parallel to serial.

### How the controller works

The NES uses a serialized polling mechanism to query the state of the buttons. Every 60 Hz, the NES sends a 12us high signal to the Latch pin, telling the controller to latch the state of of all buttons internally. Six microseconds later, the NES sends 8 high pulses on the Pulse pin, 12us per full cycle, 50% duty cycle.

After the initial wide pulse on the Latch pin, Data goes high until the eighth pulse passes, at which point it drops low again. For each pulse on the Pulse pin, Data will assert ground if the button corresponding to that pulse was pressed. (The button states on Data are thus negative true.) The button order is always the same: A, B, Select, Start, Up, Down, Left, Right.

_Source: Tresi Arvizo (https://tresi.github.io/nes/)_
 
A finite state machine with 19 states can be used to mimic the signals sent by the NES Console to the controller. Each state sets the value of the pulse and the latch signal to either 1 or 0. Each state is a half clock cycle, which makes it easier to simply read the data at the corresponding state.

![response+states](https://user-images.githubusercontent.com/29616448/166157754-e0847db4-6da0-4749-bf8f-5411e8441877.png)

Note that my data line isn't the cleanest signal ever, but it doesn't really matter because the button's state is active low. When it's pressed, it's represented by a 0 on the Data line. Simply put, 0 = pressed, anything else = not pressed.

More on how the controller communicated the state of the buttons (this is what I actually used, thanks to them):
https://tresi.github.io/nes/

All we need to do is obtain a Latch signal, then 8 Pulse signals, and read the value of the Data line on the falling edge of the Pulse signal.
Note that it's easier to use the Latch signal as reference to read the state of the A button, and that the last Pulse doesn't give the state of any button, it can be used to know when the stream has ended.

If you're like me and have a Famiclone controller (a copycat of the original NES Controller), this will be useful:

![famiclone](https://user-images.githubusercontent.com/29616448/166157383-18038cdb-df62-4f9d-bd2d-07de5a3f5a12.png)

It basically shows the location of each pin on the Famiclone controller. Keep in mind that strobe = latch and clock = pulse.

Finally, here's a video on YouTube explaining how the NES Controller works. Thanks to their channel as well!

https://www.youtube.com/watch?v=dahbvSYV0KA

### Simulation

Just in case you're curious, this is what the simulation looks like using the Xilinx tool

![image](https://user-images.githubusercontent.com/29616448/166158670-ba98e7e6-f848-4f70-8926-63e07795d2e9.png)
