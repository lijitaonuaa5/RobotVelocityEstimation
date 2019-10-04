% evaluateExperiment2a - Example function for evaluating results the closed-loop
% performance of each estimator
%
%
%
% Author:       Stefan Liu
% Written:      04-Oct-2019  
% Last update:  ---
% Last revision: ---

%------------- BEGIN CODE --------------

%% Load file
load('2ms_LinHG')

%% Compute Ground Truth
Tsample = 0.002;
[q,count] = correctSensorFaults(q,Tsample);
dq_g = offlineVelocityGroundTruth(q,time);

%% Compute ISE of Axis 6
de = dq_g(:,6)-dq_hat(2:end-1,6); %estimation error signal

ISE = sum(de.^2*Tsample); % integral squared error (from t_start to t_end), equation (7)
