# Robot-simulation-using-fuzzy-logic
Robot dynamic obstacle avoidance using fuzzy logic via Coppeliasim and Matlab
1. Dynamic obstacles (Pioneer and R2D2 robots) are programmed through the child script inside Coppeliasim.
2. 3 ultrasonic sensors input from the main pioneer robot are sent to the pioneer.m matlab file.
3. Inputs are processed through the fuzzy inference system article_fuzzy.fis.
4. 2 outputs for left and right motor produced from the FIS are sent to the copelliasim file (matlab_vrep).
5. Add path to matlab before running the program.
6. Run the robot simulation before running the matlab simulation.
7. Realtime sensor value are updated in the commmand window.
8. Video demonstration: https://www.youtube.com/watch?v=cGoHG_bfBHA
