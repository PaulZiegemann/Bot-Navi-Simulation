
function [ax,ay] = calcTraj(sp, ep, sg, eg, sa, ea)

M = [1,0,0,0, 0, 0;
     0,1,0,0, 0, 0;
     0,0,2,0, 0, 0;
     1,1,1,1, 1, 1;
     0,1,2,3, 4, 5;
     0,0,2,6,12,20];
 
 bx = [sp(1) ep(1) sg(1) eg(1) sa(1) ea(1)];
 by = [sp(2) ep(2) sg(2) eg(2) sa(2) ea(2)];
 
 ax = linesolve(M, bx);
 ay = linesolve(M, by);
 
end