
function R = setPRY(roll,pitch,yaw)

cr = cos(roll); 
sr = sin(roll); 
cp = cos(pitch); 
sp = sin(pitch); 
cy = cos(yaw); 
sy = sin(yaw); 


 R(1, 1) = cp * cy; 
 R(1, 2) = cy * sr * sp - cr * sy; 
 R(1, 3) = sr * sy + cr * cy * sp; 
 R(2,1) = cp * sy; 
 R(2,2) = sr * sp * sy + cr * cy; 
 R(2,3) = cr * sp * sy - cy * sr; 
 R(3,1) = -sp; 
 R(3,2) = cp * sr; 
 R(3,3) = cr * cp; 


end