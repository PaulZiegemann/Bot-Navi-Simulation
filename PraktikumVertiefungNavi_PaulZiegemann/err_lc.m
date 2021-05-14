
function err = err_lc(x, delta_real, start, locSoll)

pose_tmp = start(1,:);

for k = 1 : length(delta_real) -1
    pose_tmp = motionModel(pose_tmp, [delta_real(k+1,1)*x(1)]);
end

err = (locSoll(1) - pose_tmp(1))^2 + (locSoll(2) - pose_tmp(2))^2;
end