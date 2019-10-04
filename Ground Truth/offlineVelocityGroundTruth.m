function [dq,time_out] = offlineVelocityGroundTruth( q, time )
% offlineVelocityGroundTruth - obtaining the ground truth velocity through
% zero-phase-shift filtering and finite differience
%
% Syntax:  
%    [dq,time_out] = offlineVelocityGroundTruth(q,time)
%
% Input:
%     time  - m x 1 vector of time
%     q     - m x 6 matrix of position q for each time step
%
% Output:
%     time_out - time vector of dq
%     dq       - ground truth velocity
%
%
% Author:       Stefan Liu
% Written:      04-Oct-2019  
% Last update:  ---
% Last revision: ---

%------------- BEGIN CODE --------------

tSample = time(2)-time(1);
freq=1/tSample;

%% Step 1: Zero-phase-shift filtering
% For 500 Hz roughly [50 50 50 70 130 130]
cutoff = 26;

persistent d
if isempty(d)
    d = designfilt('lowpassfir','FilterOrder',7,'SampleRate',freq, ...
        'CutoffFrequency',cutoff);
end
q_filt = zeros(size(q));

for i=1:6
    % Apply Filter
    q_filt(:,i) = filtfilt(d,q(:,i));
end


%% Step 2: Offline Finite Difference
dq = (q_filt(3:end,:) - q_filt(1:end-2,:))/(2*tSample);
time_out=time(2:end-1);

end

