# Velocity Estimation of Robot Manipulators: An Experimental Comparison---by S.B. Liu, A. Giusti, and M. Althoff
This repository consists of data and functions to evaluate the experimental results presented in the manuscript. 

Requires MATLAB.

### Folder Contents
- *Robot Model*: contains the kinematic and dynamic model of the Schunk LWA-4P robot, which has been used for simulation and model-based observers
- *Trajectories*: contains the desired trajectories used for tuning and experiments
- *Ground Truth*: contains MATLAB functions for obtaining the ground truth velocity x2^g from position x1
- *Experiment 1*: contains data of the open-loop step response experiment
- *Experiment 2a*: contains data of the closed-loop comparison (without sensor faults)
- *Experiment 2b*: contains data of the closed-loop comparison (with sensor faults)
