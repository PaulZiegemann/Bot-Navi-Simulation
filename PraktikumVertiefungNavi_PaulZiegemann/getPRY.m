
function [roll,pitch,yaw] = getPRY(R)

    yaw = atan2(R(2,1), R(1,1));
    cy = cos(yaw);
    sy = sin(yaw);
    
    pitch = atan2(-R(3,1), R(1,1) * cy + R(2,1) * sy);
    roll = atan2(-R(1,3) * cy - R(2,3) * cy, R(2,2) * cy - R(1,2) * cy);
    
end
