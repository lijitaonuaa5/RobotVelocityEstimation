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
load('4ms_SliMod_run1')

%% Compute Ground Truth
[dq_g,time_dq] = offlineVelocityGroundTruth(q,time);

%% Compute ISE
Tsample = 0.004;
de = dq_g-dq_hat(2:end-1,:); %estimation error signal

ISE = sum(sum(de.^2*Tsample),2); % integral squared error (from t_start to t_end), equation (7)
