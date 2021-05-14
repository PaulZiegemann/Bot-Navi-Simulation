
function [ax,ay] = calcTraj2(sp,ep,sv,ev,sa,ea)

TC = 0.5;
PC = [TC^0, TC^1, TC^2, TC^3, TC^4, TC^5];
VC = [0, 1*TC^0, 2*TC^1, 3*TC^2, 4*TC^3, 5*TC^4];

M = [1,        0,     0,     0,     0,     0;
     0,        1,     0,     0,     0,     0;
     1,        1,     1,     1,     1,     1;
     0,        1,     2,     3,     4,     5;
     PC(1), PC(2), PC(3), PC(4), PC(5), PC(6);
     VC(1), VC(2), VC(3), VC(4), VC(5), VC(6)];
 
 bx = [sp(1) ep(1) sg(1) eg(1) sa(1) ea(1)];
 by = [sp(2) ep(2) sg(2) eg(2) sa(2) ea(2)];
 
 ax(1,:) = linesolve(M, bx);
 ay(2,:) = linesolve(M, by);
 
end