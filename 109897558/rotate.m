% q = [ 0.1826    0.3651    0.5477    0.7303]
% invQ = qInv(q)

q = [sin(pi/4);0;cos(pi/4);0]
p = [0;1;1]
pRot = rotateQuat(q,p)

