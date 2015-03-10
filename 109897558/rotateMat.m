function pRot = rotateMat( R, p )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if size(p) ~= [3,1]
        p = p'
    end
    
    pRot = R * p

end

