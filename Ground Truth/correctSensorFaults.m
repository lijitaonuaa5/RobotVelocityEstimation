function [q_corr,count] = correctSensorFaults(q,Tsample)
% correctSensorFaults - detect and correct faults due communication delays for Schunk
% LWA-4P
%
% Syntax:  
%    [q_corr,count] = correctSensorFaults(q,Tsample)
%
% Input:
%     Tsample  - sampling time
%     q     - m x 6 matrix of position q for m time steps
%
% Output:
%     q_corr   - corrected position matrix
%     count       - count number of detected faults
%
%
% Author:       Stefan Liu
% Written:      04-Oct-2019  
% Last update:  ---
% Last revision: ---

%------------- BEGIN CODE --------------

count = zeros(1,6);
q_corr = q;
fr = 1/Tsample;
dq = (q(2:end,:)-q(1:end-1,:))/Tsample;

for i=2:size(dq,1)-1
    % Correct delays
    for j=1:6 % all 6 axes
        if dq(i,j) == 0 && abs(dq(i+1,j)) > 1.5*abs(dq(i-1,j)) && abs(dq(i+1,j))>0.03
            q_corr(i+1,j) = (q_corr(i+2,j)+q_corr(i,j))/2;
            dq(:,j) = fr*(q_corr(2:end,j)-q_corr(1:end-1,j));
            count(j) = count(j)+1;
        elseif dq(i,j) == 0 && abs(dq(i+1,j)) < 1.5*abs(dq(i-1,j)) && abs(dq(i+1,j))>0.03 % clean delay
            q_corr(i+1,j) = q_corr(i+2,j);
            dq(i:i+1,j) = fr*(q_corr(i+1:i+2,j)-q_corr(i:i+1,j));
            count(j) = count(j)+1;
        end
    end
end
end

