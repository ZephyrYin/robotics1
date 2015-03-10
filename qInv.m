function [ invQ ] = qInv( q )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    if size(q) ~= [4,1]
        q = q'
    end
    if q == [0;0;0;0]
        invQ = q
    else
        invQ = -q
        invQ(1) = invQ(1) * -1
        invQ = invQ /(sqrt(q'*q))
    end
end

