function [ coM ] = computeH( t1, t2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[pointCnt temp] = size(t1);
A = zeros(2*pointCnt, 9);
for i = 1 : pointCnt
    A(i * 2 - 1 , :) = [t1(i, 1), t1(i, 2), 1, 0, 0, 0, -1*t2(i, 1)*t1(i, 1), -1*t2(i, 1)*t1(i, 2), -1*t2(i, 1)];
    A(i * 2, :) = [0, 0, 0, t1(i, 1), t1(i, 2), 1, -1*t2(i, 2)*t1(i, 1), -1*t2(i, 2)*t1(i, 2), -1*t2(i, 2)];
end


% A = [x(1) y(1) 1 0 0 0 -u(1)*x(1) -u(1)*y(1) -u(1);
%      0 0 0 x(1) y(1) 1 -v(1)*x(1) -v(1)*y(1) -v(1);
%      x(2) y(2) 1 0 0 0 -u(2)*x(2) -u(2)*y(2) -u(2);
%      0 0 0 x(2) y(2) 1 -v(2)*x(2) -v(2)*y(2) -v(2);
%      x(3) y(3) 1 0 0 0 -u(3)*x(3) -u(3)*y(3) -u(3);
%      0 0 0 x(3) y(3) 1 -v(3)*x(3) -v(3)*y(3) -v(3);
%      x(4) y(4) 1 0 0 0 -u(4)*x(4) -u(4)*y(4) -u(4);
%      0 0 0 x(4) y(4) 1 -v(4)*x(4) -v(4)*y(4) -v(4)];
 
%b = zeros(pointCnt*2,1);

[V, D] = eig(A'*A);           
 
[xS,yS] = size(D);
min = 100000;
index = -1;
for i = 1:xS
    if D(i,i) < min
        min = D(i,i);
        index = i;                         % find minest eigenvalue
    end
end

co = V(:,index);                        % find the eigenvetor
%co = co./co(9);                            % turn the last to 1

coM = reshape(co,3,3)';                     % turn to matrix
end

