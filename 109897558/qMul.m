function [ qResult ] = qMul( q1, q2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    w1 = q1(1)
    v1 = q1(2:4)
    w2 = q2(1)
    v2 = q2(2:4)
    qResult = [w1*w2 - v1'*v2;w1*v2 + w2*v1 + cross(v1,v2)]
end

