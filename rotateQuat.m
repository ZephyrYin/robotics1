function [ pRot ] = rotateQuat( q,p )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    pQ = qMul(qMul(q,[0;p]),qInv(q))
    pRot = pQ(2:4)
end

