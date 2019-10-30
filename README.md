# universe-sim
This is another project I am making in processing. It simulates the gravitational forces objects have and the effects they have on other objects in the universe.

To run this code just download the "universe.pde" file and then open it in processing, then hit play in the upper left hand corner.

It is initialized with some bodies already in the simulation but to change what appears at the start, you need to go into the code and find the setup function. Inside of there are some lines of code that read as: bodies.add ( new Body(...) ). These lines are used to initialize each of the celestial bodies. 

syntax: bodies.add ( new Body(x-coordinate, y-coordinate, x-diameter, y-diameter, mass, starting x velocity, starting y velocity, color) );

color needs to be passed as: color(Red, Greeen, Blue);
